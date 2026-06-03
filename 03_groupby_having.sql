-- Вивести всіх спеціалістів які є Senior або Middle
-- і працюють в великих компаніях
SELECT *
FROM salaries
WHERE 
	(exp_level = 'SE' OR exp_level = 'MI')
	AND comp_size = 'L';

 -- Показати всі записи де рік є 2022 або 2023 
 -- і зарплата більше $150,000
 SELECT *
 FROM salaries
 WHERE 
 		(year = 2022 OR year = 2023)
		 AND salary_in_usd > 150000;

 -- Вивести спеціалістів які працюють повністю
 -- віддалено або в офісі і рівень досвіду є Junior
 SELECT *
 FROM salaries
 WHERE 
 	(remote_ratio = 100 OR remote_ratio = 0)
	 AND exp_level = 'EN';

-- Показати всі записи де локація працівника є 
-- Німеччина або Канада або Іспанія і тип зайнятості
-- є повна зайнятість
SELECT *
FROM salaries
WHERE
	(emp_location = 'DE' 
	OR emp_location = 'CA' 
	OR emp_location = 'ES')
	AND emp_type = 'FT';

-- Вивести топ 10 зарплат де посада містить слово
-- "Data" або "Engineer" і зарплата між 
-- $100,000 і $300,000
SELECT 
	salary_in_usd AS top_10_salary
	, job_title
FROM salaries
WHERE 
	(job_title LIKE('%Data%') 
	OR job_title LIKE('%Engineer%'))
	AND salary_in_usd BETWEEN 100000 AND 300000
ORDER BY salary_in_usd DESC
LIMIT 10;

SELECT *
FROM salaries
WHERE exp_level = 'SE'
    AND salary_in_usd > 300000
    OR salary_in_usd > 300000;

SELECT *
FROM salaries
WHERE year = 2023
    AND emp_type = 'FT'
    OR emp_type = 'PT';

SELECT *
FROM salaries
WHERE job_title = 'Data Analyst'
    AND (salary_in_usd > 200000
    OR salary_in_usd > 150000);

-- 1. Вивести всі посади які починаються на літеру "D"
SELECT DISTINCT job_title
FROM salaries
WHERE job_title LIKE ('D_%');

-- 2. Вивести всі посади які закінчуються на слово "ist"
SELECT DISTINCT job_title
FROM salaries
WHERE job_title LIKE('%ist');

-- 3. Показати спеціалістів де в назві посади
-- є будь-які 3 символи а потім слово "Engineer"
SELECT DISTINCT job_title
FROM salaries
WHERE job_title LIKE('___ Engineer');

-- 4. Вивести спеціалістів з зарплатою між 
-- $50,000 і $100,000
SELECT *
FROM salaries
WHERE 
	salary_in_usd BETWEEN 50000 AND 100000;
	
-- 5. Показати всіх спеціалістів зарплата яких 
-- НЕ між $50,000 і $150,000
SELECT *
FROM salaries
WHERE 
	salary_in_usd NOT BETWEEN 50000 AND 100000;

-- 6. Вивести всіх спеціалістів які НЕ є з 
-- країн US, CA, DE
SELECT *
FROM salaries
WHERE emp_location NOT IN('US', 'CA', 'DE');

-- 7. Показати всі записи де рівень досвіду є EN, MI або EX
SELECT *
FROM salaries
WHERE exp_level IN('EN', 'MI', 'EX');

-- Перевір чи є в таблиці пусті значення в колонках
SELECT 
    COUNT(*) - COUNT(year) AS year_nulls
	, COUNT(*) - COUNT(exp_level) AS exp_level_nulls
	, COUNT(*) - COUNT(emp_type) AS emp_type_nulls
	, COUNT(*) - COUNT(job_title) AS job_title_nulls
	, COUNT(*) - COUNT(salary_in_usd) AS salary_nulls
FROM salaries;

-- для кожної професії та відповідного рівня
-- досвіду навести: 
-- 1. кількість в таблиці
-- 2. середню з/п
SELECT 
	job_title
	, exp_level
	, COUNT (*)
	, ROUND(AVG(salary_in_usd *37), 2) AS salary_in_uah
FROM salaries
GROUP BY job_title, exp_level
ORDER BY count DESC;

SELECT 
	exp_level
	, COUNT(*)
	, AVG(salary_in_usd) AS avg_salary
FROM salaries
GROUP BY exp_level
ORDER BY 2 DESC;

-- Порахувати скільки спеціалістів працює в 
-- кожному розмірі компанії
SELECT 
	comp_size
	, COUNT(*)
FROM salaries
GROUP BY comp_size
ORDER BY count DESC;

-- максимальна зарплата по кожному типу зайнятості 
SELECT 
	emp_type
	, MAX(salary_in_usd)
FROM salaries 
GROUP BY emp_type;

-- середня зарплата по кожній країні компанії, 
-- відсортуй від найвищої до найнижчої
SELECT 
	comp_location
	, ROUND(AVG(salary_in_usd), 2) AS avg_salary_country
FROM salaries
GROUP BY comp_location
ORDER BY avg_salary_country DESC;

-- Вивести кількість спеціалістів по кожній 
-- посаді але тільки ті посади де спеціалістів 
-- більше 50, відсортувати від найбільшої 
-- кількості до найменшої 
SELECT 
	job_title
	, COUNT(*) AS num_of_workers
FROM salaries
GROUP BY job_title
HAVING COUNT(*) > 50
ORDER BY num_of_workers DESC;

-- Вивести загальну суму зарплат по кожному року
SELECT 
	year
	, SUM(salary_in_usd) AS general_salary_sum
FROM salaries
GROUP BY year;

-- Мінімальна і максимальна зарплата по
-- кожному рівню досвіду 
SELECT 
	exp_level
	, MIN(salary_in_usd)
	, MAX(salary_in_usd)
FROM salaries
GROUP BY exp_level;

-- Середня зарплата по кожному розміру компанії,
-- округлена до 2 знаків
SELECT 
	comp_size
	, ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM salaries
GROUP BY comp_size;

-- Кількість спеціалістів по кожному типу зайнятості,
-- відсортувати від найбільшої кількості
SELECT 
	emp_type
	, COUNT(*) AS num_of_workers
FROM salaries
GROUP BY emp_type
ORDER BY num_of_workers DESC;

-- Загальна сума зарплат і середня зарплата
-- по кожній країні працівника, відсортувати
-- за середньою зарплатою по спаданню 
SELECT 
	emp_location
	, SUM(salary_in_usd) AS general_sum_country
	, ROUND(AVG(salary_in_usd), 2) AS avg_salary_country
FROM salaries
GROUP BY emp_location
ORDER BY avg_salary_country DESC;

-- для професій, які зустрічаються 1 раз
-- навести заробітну плату
SELECT 
	job_title
	, COUNT(*) AS count_job
	, AVG(salary_in_usd)
FROM salaries
WHERE year = 2023
GROUP BY job_title
HAVING COUNT(*) = 1;

-- Порахувати кількість спеціалістів по кожному року 
SELECT 
	year
	, COUNT(*) AS num_workers
FROM salaries
GROUP BY year 
ORDER BY num_workers DESC;

-- Середня зарплата по кожному рівню досвіду, 
-- округлена до 2 знаків
SELECT 
	exp_level
	, ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM salaries
GROUP BY exp_level;

-- Максимальна зарплата по кожній країні компанії, 
-- показати тільки ті країни де максимальна зарплата 
-- більше $200,000 
SELECT 
	comp_location
	, MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY comp_location
HAVING MAX(salary_in_usd) > 200000;

-- Вивести середню зарплату по кожній посаді
-- тільки серед Senior спеціалістів, показати 
-- тільки ті посади де середня зарплата 
-- більше $150,000 
SELECT 
	ROUND(AVG(salary_in_usd), 2) AS avg_salary
	, job_title
FROM salaries
WHERE exp_level = 'SE'
GROUP BY job_title, exp_level
HAVING AVG(salary_in_usd) > 150000;

-- Яка середня зарплата Junior аналітиків 
-- даних у 2022 та 2023 роках?
SELECT 
    year
    , ROUND(AVG(salary_in_usd), 2) AS avg_salary_junior_data_analyst
FROM salaries
WHERE 
    exp_level = 'EN'
    AND job_title = 'Data Analyst'
    AND year IN(2022, 2023)
GROUP BY year;

-- Знайти всі унікальні типи зайнятості
-- які є в компаніях малого розміру
SELECT 
	DISTINCT emp_type
FROM salaries
WHERE comp_size = 'S';

-- Які 5 країн платять найбільше своїм
-- спеціалістам в середньому? 
SELECT 
	comp_location
	, ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM salaries
GROUP BY comp_location
ORDER BY avg_salary DESC
LIMIT 5;

-- Скільки спеціалістів працює
-- повністю віддалено в кожному році? 
SELECT 
	year
	, COUNT(*) AS num_of_workers_online
FROM salaries
WHERE remote_ratio = 100
GROUP BY year;

-- Знайти посади де мінімальна зарплата
-- нижче $30,000
SELECT 
	job_title
	, MIN(salary_in_usd)
FROM salaries
GROUP BY job_title
HAVING MIN(salary_in_usd) < 30000;

-- Порахувати кількість спеціалістів
-- по кожному розміру компанії
SELECT 
	comp_size
	, COUNT(*)
FROM salaries
GROUP BY comp_size;

-- Максимальна зарплата по кожному
-- рівню досвіду
SELECT 
	exp_level
	, MAX(salary_in_usd)
FROM salaries
GROUP BY exp_level;

-- 1. Показати всі унікальні країни де є
-- спеціалісти з зарплатою вище $200,000
SELECT 
	DISTINCT comp_location
FROM salaries
WHERE salary_in_usd > 200000;

-- 2. Скільки всього записів є в таблиці?
SELECT COUNT(*)
FROM salaries;

-- 3. Яка найвища і найнижча зарплата 
-- серед всіх спеціалістів?
SELECT 
	MIN(salary_in_usd) AS min_salary
	, MAX(salary_in_usd) AS max_salary
FROM salaries;

-- 4. Показати всіх спеціалістів 
-- з Іспанії або Португалії які працюють
-- віддалено більше ніж 50%
SELECT *
FROM salaries
WHERE 
	emp_location IN( 'PT')
	AND remote_ratio > 50;
	
-- 5. Вивести всі посади які містять
-- слово "Lead" або "Head"
SELECT 
	job_title
FROM salaries
WHERE 
	job_title LIKE '%Lead%' 
	OR job_title LIKE '%Lead%';

-- 6. Показати спеціалістів із зарплатою
-- від $80,000 до $120,000 які не є з США
SELECT *
FROM salaries
WHERE 
	salary_in_usd BETWEEN 80000 AND 120000
	AND emp_location != 'US';

-- 7. Яка загальна сума всіх зарплат
-- в таблиці?
SELECT 
	SUM(salary_in_usd) 
FROM salaries;

-- 8. Вивести топ 5 найнижчих зарплат серед
-- Senior спеціалістів у великих компаніях
SELECT *
FROM salaries
WHERE 
	exp_level = 'SE'
	AND comp_size = 'L'
ORDER BY salary_in_usd ASC
LIMIT 5;

-- 1. Яка середня зарплата по кожному
-- типу зайнятості?
SELECT 
	emp_type
	, ROUND(AVG(salary_in_usd), 2)
FROM salaries
GROUP BY emp_type;

-- 2. Порахувати кількість спеціалістів 
-- по кожній країні працівника
SELECT 
	emp_location
	, COUNT(*) AS num_of_workers
FROM salaries
GROUP BY emp_location
ORDER BY 2 ASC;

-- 3. Яка мінімальна і максимальна зарплата 
-- по кожному року?
SELECT 
	year
	, MIN(salary_in_usd) AS min_salary
	, MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY year;

-- 4. Яка загальна сума зарплат
-- по кожному рівню досвіду,
-- відсортувати від найбільшої до найменшої?
SELECT 
	exp_level
	, SUM(salary_in_usd)
FROM salaries
GROUP BY exp_level
ORDER BY 2 DESC;

-- 1. Показати тільки ті типи зайнятості
-- де середня зарплата більше $100,000
SELECT 
	emp_type
	, ROUND(AVG(salary_in_usd), 2)
FROM salaries
GROUP BY emp_type
HAVING AVG(salary_in_usd) > 100000;

-- 2. Вивести країни компаній де кількість
-- спеціалістів більше 100
SELECT 
	comp_location
	, COUNT(*)
FROM salaries
GROUP BY comp_location
HAVING  COUNT(*) > 100;

-- 3. Показати рівні досвіду де
-- максимальна зарплата більше $400,000
SELECT 
	exp_level
	, MAX(salary_in_usd) AS max_salary
FROM salaries
GROUP BY exp_level
HAVING MAX(salary_in_usd) > 400000; 

-- 4. Вивести типи зайнятості де загальна
-- сума зарплат більше $10,000,000
SELECT 
	emp_type
	, SUM(salary_in_usd) AS general_salary
FROM salaries
GROUP BY emp_type
HAVING SUM(salary_in_usd) > 10000000;

-- 1. Середня зарплата по кожному 
-- рівню досвіду тільки серед 2023 року
SELECT 
	exp_level
	, AVG(salary_in_usd) AS avg_salary
FROM salaries
WHERE year = 2023
GROUP BY exp_level;

-- 2. Кількість спеціалістів по кожній
-- посаді тільки у великих компаніях
SELECT 
	job_title
	, COUNT(*)
FROM salaries
WHERE comp_size = 'L'
GROUP BY job_title;

-- 3. Максимальна зарплата по кожній 
-- країні працівника тільки серед
-- повної зайнятості
SELECT 
	emp_location
	, MAX(salary_in_usd)
FROM salaries
WHERE emp_type = 'FT'
GROUP BY emp_location;

-- 4. Загальна сума зарплат по кожному
-- року тільки серед повністю віддалених 
-- спеціалістів
SELECT 
	year
	, SUM(salary_in_usd)
FROM salaries
WHERE remote_ratio = 100
GROUP BY year;

-- 1. Середня зарплата по кожному
-- рівню досвіду тільки серед 2023 року, 
-- показати тільки ті де середня
-- більше $120,000
SELECT 
	exp_level
	, ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM salaries
WHERE year = 2023
GROUP BY exp_level
HAVING AVG(salary_in_usd) > 120000;

-- 2. Кількість спеціалістів по кожній
-- посаді тільки у великих компаніях,
-- показати тільки ті посади де 
-- спеціалістів більше 10
SELECT 
	job_title
	, COUNT(*)
FROM salaries
WHERE comp_size = 'L'
GROUP BY job_title
HAVING COUNT(*) > 10;

-- 3. Максимальна зарплата по кожній
-- країні працівника тільки серед
-- повної зайнятості, показати тільки 
-- країни де максимальна більше $200,000
SELECT 
	emp_location
	, MAX(salary_in_usd) AS max_salary
FROM salaries
WHERE emp_type = 'FT'
GROUP BY emp_location
HAVING MAX(salary_in_usd) > 200000
ORDER BY 2 ASC;

-- 4. Загальна сума зарплат по кожному 
-- року тільки серед повністю віддалених 
-- спеціалістів, показати тільки роки де 
-- сума більше $50,000,000
SELECT 
	year
	, SUM(salary_in_usd) AS general_sum
FROM salaries
WHERE remote_ratio = 100
GROUP BY year
HAVING SUM(salary_in_usd) > 50000000;

-- для професій, що зустрічаються 1 раз 
-- навести заробітну плату
SELECT 
	 job_title
	, COUNT(*)
	, MAX(salary_in_usd)
FROM salaries
GROUP BY job_title
HAVING COUNT(*) = 1;