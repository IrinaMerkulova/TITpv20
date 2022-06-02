create proc spGetNameById1
@Id int,
Name nvarchar(50) output
as begin
	select @FirstName = FirstName from employees where Id = @Id
end