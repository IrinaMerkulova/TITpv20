declare @TotalCount int
exec spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount