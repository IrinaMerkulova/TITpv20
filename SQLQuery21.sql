select max(cast(Age as int)) from Person

select City, sum(cast(Age as int)) as TotalAge from Person group by City