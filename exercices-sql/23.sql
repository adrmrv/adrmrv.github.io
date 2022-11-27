/*
Voici une liste de scores de joueurs d'échecs et de go. Vous devez afficher les prochains matchs 1x1 de telle sorte que les meilleurs joueurs d'échecs affrontent 
les meilleurs joueurs de go, dans cet ordre.<br><br>
Dans l'ordre, affichez les colonnes suivantes :<br>
<ol>
<li>Nom (echecs)</li>
<li>Prénom (echecs)</li>
<li>Nom (go)</li>
<li>Prénom (go)</li>
<li>Rang aux échecs ET au go</li>
</ol>
*/
--schema
create table resultat (id, nom, prenom, jeu, score);
--schema

--title Meilleur contre meilleur

--data
insert into resultat values
(1, "Martel", "Camille", "echecs", 1000),
(2, "Dijoux", "William", "go", 1200),
(3, "Gomez", "Yves", "echecs", 1300),
(4, "Martineau", "Astrid", "go", 1100),
(5, "Navarro", "Francoise", "echecs", 1400),
(6, "Mathieu", "Laurence-Inès", "go", 900),
(7, "Boutin", "Céline", "echecs", 1500),
(8, "Humbert", "Benjamin", "go", 1120),
(9, "Fleury", "Thierry", "echecs", 900),
(10, "Mallet", "Jérôme Le", "go", 800),
(11, "Bourdon", "Audrey-Dominique", "echecs", 1600),
(12, "Hernandez-Roche", "Antoine", "go", 1010),
(13, "Traore", "Dorothée", "echecs", 1900),
(14, "Wagner", "Étienne", "go", 1900);

--data

--solution
; with echecs as (
    select *, row_number() over (order by score desc) rang
    from resultat 
    where jeu = 'echecs'
 ), go as (
     select *, row_number() over (order by score desc) rang
     from resultat 
     where jeu = 'go'
   )
 
 select e.nom, e.prenom, g.nom, g.prenom, e.rang
 from go g
 inner join echecs e on e.rang = g.rang
 order by e.rang asc
--solution

--test

--test
