SELECT *
FROM Invoice i 
LIMIT 100;

SELECT *
FROM InvoiceLine il 
LIMIT 100;

SELECT *
FROM Track t 
LIMIT 100;

SELECT *
FROM Album a ;

SELECT *
FROM Artist a 
LIMIT 100;

SELECT 
	art.Name 
	, COUNT(t.TrackId ) AS count
FROM Track t
JOIN Album a	    ON t.AlbumId = a.AlbumId 
JOIN Artist art ON a.ArtistId = art.ArtistId 
WHERE art.Name LIKE ('A%')
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 100;

-- Вивести назву треку і назву альбому для кожного треку 
SELECT 
	t.Name
	, a.Title
FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId

SELECT *
FROM Album a ;

--Вивести назву треку і назву виконавця для кожного треку
SELECT 
	t.Name
	, art.Name
FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId 
JOIN Artist art ON a.ArtistId = art.ArtistId ;

--Вивести назву треку, назву альбому і назву виконавця
SELECT 
	t.Name 
	, alb.Title
	, art.Name
FROM Track t 
JOIN Album alb ON t.AlbumId = alb.AlbumId
JOIN Artist art ON alb.ArtistID = art.ArtistId ;

-- Вивести ім'я та прізвище клієнта і загальну суму його покупок
SELECT 
	c.FirstName
	, c.LastName
	, SUM(i.Total) AS total_sum
FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.FirstName , c.LastName ;

--Вивести топ 5 клієнтів які витратили найбільше грошей
SELECT 
	c.FirstName
	, c.LastName
	, SUM(i.Total) AS total_sum
FROM Customer c 
JOIN Invoice i ON c.CustomerId = i.CustomerId 
GROUP BY c.FirstName
		, c.LastName
ORDER BY SUM(i.Total) DESC 
LIMIT 5;

--Вивести кількість треків в кожному альбомі і назву альбому
SELECT 
	alb.Title
	, COUNT(*) AS num_of_tracks
FROM Album alb 
JOIN Track t ON alb.AlbumId = t.AlbumId
GROUP BY alb.Title;

--Вивести назву жанру і кількість треків в кожному жанрі, відсортувати від найбільшої кількості
SELECT 
	g.Name 
	, COUNT(*) AS num_of_tracks
FROM Genre g 
INNER JOIN Track t ON g.GenreId = t.GenreId 
GROUP BY 1
ORDER BY 2 DESC; 

-- Вивести назву жанру і кількість треків, але тільки ті жанри де треків більше 50 
SELECT 
	g.Name 
	, COUNT(*) AS num_of_tracks
FROM Genre g 
INNER JOIN Track t ON g.GenreId = t.GenreId 
GROUP BY 1
HAVING COUNT(*) > 50
ORDER BY 2 DESC ;

-- Вивести імʼя виконавця і кількість альбомів, але тільки тих виконавців
-- у яких більше 5 альбомів, відсортувати від найбільшої кількості
SELECT 
	art.Name
	, COUNT(*) AS num_of_albums
FROM Artist art
INNER JOIN Album alb ON art.ArtistId = alb.ArtistId 
GROUP BY 1
HAVING COUNT(*) > 5
ORDER BY 2 DESC;

-- Вивести імʼя виконавця, назву альбому і кількість треків в альбомі, 
--але тільки для виконавців чиє імʼя починається на "A", відсортувати за кількістю треків від найбільшої
SELECT 
	art.Name
	, alb.Title
	, COUNT(*) AS num_of_tracks_in_album
FROM Artist art
INNER JOIN Album alb ON art.ArtistId = alb.ArtistId 
INNER JOIN Track t ON alb.AlbumId = t.AlbumId 
WHERE art.Name LIKE('A%')
GROUP BY 2
ORDER BY 3 DESC;

-- Вивести імʼя клієнта і назву треку який він купив
SELECT 
	c.FirstName
	, c.LastName
	, t.Name
FROM Customer c 
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId 
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
INNER JOIN Track t ON il.TrackId = t.TrackId; 

--Вивести імʼя виконавця і загальну кількість треків які були куплені,
-- відсортувати від найбільшої кількості
SELECT 
	art.Name 
	, COUNT(*) AS num_of_tracks_buyed
FROM Artist art
INNER JOIN Album alb ON art.ArtistId = alb.ArtistId 
INNER JOIN Track t ON t.AlbumId = alb.AlbumId 
INNER JOIN InvoiceLine il ON t.TrackId = il.TrackId 
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
	c.Email
	, 'customer' as type
FROM Customer c

UNION

SELECT 
	e.Email 
	, 'employee' as type
FROM Employee e;

SELECT 
	'min_salary' AS parametr
	, MIN(salary_in_usd) AS min_salary
FROM salaries

UNION

SELECT 
	'max_salary' AS parametr
	, MAX(salary_in_usd) AS min_salary
FROM salaries;

SELECT 
	c.Email
	, 'customer' as type
FROM Customer c

INTERSECT

SELECT 
	e.Email 
	, 'employee' as type
FROM Employee e;

SELECT 
	c.Email
	, 'customer' as type
FROM Customer c

EXCEPT

SELECT 
	e.Email 
	, 'employee' as type
FROM Employee e;

-- вивести всіх замовників, які здійснювали покупки, при чому музичні треки, які вони придбали
-- знаходяться в межах мінімум 3ьох різних жанрів
SELECT 
	c.CustomerId 
	, c.FirstName 
	, c.LastName 
	, COUNT(DISTINCT g.GenreId ) AS nmb_genres
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId 
INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
INNER JOIN Track t ON t.TrackId = il.TrackId 
INNER JOIN Genre g ON g.GenreId = t.GenreId 
GROUP BY 1, 2 , 3
HAVING COUNT(DISTINCT g.GenreId ) >= 3;

-- Вивести всіх виконавців і назви їх альбомів. Якщо у виконавця 
-- немає альбому - все одно показати виконавця 
SELECT 
	art.Name  
	, alb.Title 
FROM Artist art
LEFT JOIN Album alb ON art.ArtistId = alb.ArtistId; 

-- Вивести всіх клієнтів і кількість їх покупок
SELECT 
	c.FirstName 
	, c.LastName 
	, COUNT(i.InvoiceId)
FROM Customer c 
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId 
GROUP BY 1, 2;

-- Вивести всі жанри і кількість треків в кожному жанрі
-- ситуація: якби в якомусь жанрі не було треків, то в табл. був би NULL і щоб замість
-- NULL поставити 0 -> COALESCE
SELECT 
	g.Name
	, COALESCE(COUNT(t.TrackId), 0) AS nmb_tracks
FROM Genre g
LEFT JOIN Track t ON g.GenreId = t.GenreId 
GROUP BY 1
ORDER BY 2 DESC;

-- Потрібно показати всіх клієнтів і їх менеджерів — навіть тих у кого
-- менеджер не призначений або був звільнений
SELECT 
	c.FirstName 
	, c.LastName
	, e.FirstName 
	, e.LastName 
FROM Employee e
LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId; 

-- Вивести всіх виконавців і всі альбоми. Показати виконавців без альбомів і альбоми без виконавців
SELECT 
	art.Name
	, alb.Title
FROM Artist art
FULL JOIN Album alb ON alb.ArtistId = art.ArtistId; 

-- З'єднати таблицю Genre і MediaType через CROSS JOIN 
SELECT *
FROM Genre g 
CROSS JOIN MediaType mt; 

-- SELF JOIN
SELECT 
	e.FirstName
	, m.FirstName
FROM Employee e 
JOIN Employee m ON m.EmployeeId = e.ReportsTo;

-- Вивести імʼя клієнта і загальну суму його покупок, відсортувати від найбільшої
SELECT 
	c.FirstName 
	, c.LastName 
	, SUM(i.Total ) AS general_sum
FROM Customer c 
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY 1, 2
ORDER BY 3 DESC;

--Вивести всіх працівників і їх керівників
SELECT 
	e.FirstName AS name_empl
	, e.LastName 
	, e2.FirstName AS name_boss
FROM Employee e 
LEFT JOIN Employee e2 ON e.ReportsTo  = e2.EmployeeId;

-- Вивести топ 3 виконавців за кількістю проданих треків
SELECT 
	art.Name
	, COUNT(il.TrackId ) AS num_sold_tracks
FROM Artist art
LEFT JOIN Album alb ON art.ArtistId = alb.ArtistId
LEFT JOIN Track t ON alb.AlbumId = t.AlbumId 
LEFT JOIN InvoiceLine il ON il.TrackId = t.TrackId 
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 3;

-- CTE - Common Table Expression - тимчасова таблиця, яка створюється на час виконання запиту через WITH
WITH melomans AS (
	SELECT 
		c.CustomerId 
		, c.FirstName 
		, c.LastName 
		, COUNT(DISTINCT g.GenreId ) AS nmb_genres
	FROM Customer c
	INNER JOIN Invoice i ON c.CustomerId = i.CustomerId 
	INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId 
	INNER JOIN Track t ON t.TrackId = il.TrackId 
	INNER JOIN Genre g ON g.GenreId = t.GenreId 
	GROUP BY 1, 2 , 3
	HAVING COUNT(DISTINCT g.GenreId ) >= 3
)

, invoices AS (
	SELECT *
	FROM Invoice i
	WHERE i.InvoiceDate BETWEEN '2009-01-01 00:00:00' AND '2010-01-01 00:00:00'
)

SELECT *
FROM melomans m
WHERE m.CustomerId IN(SELECT CustomerId FROM invoices)
--LEFT JOIN invoices i ON m.CustomerId = i.CustomerId
--WHERE i.CustomerId IS NOT NULL