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

"";WITH FirstCTE AS
(
    ...
),
SecondCTE AS
(
    ...
)
SELECT ...""



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


