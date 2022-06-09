--Поиск персоны с конкретным возрастом 100, 50 и 20
select * from Person where Age = 100 or Age = 50 or Age = 20
select * from Person where Age in (100, 50, 20)