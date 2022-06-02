create trigger trEmployeeForUpdate
on EmployeeTrigger
for update
as begin
	--Мы объявили переменные, которые будем использовать
	Declare @Id int
	declare @OldName nvarchar(30), @NewName nvarchar(30)
	declare @OldSalary int, @NewSalary int
	declare @OldGender nvarchar(10), @NewGender nvarchar(10)
	declare @OldDeptId int, @NewDeptId int
	--переменная, которую мы будем использовать для создания сборки аудита
	declare @AuditString nvarchar(1000)
	--вводит данные во временную таблицу
	select * into #TempTable
	from inserted

	while(exists(select Id from #TempTable))
	begin
		--инициализация пустой строкой
		Set @AuditString = ''

		--мы выбираем первую строку данных из временной таблицы 
		select top 1 @Id = Id, @NewName = Name,
		@NewGender = Gender, @NewSalary = Salary,
		@NewDeptId = DepartmentId
		from #TempTable

		--выбирает текущую строку из удаленной таблицы
		select @OldName = Name,
		@OldGender = Gender, @OldSalary = Salary,
		@OldDeptId = DepartmentId
		from deleted where Id = @Id

		--мы строим строку аудита, чтобы она была динамической
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

		--удаляет всю информацию из временной таблицы
		delete from #TempTable where Id = @Id
	end
end
