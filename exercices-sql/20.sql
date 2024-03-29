/*Pour chaque niveau (5e et 6e), donner la deuxième meilleure note jamais obtenue ansi que la matiere dans laquelle elle a été obtenue. Afficher dans l'ordre : le niveau, la matiere puis la note. Trier par ordre de niveau.*/
--schema
create table eleve (ele_id, ele_nom, ele_prenom, cla_id);
create table matiere (mat_id, mat_nom, mat_categorie, mat_coef);
create table note (not_id, ele_id, mat_id, not_note);
create table classe (cla_id, cla_nom, cla_niveau);
--schema

--title Deuxieme meilleure note dans chaque niveau

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
with cte as (
select cla_niveau, m.mat_nom, n.not_note, row_number() over (partition by cla_niveau order by not_note desc) rang
from classe c
inner join eleve e on e.cla_id = c.cla_id
inner join note n on n.ele_id = e.ele_id
inner join matiere m on m.mat_id = n.mat_id
)
select cla_niveau, mat_nom, not_note
from cte
where rang = 2
order by cla_niveau
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
