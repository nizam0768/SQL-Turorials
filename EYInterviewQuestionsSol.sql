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
