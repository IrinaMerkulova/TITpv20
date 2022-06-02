create trigger trEmployeeDetailsInsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = Department.Id
	from Department 
	join inserted
	on inserted.DepartmentName = Department.DepartmentName

	if(@DeptId is null)
	begin
		raiserror('Invalid Department Name. Statement terminated', 16, 1)
		return
	end
	end