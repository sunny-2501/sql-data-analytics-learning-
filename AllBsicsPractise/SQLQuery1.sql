Create Database SQLBasics 
use SQLBasics
go

Create table Employees(
Emp_ID INT Primary key,
FirstName VARCHAR(90),
LastName VARCHAR(90),
Department VARCHAR(90),
Salary Decimal(10,2)
);
insert into Employees(Emp_ID , FirstName,LastName , Department,Salary)
Values
(1, 'John', 'Doe', 'HR', 55000.00),
(2, 'Jane', 'Smith', 'IT', 75000.00),
(3, 'Emily', 'Jones', 'Finance', 65000.00),
(4, 'Michael', 'Brown', 'IT', 80000.00),
(5, 'Sarah', 'Davis', 'HR', 60000.00),
(6, 'David', 'Wilson', 'Finance', 70000.00),
(7, 'Laura', 'Garcia', 'IT', 72000.00),
(8, 'Robert', 'Miller', 'HR', 58000.00),
(9, 'Sophia', 'Martinez', 'Finance', 67000.00),
(10, 'James', 'Anderson', 'IT', 81000.00);

drop table Employees

SELECT * from Employees


Select * from Employees
where Department = 'IT'

Select * from Employees where Salary >70000


Select * from Employees order by LastName ASC

--or 
Select * From Employees order by LastName

Select distinct(Department) from Employees


Select Department, count(*) as totalEmployess 
from Employees
group by department  

select MAX(Salary) as MaximumSalary from Employees

Select AVG(Salary) as AVGSalary from Employees


select * from Employees
where LastName like 'M%'


select * from Employees
where Department = 'IT' AND Salary > 70000;



select * from Employees
where Department = 'HR' AND Salary < 60000;

Select * from Employees 
where Department not in ('Finance');


Select * from Employees 
where Salary between 60000 and 70000
and Department in ('Finance');

SELECT *
FROM Employees
WHERE Salary >= 55000
  AND Department IN ('HR', 'Finance');

Select * from Employees 
where LastName like 'D%' 
AND Department not in ('Hr');

