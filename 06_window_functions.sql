SELECT
	job_title
	, ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM salaries
GROUP BY 1;

WITH cte AS (
	SELECT 
		job_title 
		, salary_in_usd
		, SUM(salary_in_usd) OVER(PARTITION BY job_title ORDER BY salary_in_usd) AS sum_salary
--		, AVG(salary_in_usd) OVER(PARTITION BY job_title) AS avg_salary
--		, MIN(salary_in_usd) OVER(PARTITION BY job_title) AS min_salary
--		, MAX(salary_in_usd) OVER(PARTITION BY job_title) AS max_salary
--		, COUNT(salary_in_usd) OVER(PARTITION BY job_title) AS job_count
--		, SUM(salary_in_usd) OVER(PARTITION BY job_title) AS sum_salary
	FROM salaries
	WHERE year = 2023
)

SELECT 
	* 
--	, salary_in_usd::float / max_salary AS ratio_max
--	, salary_in_usd / avg_salary AS ratio_avg
FROM cte;

WITH cte AS (
	SELECT 
		job_title 
		, salary_in_usd
		, AVG(salary_in_usd) OVER (PARTITION BY job_title) AS avg_salary
	FROM salaries
	WHERE year = 2023
)

SELECT 
	* 
FROM cte
WHERE salary_in_usd > avg_salary;

WITH cte AS (
	SELECT 
		i.InvoiceId 
		, i.CustomerId 
		, i.Total 
		, ROW_NUMBER() 	OVER(PARTITION BY CustomerID ORDER BY i.Total DESC) AS invoice_nmb
		, RANK() 		OVER(PARTITION BY CustomerID ORDER BY i.Total DESC) AS invoice_rank
		, DENSE_RANK()  OVER(PARTITION BY CustomerID ORDER BY i.Total DESC) AS invoice_dense_rank
	FROM Invoice i 
	ORDER BY i.CustomerId 
)

SELECT *
FROM cte
WHERE invoice_nmb = 2;

SELECT 
	i.InvoiceId 
	, i.CustomerId 
	, i.InvoiceDate 
	, i.Total 
	, LAG(Total, 1) OVER(PARTITION BY i.CustomerId ORDER BY i.InvoiceDate) AS lag_total
	, LAG(i.InvoiceDate, 1) OVER(PARTITION BY i.CustomerId ORDER BY i.InvoiceDate) AS lag_total
	, JULIANDAY(i.InvoiceDate) - JULIANDAY(LAG(i.InvoiceDate, 1) OVER(PARTITION BY i.CustomerId ORDER BY i.InvoiceDate))
	, LEAD(Total, 1) OVER(PARTITION BY i.CustomerId ORDER BY i.InvoiceDate) AS lead_total
FROM Invoice i 
ORDER BY i.CustomerId 

SELECT 
	InvoiceId 
	, CustomerId 
	, InvoiceDate 
	, Total 
	, FIRST_VALUE(Total) OVER(PARTITION BY CustomerId ORDER BY InvoiceDate ASC) AS first_amount
	, LAST_VALUE(Total) OVER(PARTITION BY CustomerId ORDER BY InvoiceDate ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS last_amount
FROM Invoice