SELECT 
	1 AS number;

SELECT *
FROM salaries;

SELECT 
	AVG(salary_in_usd) AS avg_salary
	, MIN (salary_in_usd) AS min_salary
	, MAX (salary_in_usd) AS max_salary
FROM salaries
WHERE year = 2023;

SELECT 
	year
	, job_title
	, salary_in_usd
	, salary_in_usd * 45 AS salary_in_uah
FROM salaries
LIMIT 15;

SELECT 
	year
	, salary_in_usd
	, exp_level
	, CASE 
		WHEN exp_level = 'SE'
		THEN 'Senior'
		ELSE 'OTHER' END 	AS full_level
FROM salaries
LIMIT 20;

-- вивести з/п спеціалістів ML Engineer в 2023 році,
-- додати сортування за зростанням зп
SELECT 
	year
	, job_title
	, salary_in_usd
FROM salaries
WHERE 
	year = 2023
	AND job_title = 'ML Engineer'
ORDER BY salary_in_usd ASC;

-- Назвати країну (company_location), в якій зафіксована 
-- найменша з/п спеціаліста в сфері Data Scientist в 2023 році
SELECT 
	comp_location
	, salary_in_usd
	, year
	, job_title
FROM salaries
WHERE 
	year = 2023
	AND job_title = 'Data Scientist'
ORDER BY salary_in_usd ASC
LIMIT 1;

SELECT 
	salary_in_usd
	, remote_ratio
FROM salaries
WHERE remote_ratio = 100
ORDER BY 1 DESC
LIMIT 5;

-- Вивести унікальні значення для колонки
SELECT 
	DISTINCT remote_ratio
FROM salaries;

-- Вивести к-сть унікальних значень колонки
SELECT COUNT(DISTINCT comp_location)
FROM salaries;

-- Вивести середню, мінімальну та максимальну з/п для 2023 року
SELECT 
	ROUND(AVG (salary_in_usd), 2) AS avg_salary
	, MIN (salary_in_usd) AS min_salary
	, MAX (salary_in_usd) AS max_salary
FROM salaries
WHERE 
	year = 2023;

-- Вивести 5 найвищих з/п в 2023 році для представників ML Engineer. з/п перевести в гривні
SELECT 
	salary_in_usd * 38 AS salary_in_uah
	, salary_in_usd
	, job_title
	, year
FROM salaries
WHERE 
	year = 2023
	AND job_title = 'ML Engineer'
ORDER BY salary_in_usd DESC
LIMIT 5;

-- вивести унікальні значення колонки remote_ratio, формат даних має бути дробовим з двома знаками після коми
-- приклад: значення "50" має відображатись у форматі "0.50"
SELECT 
	DISTINCT ROUND((remote_ratio/100.0),2) AS remote_frac
FROM salaries;

-- вивести всі дані + колонку з повною назвою exp_level -> exp_level_full
SELECT *
	, CASE 
		WHEN exp_level = 'SE' THEN 'senior'
		WHEN exp_level = 'MI' THEN 'middle'
		WHEN exp_level = 'EX' THEN 'executive'
		ELSE 'entry' END AS exp_level_full
FROM salaries;

SELECT *
	, CASE 
		WHEN salary_in_usd < 50000 THEN 'category 1'
		WHEN salary_in_usd < 100000 THEN 'category 2'
		WHEN salary_in_usd < 4000000 THEN 'category 3'
		ELSE 'category 4' END AS exp_level_full
FROM salaries;

-- дослідити всі колонки на наявність відсутніх значень
SELECT COUNT(*) - COUNT(job_title) 
FROM salaries