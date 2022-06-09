--Просмотр таблицы Person до и после удаления пункта под ID 8
select * from Person
go
delete from Person where Id = 8
go
select * from Person