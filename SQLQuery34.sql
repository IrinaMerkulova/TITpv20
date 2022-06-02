create trigger trEmployeeDetails_InsteadOfDelete
on vEmployeeDetails
instead of delete
as begin
	delete EmployeeTrigger
	from EmployeeTrigger
	join deleted
	on EmployeeTrigger.Id = deleted.Id
end