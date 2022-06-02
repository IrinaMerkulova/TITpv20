create view vEmployeeDetails
as
select EmployeeTrigger.Id, Name, Gender, DepartmentName
from EmployeeTrigger
join Department
on EmployeeTrigger.DepartmentId = Department.Id