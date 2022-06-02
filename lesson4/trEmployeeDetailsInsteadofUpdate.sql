alter trigger trEmployeeDetailsInsteadOfUpdate
on vEmployeeDetailsUpdate -- Изменение триггера на обновление, чтобы показать дельту изменения таблицы.
instead of update
as begin
	if(update(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(UPDATE(DeptName))
	begin
		declare @DeptId int
		select @DeptId = Department.Id
		from Department
		join inserted
		on inserted.DeptName = Department.DeptName

		if(@DeptId is null)
		begin
			raiserror('Invalid Department Name', 16, 1)
			return
		end

		update EmployeeTrigger set DepartmentId = @DeptId
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(update(Gender))
	begin
		update EmployeeTrigger set Gender = inserted.Gender
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(UPDATE(Name))
	begin
		update EmployeeTrigger set Name = inserted.Name
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end

	if(UPDATE(Salary))
	begin
		update EmployeeTrigger set Salary = inserted.Salary
		from inserted
		join EmployeeTrigger
		on EmployeeTrigger.Id = inserted.Id
	end
end