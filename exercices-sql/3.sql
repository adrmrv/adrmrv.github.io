/*Trier les villes suivantes par ID décroissant. Afficher toutes les colonnes mais uniquement les deux dernieres lignes.*/
--schema
create table ville (ville_id, insee_code, zip_code, nom, gps_lat, gps_lng)

--schema

--title Les deux plus grandes : ORDER BY + LIMIT
--data
insert into ville values

(1, 1001, 1400, "Abergement-Clémenciat", 46.156781992032, 4.9246992031872),

(2, 1002, 1640, "Abergement-de-Varey", 46.010085625, 5.4287591666667),

(3, 1004, 1500, "Ambérieu-en-Bugey", 45.958409392265, 5.3759920441989),

(4, 1005, 1330, "Ambérieux-en-Dombes", 46.000120392157, 4.9106016993464),

(5, 1006, 1300, "Ambléon", 45.746426904762, 5.6024917857143)
--data

--solution
select * from ville order by ville_id desc limit 2
--solution

--test

--test