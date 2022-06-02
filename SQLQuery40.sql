create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end