select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees