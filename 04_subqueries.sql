-- ВКЛАДЕНІ ЗАПИТИ

-- вивести спеціалістів, в яких з/п вижче
-- середньої в таблиці
SELECT *
FROM salaries
WHERE salary_in_usd > (
	SELECT AVG(salary_in_usd)
	FROM salaries
);

-- вивести всіх спеціалістів, які живуть
-- в країнах, де середня з/п вижча за середню
-- серед усіх країн
SELECT *
FROM salaries
WHERE emp_location IN
(
SELECT 
	comp_location
FROM salaries
GROUP BY comp_location
HAVING AVG(salary_in_usd) >
(
	SELECT AVG(salary_in_usd)
	FROM salaries
)
);

-- 1. пошук середньої з/п всіх країн
SELECT AVG(salary_in_usd)
FROM salaries;

-- 2. середня з/п в кожній країні
SELECT 
	comp_location
	, AVG(salary_in_usd)
FROM salaries
GROUP BY comp_location;

-- 3. країни, де середня з/п вижча сережньої 
-- з/п по всіх країна
SELECT 
	comp_location
	, AVG(salary_in_usd)
FROM salaries
GROUP BY comp_location
HAVING AVG(salary_in_usd) > 
					(SELECT AVG(salary_in_usd)
					FROM salaries);

-- знайти мінімальну з/п серед максимальних
-- з/п по країнах в 2023 році
-- 1. знайти макс. з/п по країнах in 2023
SELECT 
	 comp_location
	, MAX(salary_in_usd)
FROM salaries
WHERE year = 2023
GROUP BY comp_location;

-- 2. знайти мін. з/п серед макс.
SELECT 	
	MIN(salary_in_usd)
FROM
(
	SELECT 
	 comp_location
	, MAX(salary_in_usd) AS salary_in_usd
FROM salaries
WHERE year = 2023
GROUP BY comp_location
);

-- альтернатива (можна просто
-- відсортувати максимальні значення)
SELECT 
	 comp_location
	, MAX(salary_in_usd)
FROM salaries
WHERE year = 2023
GROUP BY comp_location
ORDER BY 2 ASC
LIMIT 1;

-- по кожній професії вивести різницю між
-- середньою з/п та максимальною з/п усіх
-- спеціалістів
-- 1. знайти середню з/п по кожній професії
-- 2. знайти макс. усіх спеціалістів
-- 3. вивести різницю середньої і макс.

-------------------
SELECT 
	job_title
	, ROUND(AVG(salary_in_usd), 2) - (
	SELECT MAX(salary_in_usd) 
	FROM salaries
	) AS diff
FROM salaries
GROUP BY job_title;

-- вивести дані по співробітнику, який
-- отримує другу по розміру з/п в таблиці
SELECT *
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 2;

SELECT *
FROM 
(
	SELECT *
	FROM salaries
	ORDER BY salary_in_usd DESC
	LIMIT 2
)
ORDER BY salary_in_usd ASC
LIMIT 1;

-- альтернатива
SELECT *
FROM salaries
ORDER BY salary_in_usd DESC
LIMIT 1 OFFSET 1;

-- Вивести всіх спеціалістів у яких зарплата вища 
-- за максимальну зарплату Junior спеціалістів 
-- 1. знайти макс. з/п junior 
-- 2. (умова)

SELECT 
	MAX(salary_in_usd)
FROM salaries
WHERE exp_level = 'EN';

SELECT *
FROM salaries
WHERE salary_in_usd > 
(
	SELECT MAX(salary_in_usd)
	FROM salaries
	WHERE exp_level = 'EN'
);

-- Вивести посади де середня зарплата вища
-- за середню зарплату в компаніях великого розміру
-- 1. знайти середню з/п в великих компаніях
-- 2. знайти середню з/п по посадах
-- 3. (умова)
SELECT 
	ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM salaries
WHERE comp_size = 'L';

SELECT 
	job_title
	, ROUND(AVG(salary_in_usd), 2) AS avg_salary_by_jobtitle
FROM salaries
GROUP BY job_title;

SELECT 
	job_title
FROM 
(
	SELECT 
		job_title
		, ROUND(AVG(salary_in_usd), 2) AS avg_salary_by_jobtitle
	FROM salaries
	GROUP BY job_title
)
WHERE avg_salary_by_jobtitle > 
(
	SELECT 
		ROUND(AVG(salary_in_usd), 2) AS avg_salary
	FROM salaries
	WHERE comp_size = 'L'
);

-- альтернатива
SELECT
	job_title
FROM salaries
GROUP BY job_title
HAVING AVG(salary_in_usd) >
(
	SELECT 
		ROUND(AVG(salary_in_usd), 2) AS avg_salary
	FROM salaries
	WHERE comp_size = 'L'
);

-- Вивести всіх спеціалістів у яких зарплата
-- вища за середню зарплату в 2023 році
-- 1. знайти середню з/п в 2023 
-- 2. (умова)
SELECT 
	AVG(salary_in_usd) AS avg_salary_2023
FROM salaries
WHERE year = 2023;

SELECT *
FROM salaries
WHERE salary_in_usd > 
(
	SELECT AVG(salary_in_usd)
	FROM salaries
	WHERE year = 2023
);

-- Вивести країни де максимальна зарплата вища 
-- за максимальну зарплату Junior спеціалістів
-- 1. макс. ЗП junior 
-- 2. знайти макс. зп по країнах
-- 3. (умова)
SELECT 
	MAX(salary_in_usd)
FROM salaries
WHERE exp_level = 'EN';

SELECT 
	comp_location
	, MAX(salary_in_usd) AS max_salary_by_country
FROM salaries
GROUP BY comp_location;

SELECT 
	comp_location
FROM 
(
	SELECT 
		comp_location
		, MAX(salary_in_usd) AS max_salary_by_country
	FROM salaries
	GROUP BY comp_location
)
WHERE max_salary_by_country > 
(
	SELECT 
		MAX(salary_in_usd)
	FROM salaries
	WHERE exp_level = 'EN'
);

SELECT 
	comp_location
FROM salaries
GROUP BY comp_location 
HAVING MAX(salary_in_usd) >
(
	SELECT 
	MAX(salary_in_usd)
FROM salaries
WHERE exp_level = 'EN'
);

-- Вивести всіх спеціалістів які живуть в країнах
-- де середня зарплата вища за загальну середню 
-- зарплату по всій таблиці
-- 1. загальна середня зп по всій таблиці
-- 2. середня зп по країнах
-- 3. (умова)
SELECT 
	AVG(salary_in_usd) AS general_avg_salary
FROM salaries;

SELECT 
	comp_location
	, AVG(salary_in_usd) AS avg_salary_by_country
FROM salaries
GROUP BY 1;

-- Вивести всіх спеціалістів у яких зарплата
-- вища за максимальну зарплату в малих компаніях
-- 1. знайти макс. зп в малих компаніях
-- 2. (умова)
SELECT 
	MAX(salary_in_usd)
FROM salaries
WHERE comp_size = 'S';

SELECT *
FROM salaries
WHERE salary_in_usd > 
(
	SELECT 
		MAX(salary_in_usd)
	FROM salaries
	WHERE comp_size = 'S'
);

-- Вивести всіх спеціалістів які працюють в
-- країнах де кількість спеціалістів більше 200
-- 1. країни, де к-сть спец. > 200
-- 2. умова
SELECT 
	comp_location
	, COUNT(*)
FROM salaries
GROUP BY comp_location
HAVING COUNT(*) > 200;

SELECT *
FROM salaries
WHERE comp_location IN
(
	SELECT 
	comp_location
FROM salaries
GROUP BY comp_location
HAVING COUNT(*) > 200
);

-- Вивести посади де мінімальна зарплата вища
-- за середню зарплату всієї таблиці
-- 1. середня зп таблиці
-- 2. мінімальна зп по посадах
-- 3. (умова)
SELECT 
	AVG(salary_in_usd) AS general_avg_salary
FROM salaries;

SELECT 
	job_title
	, MIN(salary_in_usd) AS min_salary_by_jobtitle
FROM salaries
GROUP BY job_title;

SELECT 
	job_title
FROM 
(
	SELECT 
	job_title
	, MIN(salary_in_usd) AS min_salary_by_jobtitle
	FROM salaries
	GROUP BY job_title
)
WHERE min_salary_by_jobtitle > (
	SELECT 
		AVG(salary_in_usd) AS general_avg_salary
	FROM salaries
);

SELECT 
	job_title
FROM salaries
GROUP BY job_title
HAVING MIN(salary_in_usd)
> (
select AVG(salary_in_usd)
from SALARIES
)