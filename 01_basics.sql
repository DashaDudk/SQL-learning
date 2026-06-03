SELECT 
	year
	, exp_level AS level
	, emp_type AS type
FROM salaries
WHERE 
	year != 2022
	AND exp_level = 'SE'
ORDER BY type DESC
LIMIT 20;

-- top 5 DATA SCIENCE salaries in 2023
SELECT 
	year
	, job_title
	, salary_in_usd
FROM salaries
WHERE 
	year = 2023
	AND job_title = 'Data Scientist'
ORDER BY salary_in_usd DESC
LIMIT 5;

-- Вивести з/п спеціалістів ML Engineer в 2023 році
SELECT 
	year
	, job_title
	, salary_in_usd
FROM salaries
WHERE 
	year = 2023
	AND job_title = 'ML Engineer'
ORDER BY 3 DESC;

-- Назвати країну (company_location), в якій зафіксована 
-- найменша з/п спеціаліста в сфері Data Scientist в 2023 році
SELECT 
	year
	, job_title
	, salary_in_usd
	, comp_location AS country
FROM salaries
WHERE
	year = 2023
	AND job_title = 'Data Scientist'
ORDER BY salary_in_usd ASC
LIMIT 1;

/* Вивести з/п українців (код країни UA), додати сортування 
за зростанням з/п */
SELECT 
	salary_in_usd
	, emp_location
FROM salaries
WHERE emp_location = 'UA'
ORDER BY 1 ASC;

/* Вивести топ 5 з/п серед усіх спеціалістів, 
які працюють повністю віддалено (remote_ratio = 100) */
SELECT *
FROM salaries
WHERE 
	remote_ratio = 100
ORDER BY salary_in_usd DESC
LIMIT 5;

/* Згенерувати .csv файл з таблицею даних всіх спеціалістів, 
які в 2023 році мали з/п більшу за $100,000 і працювали в 
компаніях середнього розміру (company_size = 'M') */
SELECT *
FROM salaries
WHERE 
	year = 2023
	AND salary_in_usd > 100000
	AND comp_size = 'M';

-- Вивести job_title, salary_in_usd, comp_location де зарплата від $150,000 до $200,000
SELECT 
	job_title
	, salary_in_usd
	, comp_location
FROM salaries
WHERE salary_in_usd BETWEEN 150000 AND 200000;

-- Показати спеціалістів з посадою Data Analyst або Data Scientist
SELECT *
FROM salaries
WHERE job_title IN('Data Analyst', 'Data Scientist');

-- Вивести всі посади де в назві є слово "Engineer"
SELECT job_title
FROM salaries
WHERE job_title LIKE '%Engineer%';

-- Показати записи де emp_location НЕ є US
SELECT *
FROM salaries
WHERE emp_location != 'US';

-- DISTINCT
SELECT DISTINCT job_title 
FROM salaries;

-- COUNT (DISTINCT column_name)
SELECT COUNT(DISTINCT comp_location) AS unique_company_countries
FROM salaries;


-- закріплення матеріалу next day
-- 1. Вивести назву посади і зарплату всіх спеціалістів 
-- у малих компаніях, відсортувати за зарплатою по спаданню
SELECT 
	job_title
	, salary_in_usd
	, comp_size
FROM salaries
WHERE comp_size = 'S'
ORDER BY salary_in_usd DESC;

-- 2. Показати топ 3 найвищі зарплати серед Junior спеціалістів у 2023 році
SELECT 
	year
	, salary_in_usd
	, exp_level
FROM salaries
WHERE 
	year = 2023 
	AND exp_level = 'EN'
ORDER BY salary_in_usd DESC
LIMIT 3;

-- 3. Вивести всі посади де в назві є слово "Scientist"
SELECT job_title
FROM salaries
WHERE job_title LIKE ('%Scientist%');

-- 4. Показати унікальні рівні досвіду які є в таблиці
SELECT DISTINCT exp_level
FROM salaries;

-- 5. Вивести назву посади і зарплату з аліасом salary 
-- де зарплата між $200,000 і $300,000
SELECT 
	job_title
	, salary_in_usd AS salary
FROM salaries
WHERE salary_in_usd BETWEEN 200000 AND 300000;

-- 6. Показати всі записи де тип зайнятості є freelance або контракт
SELECT *
FROM salaries
WHERE emp_type IN ('FL', 'CT');

-- 7. Скільки унікальних посад є в таблиці?
SELECT COUNT(DISTINCT job_title)
FROM salaries;

-- 8.Вивести назву посади, рівень досвіду з аліасом,
-- зарплату з аліасом і розмір компанії для спеціалістів
-- які працюють повністю віддалено, зарплата 
-- між $100,000 і $250,000, тип зайнятості є повна 
-- зайнятість або контракт, відсортувати за зарплатою 
-- по спаданню, показати тільки перші 10 записів
SELECT 
	job_title
	, exp_level AS level
	, salary_in_usd AS salary
	, comp_size
FROM salaries
WHERE
	remote_ratio = 100
	AND salary_in_usd BETWEEN 100000 AND 250000
	AND emp_type IN('FT', 'CT')
ORDER BY salary_in_usd DESC
LIMIT 10;

-- Вивести всі дані спеціалістів де в назві посади є слово "Data",
-- рівень досвіду є Senior або Middle, локація працівника не є US, 
-- відсортувати за роком по спаданню а потім за зарплатою по спаданню,
-- показати перші 15 записів
SELECT *
FROM salaries
WHERE 
	job_title LIKE('%Data%')
	AND exp_level IN('SE','MI')
	AND emp_location != 'US' 
ORDER BY year DESC, salary_in_usd DESC
LIMIT 15;

 -- ті самі запити, але краще NOT IN
WHERE 
	emp_location != 'US' AND emp_location != 'CA'
WHERE 
	emp_location NOT IN('US','CA')