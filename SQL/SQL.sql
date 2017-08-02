--http://www.newthinktank.com/2014/08/mysql-video-tutorial/
--1. How to find nth highest salary in SQL Server using a Sub-Query
--2. How to find nth highest salary in SQL Server using a CTE
--3. How to find the 2nd, 3rd or 15th highest salary

/* To find the highest salary it is straight forward. We can simply use the Max() function as shown below.*/
Select Max(Salary) from Employees
/*To get the second highest salary use a sub query along with Max() function as shown below.*/
Select Max(Salary) from Employees where Salary < (Select Max(Salary) from Employees)

/*To find nth highest salary using Sub-Query*/
SELECT TOP 1 SALARY
FROM (
      SELECT DISTINCT TOP N SALARY
      FROM EMPLOYEES
      ORDER BY SALARY DESC
      ) RESULT
ORDER BY SALARY

/*To find nth highest salary using CTE(CommonTableExpression)*/
WITH RESULT AS
(
    SELECT SALARY,
           DENSE_RANK() OVER (ORDER BY SALARY DESC) AS DENSERANK
    FROM EMPLOYEES
)
SELECT TOP 1 SALARY
FROM RESULT
WHERE DENSERANK = N
/*To find 2nd highest salary we can use any of the above queries. Simple replace N with 2. 
Similarly, to find 3rd highest salary, simple replace N with 3. */

--The delete query should delete all duplicate rows except one. 
--Here is the SQL query that does the job. PARTITION BY divides the query result set into partitions.
WITH EmployeesCTE AS
(
SELECT *, ROW_NUMBER()OVER(PARTITION BY ID ORDER BY ID) AS RowNumber
FROM Employees
)
DELETE FROM EmployeesCTE WHERE RowNumber > 1
SELECT * from Employees

-- Replace N with number of months
Select *   -- , DATEDIFF(DAY/YEAR, HireDate, GETDATE()) Between 1 and 30/1
FROM Employees
Where DATEDIFF(MONTH, HireDate, GETDATE()) Between 1 and N

--Write a sql query to transpose rows to columns. 
--Using PIVOT operator we can very easily transform rows to columns.
Select Country, City1, City2, City3
From
(
Select Country, City, 'City'+ cast(row_number() over(partition by Country order by Country) as varchar(10)) ColumnSequence
from Countries
) Temp
pivot
(
max(City)
for ColumnSequence in (City1, City2, City3)
) Piv

--Write a SQL query to retrieve rows that contain only numerical data.
SELECT Value FROM TestTable WHERE ISNUMERIC(Value) = 1

--SQL query that retrieves the department name with maximum number of employees
SELECT TOP 1 DepartmentName /*,COUNT (*) as EmployeeCount*/
FROM Employees
JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY DepartmentName
ORDER BY /*EmployeeCount desc*/COUNT(*) DESC

--SQL query to retrieve all student names that start with letter 'M' without using the LIKE operator.
SELECT * FROM Students WHERE Name LIKE 'M%'
SELECT * FROM Students WHERE CHARINDEX('M',Name) = 1
SELECT * FROM Students WHERE LEFT(Name, 1) = 'M'
SELECT * FROM Students WHERE SUBSTRING(Name, 1, 1) = 'M'