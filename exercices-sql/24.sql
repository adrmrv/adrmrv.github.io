/*Afficher les nombre de 100 à 10 compris, par ordre décroissant*/
--schema

--schema

--title Nombres de 100 à 10

--data

--data

--solution
; with cte as (
  select 10 s
  union all
  select s+1 from cte
  where s+1 <= 100
  )
select * from cte
order by s desc
--solution

--test

--test
