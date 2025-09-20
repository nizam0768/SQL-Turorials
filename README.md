# 📘 Interview Questions and Answers

This repository contains a collection of common technical questions and their answers.  
Use the links below to jump directly to each answer.  

---

## 📑 Table of Contents

1. [What are the main types of SQL commands?](#What-are-the-main-types-of-SQL-commands?)
2. [What are the different categories of datatypes in SQL Server?](#What-are-the-different-categories-of-datatypes-in-SQL-Server?)
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

