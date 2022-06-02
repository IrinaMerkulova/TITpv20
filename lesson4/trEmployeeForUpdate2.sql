create trigger trEmployeeForUpdate2 -- Trigger for logging delta changes on table EmployeeTrigger
on EmployeeTrigger
for update
as begin
	-- deklareerisime muutujad, mida hakkame kasutama
	Declare @Id int
	declare @OldName nvarchar(30), @NewName nvarchar(30)
	declare @OldSalary int, @NewSalary int
	declare @OldGender nvarchar(10), @NewGender nvarchar(10)
	declare @OldDeptId int, @NewDeptId int
	-- muutuja, millega hakkame ehitama audit build-i
	declare @AuditString nvarchar(1000)
	-- sisestab andmed temp table-sse
	select * into #TempTable
	from inserted

	while(exists(select Id from #TempTable))
	begin
		-- tühja stringi initsialiserimine
		Set @AuditString = ''

		-- selekteerime esimese rea andmed temp table-st 
		select top 1 @Id = Id, @NewName = Name,
		@NewGender = Gender, @NewSalary = Salary,
		@NewDeptId = DepartmentId
		from #TempTable

		-- selekteerib käesoleva rea kustutatud tabelist
		select @OldName = Name,
		@OldGender = Gender, @OldSalary = Salary,
		@OldDeptId = DepartmentId
		from deleted where Id = @Id

		--- ehitame audit stringi dünaamiliseks
		set @AuditString = 'Employee with Id = ' + cast(@Id as nvarchar(4))
		+ ' changed '

		if(@OldName <> @NewName)
			set @AuditString = @AuditString + ' Name from ' + @OldName + ' to '
			+ @NewName

		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to '
			+ @OldGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' 
			+ CAST(@OldSalary as nvarchar(10))
			+ ' to ' + CAST(@NewSalary as nvarchar(10))

		if(@OldDeptId <> @NewDeptId)
			set @AuditString = @AuditString + ' DepartmentId from ' 
			+ CAST(@OldDeptId as nvarchar(10))
			+ ' to ' + CAST(@NewDeptId as nvarchar(10))

		insert into EmployeeAudit values(@AuditString)

		-- kustutab kogu info temp table-st
		delete from #TempTable where Id = @Id
	end
end

select * from EmployeeTrigger

update EmployeeTrigger set Name = 'Todd123', Salary = 3456,
Gender = 'Female', DepartmentId = 3 
where Id = 4

select * from EmployeeTrigger
select * from EmployeeAudit