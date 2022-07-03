
$(document).ready(function () {
	var params = new URLSearchParams(document.location.search);
	var id = params.get("id");

	$.get("" + id + ".txt", function (data) {
		$("#schema").text(/\[schema\](.*)\[\/schema\]/s.exec(data)[1])
		$("#data").text(/\[data\](.*)\[\/data\]/s.exec(data)[1])
		$(".tit").text(/\[title\](.*)\[\/title\]/s.exec(data)[1])
		$("#test").text(/\[test\](.*)\[\/test\]/s.exec(data)[1])
		$("#solution").text(/\[solution\](.*)\[\/solution\]/s.exec(data)[1])
		$("#enonce").text(/(.*?)\[/s.exec(data)[1])

		ready();
	});

	var te = document.getElementById("tecode");
	window.editor = CodeMirror.fromTextArea(te, {
		mode: "sql",
		lineNumbers: true,
		lineWrapping: true,
	});
})


function ready() {
	var sqlSchema = $("#schema").text();
	var sqlData = $("#data").text();


	config = {
		locateFile: filename => `https://cdnjs.cloudflare.com/ajax/libs/sql.js/1.6.2/${filename}`
	}

	var db;

	initSqlJs(config).then(function (SQL) {

		db = new SQL.Database();

		db.run(sqlSchema);
		db.run(sqlData);

		context = { tables: [] };
		t = 0;

		for (const match of sqlSchema.matchAll(/create table ([\w\d_]+)/gi)) {
			const stmt = db.prepare("SELECT * FROM " + match[1]);
			stmt.getAsObject({ $start: 1, $end: 1 });

			headersDone = false;

			context.tables.push({ name: match[1], columns: [], rows: [] })
			r = 0;
			do {
				const row = stmt.getAsObject();
				context.tables[t].rows[r] = { fields: [] };
				for (const [title, value] of Object.entries(row)) {
					if (!headersDone) {
						context.tables[t].columns.push(title)

					}
					context.tables[t].rows[r].fields.push(value);
				}

				++r;
				headersDone = true;
			} while (stmt.step())

			++t;
		};

		var source = document.getElementById("entry-template").innerHTML;
		var template = Handlebars.compile(source);

		document.getElementById("entry-template").outerHTML = template(context);
	});


	function compareResults(res, res2) {

		if (!res && !res2)
			return false;

		if (!!res != !!res2)
			return false;

		if (res.columns.length != res2.columns.length)
			return false;

		if (res.values.length != res2.values.length)
			return false;

		for (r = 0; r < res.values.length; ++r) {
			for (c = 0; c < res.values[r].length; ++c) {
				if (res.values[r][c] != res2.values[r][c]) {
					return false;
				}
			}
		}

		return true;
	}

	$("#corriger").click(function () {
		var soluce = $("#solution").text();

		var failure = false, sqlerror = "";
		$(".alert-success").hide()
		$(".alert-danger").hide()
		$("#disp-fail").hide()
		$("#sql-error").hide()
		$("#result-display").hide()

		var sqlData = $("#data").text()
		var reponse = window.editor.doc.cm.getValue()

		for (const match of sqlSchema.matchAll(/create table ([\w\d_]+)/gi)) {
			db.run("DELETE FROM " + match[1]);
		}


		try {
			db.run(sqlData);
			var att = db.exec(soluce)[0];
			var rep = db.exec(reponse)[0];
		} catch (ex) {
			sqlerror = ex.message;
		}

		if (!compareResults(rep, att)) {
			$(".alert-success").hide()
			$(".alert-danger").show()
			$("#result-display").show()

			var source = document.getElementById("result-template").innerHTML;
			var template = Handlebars.compile(source);

			document.getElementById("result-display").innerHTML =
				template({ name: "Votre résultat", values: rep?.values, columns: rep?.columns })
				+ template({ name: "Résultat attendu", values: att.values, columns: att.columns });

			failure = true;
		}

		$("#test").each(function (index, elem) {
			if (failure)
				return;

			var sqlData = $(elem).text()

			if (!/\w/.exec(sqlData)) {
				return;
			}

			for (const match of sqlSchema.matchAll(/create table ([\w\d_]+)/gi)) {
				db.run("DELETE FROM " + match[1]);
			}

			try {
				db.run(sqlData);
				var att = db.exec(soluce)[0];
				var rep = db.exec(reponse)[0];
			} catch (ex) {
				sqlerror = ex.message;
			}

			if (!compareResults(rep, att)) {
				$(".alert-success").hide()
				$(".alert-danger").show()
				$("#result-display").show()

				var source = document.getElementById("result-template").innerHTML;
				var template = Handlebars.compile(source);

				document.getElementById("result-display").innerHTML =
					template({ name: "Votre résultat", values: rep?.values, columns: rep?.columns })
					+ template({ name: "Résultat attendu", values: att.values, columns: att.columns });

				failure = true;
			}
		});

		if (!failure) {
			$(".alert-success").show()
			$("#disp-fail").hide()
			$("#sql-error").hide()

			let searchParams = new URLSearchParams(window.location.search)
			var id = searchParams.get("id")
			var ids = window.localStorage.getItem("ids")?.split(",") ?? []
			if (!ids.includes(id)) {
				ids.push(id)
			}
			window.localStorage.setItem("ids", ids.join(","))

		}

		if (sqlerror) {
			$("#sql-error").show()
			$("#sql-error").text(sqlerror)
		} else {
			$("#sql-error").hide()

		}
	});

	$("#executer").click(function () {

		var failure = false, sqlerror = "";
		$(".alert-success").hide()
		$(".alert-danger").hide()
		$("#disp-fail").hide()
		$("#sql-error").hide()
		$("#result-display").hide()

		var sqlData = $("#data").text()
		var reponse = window.editor.doc.cm.getValue()

		for (const match of sqlSchema.matchAll(/create table ([\w\d_]+)/gi)) {
			db.run("DELETE FROM " + match[1]);
		}

		db.run(sqlData);

		try {
			var rep = db.exec(reponse)[0];
		} catch (ex) {
			sqlerror = ex.message;
		}

		if (sqlerror) {
			$("#sql-error").show()
			$("#sql-error").text(sqlerror)
		} else {
			$("#sql-error").hide()
			$("#result-display").show()
		}

		var source = document.getElementById("result-template").innerHTML;
		var template = Handlebars.compile(source);

		document.getElementById("result-display").innerHTML =
			template({ name: "Résultat", values: rep?.values, columns: rep?.columns });

	});
};
