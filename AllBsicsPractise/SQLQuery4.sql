USE [college]
GO
/****** Object:  Table [dbo].[student]    Script Date: 15-09-2026 02:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student](
	[college_id] [int] NOT NULL,
	[name] [varchar](50) NULL,
	[department] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[phone_num] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[college_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[student] ([college_id], [name], [department], [city], [phone_num]) VALUES (1, N'Sunny', N'IT', N'Lucknow', NULL)
GO
INSERT [dbo].[student] ([college_id], [name], [department], [city], [phone_num]) VALUES (2, N'Hunny', N'CSE', N'Jaunpur', NULL)
GO
INSERT [dbo].[student] ([college_id], [name], [department], [city], [phone_num]) VALUES (3, N'Ram', N'CSD', N'Varanasi', NULL)
GO
INSERT [dbo].[student] ([college_id], [name], [department], [city], [phone_num]) VALUES (4, N'Hunny', N'IT', N'Jaunpur', 789541265)
GO
update student 
set name = 'Ram'
where college_id = 3
go

Select * 
From student 
order by college_id DESC;
Select * From student
order by city DESC;
go


Select top 2 *
From student 
--where name like 'S%';
where city in ('Lucknow' , 'Jaunpur')
And department in('IT', 'CSE')
--AND phone_num is not NULL
order by college_id ASC;

alter table student 
add email VARCHAR(55);
go

alter table student 
add age Int;
go 
update student
set age =
case 
when name = 'Sunny' then 20
when name = 'Hunny' then 17
when name = 'Ram' then 50
end 
where name in ('Sunny' ,'Hunny' , 'Ram');
go

select * from student;

--for single values 
update student 
set email = 'sunny@gmail.com'
where name = 'Sunny';
go
--for multiple values
update student
set email = 
case 
when name = 'Sunny' then 'sunny@gmail.com'
when name = 'Hunny' then 'hunny@gmail.com'
end 
where name in ('Sunny', 'Hunny');
go


--display college_ID name and department 
Select college_id , name , department
from student;
-- find all student whose city is jaunpur
select * from student 
where city = 'Jaunpur'
and department ='IT'

--students live in lko and vns
select * from student

where city in ('Lucknow', 'Varanasi');
go

select * from student 
--where college_id between 2 and 4
 where name like 'S%' AND name like '%y';

 Select * from student 
 --where phone_num is NULL;
 where phone_num is not NULL;

 select Distinct * from student 
 order by name ASC, college_id DESC;

 --top
 select top 4 * from student 
 order by college_id DESC;

 -- display only name department and city for students who beloong to IT or CSE sorted by deparrtment and then name
 Select  name , department , city from student 
 where department in ('IT' , 'CSE')
 order by department ASC , name ASC;

 --Adding new student 
 Insert into student (college_id , name , department , city , phone_num ,email)
 values(5,'Akhil','BT','Kanpur', NULL, Null);
 select * from student;

  update student 
  set city = 'Delhi'
  where college_id =5;


update student 
set email =
CASE
When name ='Akhil' then 'akhil@gmail.com'
when name = 'Ram' then 'Ram@gmail.com'
end 
where name in ('Akhil', 'Ram');

select * from student

--Count
Select count(*) as total_student 
from student 
group by department;


--Having 
select count (*) as total_students
from student
group by city
having count(*) =1 ;

select count (*) as total_students
from student
where city= 'Jaunpur'
group by department
having count(*) >=1;

Select count(*) as total_student
from student


Select count (*) as total_student
from student
where phone_num is Null

Select  count(*) as total_student
from student 
where city ='Jaunpur';

Select count(*) as total_student 
from student
group by department;


Select count (*)  as total_student
from student
Group BY city;

Select count(*) as total_student 
from student
group by department
having count(*) >1;

Select count(*) as total_student 
from student
group by city
Having count(*) >=2;

Select MIN(college_id) as total_student
from student;

Select MAX(college_id) as total_student
from student;

SELECT department, COUNT(*) AS total_students
FROM student
WHERE city IN ('Jaunpur', 'Lucknow')
GROUP BY department
HAVING COUNT(*) >= 2
ORDER BY total_students DESC;


Select 
name,
age,
CASE 
 When age <20 then 'Teen'
 When age Between 20 and 36 then 'Young'
 Else 'Adult'
 end as age_category
 From student;
 Select 
 Case 
 When phone_num Is Null then 'Missing'
 else 'Available'
 End as Phone_status,
 Count(*) As total_Student
 from student 
 group by 
 case 
 when phone_num is null then 'Missing'
 Else 'Available'
 End;

 ---Phase2
 select 
    name, 
	upper(name) AS Upper_case
	from student;
 
 Select 
 email,
 lower(email) AS lower_email
 From student;

 Select name,
 len(name) As length_name
 from student;

 Select name from student
 where len(name) > 4 ;

 Select name,
 left(name ,3) as name_prefix
 from student;

 select name,
  Right(name , 2) as Name_suffix

  from student;

  select name,
  substring(name , 2 ,4) as name_substring
  from student;

  Select 
  Concat(name, '-' , city) as student_info
  from student;


  select 
  concat(name ,'-', department ,'-' , city) as student_info
  from student;

  select 
  name,
  trim(name) as student_trim
  from student
    where len(trim(name)) > 4 ;
  
Select name,
Len(name) as name_length,
Case
when Len(name) > 4 then 'Long Name'
else 'Short Name'
End as name_category
from student;
 go

 --combined case + group 
 select 
 case 
 when len(name) > 5 then 'Long Name'
 else 'Short Name'
 End as Name_category,

 count(*) as total_students
 from student 
 group by 
 case 
 when len(name) > 5 then 'Long Name'
 else 'Short Name'
  End;
  




  Select 
  Upper(name) as Student_name,
  lower(city) As name_lenght,
  len(name)  as name_length,
  case 
  when len(name) > 4 then 'Long'
  Else 'Short'
  End as name_category
  from student 
  where department IN ('It' , 'CSE')
  order by len(name) DESc;
  go


  select * from student
   select *  into newtable 
  from student;
