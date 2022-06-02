create trigger trEmployeeForUpdate
on EmployeeTrigger
for update
as begin
	select * from deleted
	select * from inserted
end

--Выводит информацию об обновлениях в таблице