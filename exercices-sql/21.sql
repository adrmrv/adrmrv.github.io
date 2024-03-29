/*Le lycée organise une compétition dans laquelle chaque élève doit affronter tous les autres. Calculer la liste de tous les match et afficher pour chaque match les deux noms qui doivent s'affronter. Trier les résultats par ordre alphabétique.*/
--schema
create table eleve (ele_id, ele_nom, ele_prenom, cla_id);
create table matiere (mat_id, mat_nom, mat_categorie, mat_coef);
create table note (not_id, ele_id, mat_id, not_note);
create table classe (cla_id, cla_nom, cla_niveau);
--schema

--title Compétition et matchs 1x1

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
select e.ele_nom, ee.ele_nom
from eleve e
cross join eleve ee
where e.ele_id <> ee.ele_id
order by e.ele_nom, ee.ele_nom   
--solution

--test
insert into eleve values
(1, "Martel", "Camille", 1),
(2, "Dijoux", "William", 2),
(3, "Gomez", "Yves", NULL),
(5, "Navarro", "Francoise", 5);
insert into matiere values
(1, "Francais", "Litteraire",1),
(2, "Mathematiques", "Scientifique", 2),
(3, "Histoire", "Litteraire",1),
(4, "Physique", "Scientifique", 2);
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
