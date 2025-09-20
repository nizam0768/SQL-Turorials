# 📘 Interview Questions and Answers

This repository contains a collection of common technical questions and their answers.  
Use the links below to jump directly to each answer.  

---

## 📑 Table of Contents

1. [What are the main types of SQL commands?](#What-are-the-main-types-of-SQL-commands)
2. [What are the different categories of datatypes in SQL Server?](#What-are-the-different-categories-of-datatypes-in-SQL-Server)
3. [What are Keys in SQL?](#-what-are-keys-in-sql)
4. [What is Normalization in SQL?](#what-is-normalization-in-sql)
5. [What is Denormalization, and When is it Used?](#what-is-denormalization-and-when-is-it-used)
6. [What are the Different Operators Available in SQL?](#what-are-the-different-operators-available-in-sql)
7. [What are Function in SQL?](#What-are-Function-in-SQL)
8. [Window Functions in SQL?](#Window-Functions-in-SQL)
---

## ❓ Questions & Answers

### What are the main types of SQL commands?

SQL commands are broadly classified into:

- **DDL** (**Data Definition Language**): `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.
- **DML** (**Data Manipulation Language**): `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
- **DCL** (**Data Control Language**): `GRANT`, `REVOKE`.
- **TCL** (**Transaction Control Language**): `COMMIT`, `ROLLBACK`, `SAVEPOINT`.

---

### What are the different categories of datatypes in SQL Server?

**🔹 Basic Question**

1. What are the different categories of datatypes in SQL Server?
   - Numeric (int, bigint, decimal, float)
   - Character/String (char, varchar, nchar, nvarchar, text)
   - Date/Time (date, datetime, smalldatetime, datetime2, time)
   - Binary (binary, varbinary, image)
   - Other (bit, uniqueidentifier, sql_variant, xml, json (in SQL 2016+))

**🔹 Numeric Types**

2. Difference between `int`, `bigint`, `smallint`, and `tinyint`?
   - `tinyint` → 0 to 255
   - `smallint` → –32,768 to 32,767
   - `int` → –2,147,483,648 to 2,147,483,647
   - `bigint` → very large (±9 quintillion)
3. When would you use `decimal` vs `float`?
   - `decimal` (fixed precision, good for money, financial data).
   - `float` (approximate, good for scientific/engineering values).
4. What is the difference between `numeric` and `decimal`?
   - Functionally the same; both store fixed precision numbers.

**🔹 String Types**

5. Difference between `char` and `varchar`?
   - `char(n)` → fixed-length (always takes n characters).
   - `varchar(n)` → variable-length (saves storage).
6. Difference between `varchar` and `nvarchar`?
   - `varchar` → stores ASCII (1 byte per character).
   - `nvarchar` → stores Unicode (2 bytes per character). Use for multilingual data.
7. What’s the maximum size of `varchar` and `nvarchar`?
   - `varchar(n)` up to 8,000.
   - `varchar(max)` up to 2GB.
   - `nvarchar(max)` up to 1GB (because Unicode = 2 bytes).

**🔹 Date/Time Types**

8. Difference between `datetime`, `smalldatetime`, and `datetime2`?
   - `smalldatetime` → range 1900–2079, precision to minutes.
   - `datetime` → range 1753–9999, precision to ~3 ms.
   - `datetime2` → larger range, higher precision (100 ns).  
9. What’s the difference between `time`, `date`, and `datetimeoffset`?
   - `time` → stores only time.
   - `date` → stores only date.
   - `datetimeoffset` → includes time zone info.

**🔹 Special/Other Types**

10. What is the `bit` datatype used for?
    - Stores 0, 1, or NULL (boolean-like values).
11. What is a `uniqueidentifier`?
    - Stores a **GUID** (Globally Unique Identifier).
12. What is the difference between `xml` and `json` datatypes?
    - `xml` has its own native datatype.
    - `json` is stored as nvarchar(max) in SQL Server but has JSON functions.
13. What is `sql_variant`?
    - Can hold values of different SQL data types (except text, ntext, timestamp, etc.).

**🔹 Tricky/Advanced Questions**

14. What happens if you insert a string longer than the column size into a `varchar`?
    - Error if `ANSI_WARNINGS` is **ON**, otherwise it truncates.
15. Why would you choose `char` over `varchar`?
    - If all values have the same length (like country codes, postal codes) → better performance.
16. What’s the difference between `money` and `decimal` for currency values?
    - `money` has fixed 4 decimal places, prone to rounding errors.
    - `decimal` is more precise (recommended for finance).
17. What datatype would you choose for storing phone numbers? Why?
    - `varchar`, not numeric → because phone numbers may contain +, –, spaces.

---

### 🔑 What are Keys in SQL?
A **Key** is a column (or combination of columns) in a table that is used to uniquely identify rows or establish relationships between tables.  

Keys help with:
- **Uniqueness** → No duplicate rows where not allowed.  
- **Relationships** → Linking tables together.  
- **Data Integrity** → Enforcing valid, consistent data.  

---

#### 🔹 Types of Keys in SQL

1. **Primary Key**
   - Uniquely identifies each record in a table.  
   - Cannot contain `NULL` values.  
   - Only one primary key per table.  

   ```sql
   CREATE TABLE Employees (
       EmpID INT PRIMARY KEY,
       Name VARCHAR(100),
       Salary DECIMAL(10,2)
   );
2. **Foreign Key**
   - Establishes a relationship between two tables.
   - Refers to the Primary Key of another table.
   - Ensures referential integrity (you cannot insert a value that doesn’t exist in the parent table).
   - Example:
     ```sql
     CREATE TABLE Orders (
     OrderID INT PRIMARY KEY,
     EmpID INT FOREIGN KEY REFERENCES Employees(EmpID)
     );
3. **Candidate Key**
   - Columns that can qualify as a Primary Key.
   - A table can have multiple candidate keys, but only one is chosen as the Primary Key.
   - Example:
      - In `Employees`, both `EmpID` and `Email` could be unique → candidate keys.
4. **Alternate Key**
   - A Candidate Key that was not chosen as the Primary Key.
   - Example: If `EmpID` is `Primary Key`, then Email becomes an Alternate Key.
5. **Composite Key**
   - A key made of two or more columns.
   - Useful when a single column cannot uniquely identify a row.
   - Example:
     ```sql
     CREATE TABLE CourseRegistrations (
     StudentID INT,
     CourseID INT,
     PRIMARY KEY (StudentID, CourseID)
     );
6. **Unique Key**
   - Ensures that all values in a column are unique.
   - Unlike Primary Key, it allows one NULL (depending on DBMS).
   - Example:
     ```sql
     CREATE TABLE Users (
     UserID INT PRIMARY KEY,
     Email VARCHAR(100) UNIQUE
     );
7. **Super Key**
   - A set of one or more columns that can uniquely identify a record.
   - Every Candidate Key is a Super Key, but not every Super Key is minimal.
   - Example: `(EmpID, Name)` is a Super Key, but only `EmpID` is minimal → Candidate Key.

---

### What is Normalization in SQL?
**Normalization** is the process of organizing data in a database to reduce redundancy and improve data integrity.  
It ensures that data is stored efficiently and consistently.  

**Benefits of Normalization:**
- Eliminates redundant data  
- Improves data integrity  
- Simplifies maintenance  
- Optimizes storage  

**Normal Forms (Levels of Normalization) with Examples:**

---

#### 1. First Normal Form (1NF)
**Rule:** Eliminate repeating groups; each column should have atomic values.  

**Unnormalized Table: `Orders`**

| OrderID | Customer | Products          |
|---------|----------|-----------------|
| 1       | Alice    | Pen, Notebook    |
| 2       | Bob      | Pencil, Eraser   |

**1NF Table:**  

| OrderID | Customer | Product   |
|---------|----------|----------|
| 1       | Alice    | Pen      |
| 1       | Alice    | Notebook |
| 2       | Bob      | Pencil   |
| 2       | Bob      | Eraser   |

---

#### 2. Second Normal Form (2NF)
**Rule:** Table is in 1NF and all non-key columns fully depend on the primary key.  
- Remove partial dependency (when a non-key attribute depends on part of a composite key).  

**Example:** `OrderDetails` (after 1NF)  

| OrderID | Product   | Customer | CustomerAddress |
|---------|----------|---------|----------------|
| 1       | Pen      | Alice   | NY             |
| 1       | Notebook | Alice   | NY             |

**2NF Tables:**  

**Orders Table:**  

| OrderID | Customer   | CustomerAddress |
|---------|------------|----------------|
| 1       | Alice      | NY             |
| 2       | Bob        | LA             |

**OrderDetails Table:**  

| OrderID | Product   |
|---------|----------|
| 1       | Pen      |
| 1       | Notebook |
| 2       | Pencil   |
| 2       | Eraser   |

---

#### 3. Third Normal Form (3NF)
**Rule:** Table is in 2NF and no transitive dependency exists.  
- Non-key columns should not depend on other non-key columns.  

**Example:** `Orders` table with transitive dependency  

| OrderID | Customer | CustomerCity | CityState |
|---------|---------|--------------|-----------|
| 1       | Alice   | NY           | NY-State  |

**3NF Tables:**  

**Customers Table:**  

| Customer | City  |
|----------|-------|
| Alice    | NY    |
| Bob      | LA    |

**Cities Table:**  

| City | State   |
|------|---------|
| NY   | NY-State|
| LA   | LA-State|

**Orders Table:**  

| OrderID | Customer |
|---------|---------|
| 1       | Alice   |
| 2       | Bob     |

---

#### 4. Boyce-Codd Normal Form (BCNF)
**Rule:** Every determinant must be a candidate key.  
- Removes anomalies caused by overlapping candidate keys.  

**Example:** `CourseEnrollment`  

| StudentID | CourseID | Instructor |
|-----------|---------|------------|
| 1         | C1      | John       |
| 2         | C1      | John       |
| 1         | C2      | Mike       |

- Here, `Instructor → CourseID` violates BCNF.  

**BCNF Tables:**  

**CourseInstructor Table:**  

| CourseID | Instructor |
|----------|------------|
| C1       | John       |
| C2       | Mike       |

**Enrollment Table:**  

| StudentID | CourseID |
|-----------|---------|
| 1         | C1      |
| 2         | C1      |
| 1         | C2      |

---

#### 5. Fifth Normal Form (5NF)
**Rule:** Table is decomposed so that it cannot be reconstructed from smaller tables without loss.  
- Deals with **join dependencies**.  

**Example:** `ProjectAssignments`  

| Employee | Project | Skill       |
|----------|---------|------------|
| Alice    | P1      | Java       |
| Alice    | P1      | SQL        |
| Bob      | P1      | Java       |

**5NF Tables:**  

**EmployeeSkills Table:**  

| Employee | Skill |
|----------|-------|
| Alice    | Java  |
| Alice    | SQL   |
| Bob      | Java  |

**ProjectSkills Table:**  

| Project | Skill |
|---------|-------|
| P1      | Java  |
| P1      | SQL   |

**ProjectAssignments Table:**  

| Employee | Project |
|----------|---------|
| Alice    | P1      |
| Bob      | P1      |

- Now, the original table can be reconstructed by joining the three tables without redundancy.

---

### What is Denormalization, and When is it Used?

**Denormalization** is the process of intentionally introducing redundancy into a database by combining tables or adding duplicate data.  
It is essentially the opposite of normalization.  

**Purpose / When to Use Denormalization:**
- **Performance Improvement** → Reduces the need for complex joins and speeds up query execution.  
- **Reporting and Analytics** → Makes data retrieval faster in read-heavy systems like data warehouses.  
- **Simpler Queries** → Fewer joins, easier to write and maintain queries.  

**Considerations:**
- Increases storage requirements due to redundant data.  
- May require additional effort to maintain data consistency.  
- Best suited for **read-heavy environments** rather than transactional systems.  

**Example:**

Suppose we have normalized tables:

**Orders Table**

| OrderID | CustomerID | OrderDate |
|---------|------------|----------|
| 1       | 101        | 2025-01-10 |
| 2       | 102        | 2025-01-11 |

**Customers Table**

| CustomerID | CustomerName |
|------------|--------------|
| 101        | Alice        |
| 102        | Bob          |

**Denormalized Table:** Combine both tables for faster reads

| OrderID | CustomerID | CustomerName | OrderDate |
|---------|------------|--------------|----------|
| 1       | 101        | Alice        | 2025-01-10 |
| 2       | 102        | Bob          | 2025-01-11 |

- Now queries can fetch **order and customer info from a single table** without joins.  

---

### What are the Different Operators Available in SQL?

SQL operators allow you to perform operations on data. They can be broadly categorized as follows:

---

#### 1. Arithmetic Operators
Used for mathematical calculations:

| Operator | Description               | Example         |
|----------|---------------------------|----------------|
| `+`      | Addition                  | `SELECT 5 + 3;` |
| `-`      | Subtraction               | `SELECT 5 - 3;` |
| `*`      | Multiplication            | `SELECT 5 * 3;` |
| `/`      | Division                  | `SELECT 5 / 3;` |
| `%`      | Modulus (remainder)       | `SELECT 5 % 3;` |

---

#### 2. Comparison Operators
Used to compare values:

| Operator | Description                  | Example                      |
|----------|------------------------------|------------------------------|
| `=`      | Equal to                     | `WHERE Age = 25`             |
| `!=` or `<>` | Not equal to               | `WHERE Age != 25`            |
| `>`      | Greater than                 | `WHERE Salary > 5000`        |
| `<`      | Less than                    | `WHERE Salary < 5000`        |
| `>=`     | Greater than or equal to     | `WHERE Salary >= 5000`       |
| `<=`     | Less than or equal to        | `WHERE Salary <= 5000`       |

---

#### 3. Logical Operators
Combine multiple conditions:

| Operator | Description                   | Example                          |
|----------|-------------------------------|----------------------------------|
| `AND`    | True if both conditions true  | `WHERE Age > 20 AND Salary > 5000` |
| `OR`     | True if any condition true    | `WHERE Age > 20 OR Salary > 5000`  |
| `NOT`    | Negates a condition           | `WHERE NOT Age = 25`               |

---

#### 4. Bitwise Operators
Operate on bits of numeric values (DBMS dependent):

| Operator | Description                  | Example             |
|----------|------------------------------|-------------------|
| `&`      | Bitwise AND                  | `SELECT 5 & 3;`   |
| `|`      | Bitwise OR                   | `SELECT 5 | 3;`   |
| `^`      | Bitwise XOR                  | `SELECT 5 ^ 3;`   |
| `~`      | Bitwise NOT                  | `SELECT ~5;`      |
| `<<`     | Left shift                   | `SELECT 5 << 1;`  |
| `>>`     | Right shift                  | `SELECT 5 >> 1;`  |

---

#### 5. Other / Special Operators

- **`IN`** → Checks if a value exists in a set.  
  ```sql
  WHERE Country IN ('USA', 'UK', 'India');
- **`NOT IN`** → Checks if a value does NOT exist in a set.  
  ```sql
  WHERE Country NOT IN ('USA', 'UK');
- **`BETWEEN`** → Checks if a value is within a range.
  ```sql
  WHERE Age BETWEEN 20 AND 30;
- **`LIKE`** → Pattern matching using % (any characters) and _ (single character).
  ```sql
  WHERE Name LIKE 'A%';
- **`NOT LIKE`** → Negates pattern matching.
  ``sql
  WHERE Name NOT LIKE 'A%';
- **`IS NULL / IS NOT NULL`** → Checks for null values.
  ```sql
  WHERE Salary IS NULL;
  WHERE Salary IS NOT NULL;
- **`EXISTS`** → Checks if a subquery returns any rows.
  ```sql
  WHERE EXISTS (SELECT * FROM Orders WHERE CustomerID = 101);
- **`ALL / ANY / SOME`** → Compare a value with a set of values returned by a subquery.
  ```sql
  WHERE Salary > ALL (SELECT Salary FROM Employees WHERE DeptID = 1);
- **`UNION / INTERSECT / MINUS / EXCEPT`** → Combine query results (set operators).
  ```sql
  SELECT Name FROM Employees
  UNION
  SELECT Name FROM Managers;
  --Intersect: Returns only the rows that appear in both queries.
  SELECT Name FROM Employees
  INTERSECT
  SELECT Name FROM Managers;
  --MINUS/EXCEPT: Returns rows from the first query that do not appear in the second query. MINUS is used in Oracle,EXCEPT is used in SQL Server / PostgreSQL.
  SELECT Name FROM Employees
  EXCEPT
  SELECT Name FROM Managers;
- **`Concat()`** → Used to combine two or more strings into a single string.
  ```sql
  SELECT CONCAT(FirstName, ' ', LastName) AS FullName
  FROM Employees;
- **`CONVERT`** → CONVERT are used to change the data type of a value or expression in SQL.
  ```sql
  SELECT CONVERT(VARCHAR(10), HireDate, 103) AS HireDateString
  FROM Employees;

---

### What are Function in SQL?

SQL functions allow you to perform operations on data and return a value. They are broadly categorized into **Aggregate Functions**, **Scalar Functions**, **Date/Time Functions**, **String Functions**, **Conversion Functions**, and **User-Defined Functions (UDFs)**.

---

#### 1. Aggregate Functions
Perform calculations across multiple rows and return a single value.

| Function | Description | Example |
|----------|-------------|---------|
| `SUM()`  | Total sum of a column | `SELECT SUM(Salary) AS TotalSalary FROM Employees;` |
| `AVG()`  | Average value of a column | `SELECT AVG(Salary) AS AvgSalary FROM Employees;` |
| `COUNT()`| Count rows or values | `SELECT COUNT(*) AS TotalEmployees FROM Employees;` |
| `MIN()`  | Minimum value | `SELECT MIN(Salary) AS MinSalary FROM Employees;` |
| `MAX()`  | Maximum value | `SELECT MAX(Salary) AS MaxSalary FROM Employees;` |

---

#### 2. Scalar Functions
Operate on a single value and return a single value.

**String Functions:**

| Function | Description | Example |
|----------|-------------|---------|
| `UPPER()` | Convert string to uppercase | `SELECT UPPER(FirstName) FROM Employees;` |
| `LOWER()` | Convert string to lowercase | `SELECT LOWER(FirstName) FROM Employees;` |
| `LEN()` / `LENGTH()` | Get length of string | `SELECT LEN(FirstName) FROM Employees;` |
| `CONCAT()` | Combine strings | `SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees;` |
| `SUBSTRING()` | Extract substring | `SELECT SUBSTRING(FirstName, 1, 3) FROM Employees;` |
| `TRIM()` | Remove leading/trailing spaces | `SELECT TRIM(FirstName) FROM Employees;` |

**Numeric Functions:**

| Function | Description | Example |
|----------|-------------|---------|
| `ROUND()` | Round a number | `SELECT ROUND(Salary, 0) FROM Employees;` |
| `CEILING()` | Round up to nearest integer | `SELECT CEILING(Salary) FROM Employees;` |
| `FLOOR()` | Round down to nearest integer | `SELECT FLOOR(Salary) FROM Employees;` |
| `ABS()` | Absolute value | `SELECT ABS(-100) AS AbsValue;` |

**Date/Time Functions:**

| Function | Description | Example |
|----------|-------------|---------|
| `GETDATE()` / `NOW()` | Current date and time | `SELECT GETDATE();` |
| `DATEADD()` | Add interval to date | `SELECT DATEADD(DAY, 7, GETDATE());` |
| `DATEDIFF()` | Difference between dates | `SELECT DATEDIFF(DAY, '2025-01-01', GETDATE());` |
| `YEAR()` | Extract year | `SELECT YEAR(HireDate) FROM Employees;` |
| `MONTH()` | Extract month | `SELECT MONTH(HireDate) FROM Employees;` |
| `DAY()` | Extract day | `SELECT DAY(HireDate) FROM Employees;` |

---

#### 3. Conversion Functions
Convert one data type to another.

| Function | Description | Example |
|----------|-------------|---------|
| `CAST()` | Convert data type | `SELECT CAST(Salary AS VARCHAR(10)) FROM Employees;` |
| `CONVERT()` | Convert data type (SQL Server) | `SELECT CONVERT(VARCHAR(10), HireDate, 103) FROM Employees;` |

---

#### 4. Conditional Functions
Perform logic-based operations.

| Function | Description | Example |
|----------|-------------|---------|
| `COALESCE()` | Return first non-NULL value | `SELECT COALESCE(Commission, 0) FROM Employees;` |
| `NULLIF()` | Returns NULL if values are equal | `SELECT NULLIF(Salary, 0) FROM Employees;` |
| `CASE` | Conditional expression | `SELECT CASE WHEN Salary > 5000 THEN 'High' ELSE 'Low' END AS SalaryLevel FROM Employees;` |

---

#### 5. User-Defined Functions (UDF)
A User-Defined Function is a custom function created by a user to encapsulate logic and reuse it across queries.
- Can take parameters.
- Must return a value (scalar or table).
- Can be called in SELECT, WHERE, or JOIN clauses.
- Unlike stored procedures, cannot modify data in most cases (read-only).

**Types of UDFs**
1. Scalar Function
   - Returns a single value (number, string, date, etc.)
   - Example:
   ```sql
   CREATE FUNCTION dbo.GetFullName(@FirstName VARCHAR(50), @LastName VARCHAR(50))
   RETURNS VARCHAR(101)
   AS
   BEGIN
       RETURN @FirstName + ' ' + @LastName
   END;
   
   -- Usage
   SELECT dbo.GetFullName('Ali', 'Khan') AS FullName;
2. Inline Table-Valued Function (iTVF)
   - Returns a table.
   - Essentially a parameterized view.
   - Usually written as a single SELECT statement.
   - Example:
     ```sql
      CREATE FUNCTION dbo.GetEmployeesByDept(@DeptID INT)
      RETURNS TABLE
      AS
      RETURN
      (
          SELECT EmployeeID, Name, Salary
          FROM Employees
          WHERE DepartmentID = @DeptID
      );
      
      -- Usage
      SELECT * FROM dbo.GetEmployeesByDept(2);
3. Multi-Statement Table-Valued Function (mTVF)
   - Returns a table variable after performing multiple statements.
   - Example:
     ```sql
      CREATE FUNCTION dbo.GetHighSalaryEmployees(@MinSalary INT)
      RETURNS @EmpTable TABLE (EmployeeID INT, Name VARCHAR(50), Salary INT)
      AS
      BEGIN
          INSERT INTO @EmpTable
          SELECT EmployeeID, Name, Salary
          FROM Employees
          WHERE Salary >= @MinSalary;
      
          RETURN;
      END;
      
      -- Usage
      SELECT * FROM dbo.GetHighSalaryEmployees(5000);

---

### Window Functions in SQL?
A Window Function performs a calculation across a set of rows that are related to the current row, without collapsing the result into a single value (unlike aggregate functions).

👉 Think of it as:
- Aggregate function + OVER() clause
- You get aggregated info (like totals, averages, ranks) but still see every row.
  ```sql
   function_name(expression) 
   OVER (
       [PARTITION BY column]
       [ORDER BY column]
       [ROWS or RANGE clause]
   )
  function_name → aggregate or ranking function (SUM, AVG, ROW_NUMBER, RANK…)

- PARTITION BY → divides rows into groups (like GROUP BY, but doesn’t collapse).
- ORDER BY → defines calculation order inside each partition.
- ROWS/RANGE → defines a moving "window" frame.

**Types of Window Functions**
1. Aggregate Window Functions
You can use aggregate functions with OVER(). <br>
Example: Department-wise total salary but still see each employee:
   ```sql
   SELECT 
       EmployeeID, 
       DepartmentID, 
       Salary,
       SUM(Salary) OVER (PARTITION BY DepartmentID) AS DeptTotal
   FROM Employees;

2. Ranking Functions
Used to rank rows. <br>
| ROW_NUMBER()	| Assigns unique sequential number.|  
| RANK()	      | Gives rank, leaves gaps if ties.|   
| DENSE_RANK()	| Rank without gaps for ties.|
| NTILE(n)	   | Divides rows into n equal groups (like quartiles).|

Example: Ranking employees by salary:
    ```sql
      SELECT 
          EmployeeID, 
          Salary,
          ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum,
          RANK() OVER (ORDER BY Salary DESC) AS RankNum,
          DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankNum
      FROM Employees;
      
3. Value Window Functions
   
   | Function       | Description                           |
   |----------------|---------------------------------------|
   | `LAG(column, n)`   | Gets value from n rows before current. |
   | `LEAD(column, n)`  | Gets value from n rows after current.  |
   | `FIRST_VALUE()`    | Returns first value in partition.      |
   | `LAST_VALUE()`     | Returns last value in partition.       |

Example: Compare each employee’s salary with the previous employee:
    ```sql
    SELECT 
       EmployeeID, 
       Salary,
       LAG(Salary,1) OVER (ORDER BY Salary) AS PrevSalary,
       LEAD(Salary,1) OVER (ORDER BY Salary) AS NextSalary
   FROM Employees;
4. Analytic Functions with Frames
    You can calculate moving totals/averages using ROWS BETWEEN.<br>
    Example: 3-month moving average salary:
   ```sql
      SELECT 
          EmployeeID, 
          Salary,
          AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
      FROM Employees;





