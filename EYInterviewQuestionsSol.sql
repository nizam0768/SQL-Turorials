-- Q: write a SQL query to identify EY's top 10 clients in terms of total billed amount in the past year.

SELECT 
  c.client_name, 
  SUM(b.amount) AS total_billed
FROM clients c
JOIN billings b ON c.client_id = b.client_id
WHERE b.billing_date BETWEEN DATEADD(year, -1, GETDATE()) AND GETDATE()
GROUP BY c.client_name
ORDER BY total_billed DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

GO

-- 2nd Largest Salary

--Approch 1
Select Max(salary) from employees 
	where salary < (select Max(salary) from employees)
Go

--Approch 2
Select * from 
	(Select *,
	DENSE_RANK() Over (Order by salary DESC) AS salary_rank 
	from employees) ranked 
	Where salary_rank = 2

GO

-- Q: write a SQL query that calculates the average monthly revenue from each sector in 2020.

WITH Monthly AS (
    SELECT 
        MONTH(transaction_date) AS transaction_month,
        company_id,
        AVG(revenue) AS avg_revenue
    FROM transactions
    WHERE YEAR(transaction_date) = 2020
    GROUP BY MONTH(transaction_date), company_id
)

SELECT 
    m.transaction_month AS month,
    s.sector,
    AVG(m.avg_revenue) AS avg_revenue
FROM Monthly m
JOIN sectors s ON m.company_id = s.company_id
GROUP BY m.transaction_month, s.sector
ORDER BY m.transaction_month, s.sector;


GO
-- Q: Analyzing Consulting Project Performance

--Part1: The total billing amount for each project.
SELECT 
	p.project_name,
	SUM(b.billing_amount) AS total_billing_amount
	FROM projects p
	JOIN billing b ON p.project_id = b.project_id
	WHERE b.billing_date BETWEEN p.project_start_date AND p.project_end_date
	GROUP BY p.project_name;

GO

--Part2: The average monthly billing amount for each project.

WITH monthly AS (
    SELECT 
        b.project_id,
        MONTH(b.billing_date) AS transaction_month,
        AVG(b.billing_amount) AS avg_billing_amount
    FROM billing b
    JOIN projects p ON b.project_id = p.project_id
    WHERE b.billing_date BETWEEN p.project_start_date AND p.project_end_date
    GROUP BY b.project_id, MONTH(b.billing_date)
)

SELECT 
    p.project_name,
    m.transaction_month,
    m.avg_billing_amount AS avg_billing
FROM monthly m
JOIN projects p ON m.project_id = p.project_id
ORDER BY p.project_name, m.transaction_month;
