create trigger trEmployeeDetailsInsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = Department.Id
	from Department 
	join inserted
	on inserted.DeptName = Department.DeptName

	if(@DeptId is null)
	begin
		raiserror('Invalid Department Name. Statement terminated', 16, 1)
		return
	end

	insert into EmployeeTrigger(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end