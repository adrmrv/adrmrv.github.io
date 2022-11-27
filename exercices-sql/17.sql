/*Afficher la 3e note la plus élevée ansi que le nom de l'élève l'ayant obtenue et la matiere correspondante*/
--schema
create table eleve (ele_id, ele_nom, ele_prenom, cla_id);
create table matiere (mat_id, mat_nom, mat_categorie);
create table note (not_id, ele_id, mat_id, not_note);
create table classe (cla_id, cla_nom, cla_niveau);
--schema

--title Troisième note la plus élevée

--data
insert into eleve values
(1, "Martel", "Camille", 1),
(2, "Dijoux", "William", 2),
(3, "Gomez", "Yves", 3),
(4, "Martineau", "Astrid", 4),
(5, "Navarro", "Francoise", NULL);
insert into matiere values
(1, "Francais", "Litteraire"),
(2, "Mathematiques", "Scientifique"),
(3, "Histoire", "Litteraire"),
(4, "Physique", "Scientifique");
insert into note values
(1, 1, 2, 19),
(2, 2, 1, 12),
(3, 3, 3, 13),
(4, 5, 2, 3),
(5, 4, 4, 11);
insert into classe values
(1, "6A", 6),
(2, "6B", 6),
(3, "5A", 5),
(4, "5B", 5),
(5, "5C", 5);
--data

--solution
with cte as (select *, row_number() over (order by not_note desc) rank from note)
select not_note, ele_nom, mat_nom from cte c
inner join matiere m on m.mat_id = c.mat_id
inner join eleve e on e.ele_id = c.ele_id
where rank = 3
--solution

--test
insert into eleve values
(1, "Martel", "Camille", 1),
(2, "Dijoux", "William", 2),
(3, "Gomez", "Yves", NULL),
(5, "Navarro", "Francoise", 5);
insert into matiere values
(1, "Francais", "Litteraire"),
(2, "Mathematiques", "Scientifique"),
(3, "Histoire", "Litteraire"),
(4, "Physique", "Scientifique");
insert into note values
(1, 4, 2, 20),
(3, 3, 3, 13),
(4, 5, 2, 3),
(5, 4, 4, 11);
insert into classe values
(1, "6A", 6),
(2, "6B", 6),
(3, "5A", 5),
(4, "5B", 5),
(5, "5C", 5);
--test
