/*Calculer la moyenne pondérée par matière de chaque classe. Afficher le nom des classe ainsi que leur moyenne en triant de la plus élevée à la plus basse.*/
--schema
create table eleve (ele_id, ele_nom, ele_prenom, cla_id);
create table matiere (mat_id, mat_nom, mat_categorie, mat_coef);
create table note (not_id, ele_id, mat_id, not_note);
create table classe (cla_id, cla_nom, cla_niveau);
--schema

--title Moyenne pondérée par matière

--data
insert into eleve values
(1, "Martel", "Camille", 1),
(2, "Dijoux", "William", 2),
(3, "Gomez", "Yves", 3),
(4, "Martineau", "Astrid", 4),
(5, "Navarro", "Francoise", NULL);
insert into matiere values
(1, "Francais", "Litteraire", 2),
(2, "Mathematiques", "Scientifique", 2),
(3, "Histoire", "Litteraire", 1),
(4, "Physique", "Scientifique", 1);
insert into note values
(1, 1, 2, 19),
(2, 2, 1, 12),
(3, 3, 3, 13),
(4, 5, 2, 3),
(5, 4, 4, 11),
(6, 1, 2, 10),
(7, 2, 1, 2),
(8, 3, 3, 18),
(9, 4, 2, 13),
(10, 5, 4, 12);
insert into classe values
(1, "6A", 6),
(2, "6B", 6),
(3, "5A", 5),
(4, "5B", 5),
(5, "5C", 5);
--data

--solution
select cla_nom, sum(not_note*mat_coef)/sum(mat_coef) moy
from matiere m
inner join note n on n.mat_id = m.mat_id
inner join eleve e on e.ele_id = n.ele_id
inner join classe c on c.cla_id = e.cla_id
group by cla_nom
order by moy desc
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
(2, 3, 3, 13),
(3, 1, 1, 3),
(4, 2, 3, 18),
(5, 5, 2, 3),
(6, 4, 4, 11);
insert into classe values
(1, "6A", 6),
(2, "6B", 6),
(3, "5A", 5),
(4, "5B", 5),
(5, "5C", 5);
--test
