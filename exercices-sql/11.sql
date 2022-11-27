/*Calculer la moyenne par matiere, tous élèves confondus. Afficher le nom de la matiere ainsi que la moyenne. Trier les résultats de la moyenne la plus élevée à la plus basse.*/

--title Calculer la moyenne avec GROUP BY et INNER JOIN

--schema
create table eleve (ele_id, ele_nom, ele_prenom, cla_id);
create table matiere (mat_id, mat_nom, mat_categorie);
create table note (not_id, ele_id, mat_id, not_note);
create table classe (cla_id, cla_nom, cla_niveau);
--schema

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
select m.mat_nom, avg(n.not_note) moyenne
from note n
inner join matiere m on n.mat_id = m.mat_id
group by m.mat_nom
order by moyenne desc
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
(1, 1, 2, 19),
(2, 2, 1, 12),
(2, 2, 3, 2),
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