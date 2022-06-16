create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end