/*
Voici une liste de menus d'un logiciel de traitement de texte.<br>
Ils sont fournis sous la forme Nom / id du menu parent. <br>
Vous devez récupérer chaque menu sous la forme d'un fil d'ariane, par exemple : « Fichier > Nouveau > Document vide »<bn>
Affichez les fils d'ariane par ordre alphabétique. Utilisez l'opérateur || pour concaténer des chaines de caractères.
*/
--schema
create table menu (id, nom, parent);
--schema

--title Le fil d'ariane

--data
insert into menu values
(1, "Fichier", NULL),
(2, "Edition", NULL),
(3, "Affichage", NULL),
(4, "Nouveau", 1),
(5, "Document texte", 4),
(6, "Classeur", 4),
(7, "Commentaire", 2),
(8, "Résolu", 7),
(9, "Supprimer", 7),
(10, "Normal", 3);

--data

--solution
; with cte as (
  select id, nom fil from menu where parent is null
  union
  select m.id, c.fil || " > " || m.nom
  from menu m
  inner join cte c on m.parent = c.id
)
select fil from cte
order by fil
--solution

--test

--test
