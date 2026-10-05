create database phase6
go
use phase6
go

CREATE TABLE EmployeeAnalytics
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(30),
    Salary INT,
    JoinDate DATE,
    MonthlySales DECIMAL(10,2)
);

INSERT INTO EmployeeAnalytics
(EmployeeID, EmployeeName, Department, Salary, JoinDate, MonthlySales)
VALUES
(1, 'Aman',   'IT',      75000, '2023-01-10', 45000),
(2, 'Riya',   'IT',      82000, '2022-06-15', 52000),
(3, 'Karan',  'IT',      75000, '2024-02-20', 48000),

(4, 'Neha',   'HR',      60000, '2022-03-12', 30000),
(5, 'Rahul',  'HR',      65000, '2023-07-05', 35000),
(6, 'Priya',  'HR',      65000, '2024-01-18', 38000),

(7, 'Arjun',  'Finance', 80000, '2021-09-25', 55000),
(8, 'Sneha',  'Finance', 85000, '2022-11-10', 62000),
(9, 'Vikas',  'Finance', 80000, '2023-08-22', 58000),

(10, 'Anjali','IT',      90000, '2021-05-14', 70000);


--(OVER()
   ↓
--PARTITION BY
   ↓
--ROW_NUMBER()
   ↓
--RANK()
   ↓
--DENSE_RANK()
   ↓
--Top-N per group
   ↓
--LAG()
   ↓
--LEAD()
   ↓
--SUM() OVER()
   ↓
--Running Total
   ↓
--AVG() OVER()
   ↓
--Moving Average
   ↓
--UNION / UNION ALL
   ↓
--INTERSECT / EXCEPT
   ↓
Views
   ↓
--Basic Optimization)


SELECT *
FROM EmployeeAnalytics;
--Avg salary by using both over and groupby 
Select * ,
AVG(Salary) OVER() AS CompanyAVGSalary -- this is for whole company avg
from EmployeeAnalytics;s

Select * ,
 AVG(Salary) over(partition by department) As DepartmentAVGSalary
 from EmployeeAnalytics;-- this is department wise Average salary

SELECT Department,
       AVG(Salary) as departmentAVGSalary
FROM EmployeeAnalytics
GROUP BY Department;


SELECT
    EmployeeName,
    Department,
    Salary,
    AVG(Salary) OVER(PARTITION BY Department) AS DepartmentAvgSalary,
    Salary - AVG(Salary) OVER(PARTITION BY Department) AS Difference
FROM EmployeeAnalytics;


--total sales by the Department 

select * ,
 Sum(MonthlySales) over(Partition by Department) As Totalsales
 from EmployeeAnalytics;

--ROW_number

Select EmployeeName, 
Department ,
Salary,
Row_Number() Over(Partition by Department
Order by Salary DESC) as RowNumber
From EmployeeAnalytics;


--Rank number,, DENSE_RANK()
Select EmployeeName,
Department, 
Salary,
Row_Number()  over(  Order by Salary DESC)  As Rownumber,
Rank() over(  Order by Salary DESC)  As Ranknumber,
DENSE_RANK() over(  Order by Salary DESC)  As DENSERanknumber
From EmployeeAnalytics;

Select EmployeeName,
Department,
MonthlySales,
Rank() Over (partition by Department Order by MonthlySales DESC) AS RankNumber
From EmployeeAnalytics;



--LAG(....)

Select EmployeeName,
Department,
Salary,
LAG(Salary) OVER(partition by Department Order by Salary DESC) As com_prev_Salary
From EmployeeAnalytics;

Select EmployeeName,
Salary,
LAG(Salary) Over(Order by Salary DESC) As Comp_PREV_Salary,
Salary - LAG(Salary) Over(Order by Salary DESC) As Difference
From EmployeeAnalytics;

--lead()
-- Show next employee salary
SELECT
    EmployeeName,
    Salary,
    LEAD(Salary) OVER(
        ORDER BY Salary DESC
    ) AS NextSalary
FROM EmployeeAnalytics;

--Sum()

--NOrmal sum

Select sum(Salary) 
From EmployeeAnalytics;

--Function
Select EmployeeName,
Salary,
Sum(Salary) OVer(ORder by Salary DESC)  as TotalSalary
From EmployeeAnalytics;

SELECT
    EmployeeName,
    MonthlySales,
    SUM(MonthlySales) OVER(
        ORDER BY EmployeeID
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS RunningTotal
FROM EmployeeAnalytics;



SELECT
    EmployeeName,
    Department,
    MonthlySales,
    SUM(MonthlySales) OVER(
        PARTITION BY Department
        ORDER BY EmployeeID
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS DeptRunningTotal
FROM EmployeeAnalytics;

--Union and Union ALL

SELECT EmployeeName
FROM EmployeeAnalytics
WHERE Salary >= 80000
UNION
SELECT EmployeeName
FROM EmployeeAnalytics
WHERE Department = 'IT';

SELECT EmployeeName
FROM EmployeeAnalytics
WHERE Salary >= 80000
UNION ALL
SELECT EmployeeName
FROM EmployeeAnalytics
WHERE Department = 'IT';


--Intersect and Except 
SELECT EmployeeName,
Department, Salary
FROM EmployeeAnalytics
WHERE Department = 'IT'
EXCEPT
SELECT EmployeeName,Department,Salary
FROM EmployeeAnalytics
WHERE Salary >= 80000;


SELECT EmployeeName,Department , Salary
FROM EmployeeAnalytics
WHERE Department = 'IT'
INTERSECT
SELECT EmployeeName,Department,Salary
FROM EmployeeAnalytics
WHERE Salary >= 80000;

--first_value and last_value
SELECT
    EmployeeName,
    Department,
    Salary,

    FIRST_VALUE(Salary) OVER(
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS HighestSalary,

    LAST_VALUE(Salary) OVER(
        PARTITION BY Department   --UNBOUNDED PRECEDING → start from first row
                                    ---UNBOUNDED FOLLOWING → go all the way to last row
        ORDER BY Salary DESC
        Rows Between UNBOUNDED Preceding 
        AND UNBOUNDED following 
    ) AS LowestSalary

FROM EmployeeAnalytics;
