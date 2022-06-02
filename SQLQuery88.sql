alter table Employees
add LastName nvarchar(30)

update Employees set Name = 'Tom', MiddleName = 'Nick', Name = 'Jones'
where Id = 1
update Employees set Name = 'Pam', MiddleName = NULL, Name = 'Anderson'
where Id = 2
update Employees set Name = 'John', MiddleName = NULL, Name = NULL
where Id = 3
update Employees set Name = 'Sam', MiddleName = NULL, Name = 'Smith'
where Id = 4
update Employees set Name = NULL, MiddleName = 'Todd', Name = 'Someone'
where Id = 5
update Employees set Name = 'Ben', MiddleName = 'Ten', Name = 'Sven'
where Id = 6
update Employees set Name = 'Sara', MiddleName = NULL, Name = 'Connor'
where Id = 7
update Employees set Name = 'Valarie', MiddleName = 'Balerine', Name = NULL
where Id = 8
update Employees set Name = 'James', MiddleName = '007', Name = 'Bond'
where Id = 9
update Employees set Name = NULL, MiddleName = NULL,Name = 'Crowe'
where Id = 10
