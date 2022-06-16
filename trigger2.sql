create trigger EmployeeForDelete
on EmployeeTrigger
for delete
as begin
	declare @Id int
	select @Id = Id from deleted
	
	insert into EmployeeAudit
	values('An existing employee with Id = ' + CAST(@Id as nvarchar(5))
	+ ' is deleted at ' + cast(GETDATE()as nvarchar(20)))
end