USE Phase6;


GO


SELECT *
FROM   EmployeeAnalytics;

SELECT name
FROM   Sys.Databases;

SELECT name
FROM   Sys.tables;
--1
;WITH   EmployeeData
AS     (SELECT EmployeeName,
               Department,
               Salary
        FROM   EmployeeAnalytics
        WHERE  Department IN ('IT', 'Hr'))
SELECT *
FROM   EmployeeData
WHERE  Salary > 75000;
---2  Aggregate Functions 
;WITH   departmentsalary
AS     
(
SELECT   
                 Department,
                 AVg(Salary) as salary
        FROM     EmployeeAnalytics
        GROUP BY Department        )
SELECT *
FROM   departmentsalary
WHERE  salary > 70000;

--
;With SalaryData As
(
 Select 
 EmployeeName,
 Department,
  Salary,
  AVG(Salary) OVER( Partition by Department) As DeptAVG
  from EmployeeAnalytics
  )
  Select *
  from SalaryData
  Where Salary > DeptAvg;


---Find the top 2 highest-paid employees in each department
--Using ROW-Number()
;With RankedEmployees as 
(
Select EmployeeName,
Department,
Salary,
Row_Number () Over (Partition by Department 
Order by Salary Desc) As RowNum
From EmployeeAnalytics
)
Select * From RankedEmployees
where RowNum <= 2;


--Using Dense_Rank()

;With RankedEmployees as 
(
Select EmployeeName,
Department,
Salary,
Dense_Rank () Over (Partition by Department 
Order by Salary Desc) As DenseNum
From EmployeeAnalytics
)
Select * From RankedEmployees
where DenseNum <= 2;



--Multiple CTE 
--''Table
--  ↓
--CTE
  --↓
--Final Query'' -- this is single CTE Idea 

--Multiple CTE IDea
"Table
  ↓
CTE 1 → first calculation
  ↓
CTE 2 → use CTE 1 result
  ↓
Final Query"


--Syntax for the Mutliple CTE 

--"";WITH FirstCTE AS
--(
  --  ...
--),
--SecondCTE AS
--(
  --  ...
--)
--SELECT ...""



--Q1 Find employees whose salary is greater than the average salary of their own department.

;with DepartmentAVG As
(
Select Department , AVG(Salary)  as  AVGSalary
From EmployeeAnalytics
Group by Department
),
employeecomparison As
(
Select e.EmployeeName,
       e.Department,
       e.Salary,
       d.AVGSalary
       From EmployeeAnalytics e 
       Join DepartmentAVG d 
       on e.Department = d.Department

)
 Select * from employeecomparison 
 where Salary > AVGSalary;

 ---Find employees whose MonthlySales are greater than the average MonthlySales of their own department.

 ;with monthlysale as 
 (
  Select Department, Avg(MonthlySales) as SalesAVG
   from EmployeeAnalytics 
   Group by Department
),
SaleComparison As 
(
 Select e.EmployeeName,
        e.Department,
        e.Salary,
        e.MonthlySales,
        d.SalesAVG
        from EmployeeAnalytics e 
        join monthlysale d 
        on e.Department = d.Department
    )
     Select * from SaleComparison
     where MonthlySales > SalesAVG;

---CTE chaining 
--First calculate average Salary and average MonthlySales for every department.
--Then create another CTE containing only departments whose average monthly sales are greater than 40000.
--Finally show only those departments whose average salary is greater than 70000.


;With Departmentsummary as
 (
 Select Department,
 Avg(Salary)  As AvgSalary,
 AVg(MonthlySales) as AVGmonthlysales
 From EmployeeAnalytics 
 Group By Department
 ),
 HighPerformance AS 
 (
 Select * From Departmentsummary 
 Where AVGmonthlysales > 40000
 )

Select * From HighPerformance 
Where AvgSalary > 70000;


--First calculate, for each department:
-- average salary
-- total monthly sales
--Then create a second CTE that keeps only departments where TotalMonthlySales > 100000.
--Finally, from that second CTE, show only departments where AvgSalary > 70000.

;With Departmentstates As
( Select Department,
AVG(Salary) as AvgSalary,
sum(MonthlySales) as TotalMonthlysales
from EmployeeAnalytics 
Group by Department
),
Strongsales As 
(
Select  * From Departmentstates
where TotalMonthlysales> 10000
)

Select * From Strongsales 
where Avgsalary > 70000;


--Recursive  CTE 
--generate numbers from 1 to 5:

;with numbers as
(
Select 1 as Num
 Union All
 Select Num +1 
 From numbers
 where Num <5 
 )
 Select * from Numbers;


 --Views
--creating a view 
Create view  employeesummary As 
Select 
EmployeeName,
Department,
Salary,
MonthlySales
From EmployeeAnalytics;


--Alter Modifiying the exist view
Alter View employeesummary as
Select 
EmployeeName,
Department,
Salary,
MonthlySales,
JoinDate
from EmployeeAnalytics ;

Select * from employeesummary
where Department in ('IT') ANd
salary > 80000;


--Drop

Drop View employeesummary;

DROP VIEW IF EXISTS HighValueEmployees;


