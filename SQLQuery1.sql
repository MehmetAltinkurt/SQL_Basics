CREATE DATABASE new_db;

USE new_db;

CREATE TABLE departments
(
	id BIGINT NOT NULL,
	name VARCHAR(20) NULL,
	dept_name VARCHAR(20) NULL,
	seniority VARCHAR(20) NULL,
	graduation VARCHAR(20) NULL,
	salary BIGINT NULL,
	hire_date DATE NULL,
        CONSTRAINT pk_1 PRIMARY KEY (id)
 ) ;



ALTER TABLE departments
ADD CONSTRAINT unique_id_constraint UNIQUE (id);

ALTER TABLE departments
ADD CONSTRAINT identity_constraint IDENTITY (id);

--DROP TABLE departments;


/*
INSERT [INTO] Table_name | view name [column_list]
DEFAULT VALUES | values_list | select statement
*/

INSERT departments (id, name, dept_name, seniority, graduation, salary, hire_date)
VALUES
(10238,	'Eric'	   ,'Economics'	       ,'Experienced'	,'MSc' ,72000	,'2019-12-01'),
(13378,	'Karl'	   ,'Music'	       ,'Candidate'	,'BSc' ,42000	,'2022-01-01'),
(23493,	'Jason'	   ,'Philosophy'       ,'Candidate'	,'MSc' ,45000	,'2022-01-01'),
(30766,	'Jack'     ,'Economics'	       ,'Experienced'	,'BSc' ,68000	,'2020-06-04'),
(36299,	'Jane'	   ,'Computer Science' ,'Senior'	,'PhD' ,91000	,'2018-05-15'),
(40284,	'Mary'	   ,'Psychology'       ,'Experienced'	,'MSc' ,78000	,'2019-10-22'),
(43087,	'Brian'	   ,'Physics'	       ,'Senior'	,'PhD' ,93000	,'2017-08-18'),
(53695,	'Richard'  ,'Philosophy'       ,'Candidate'	,'PhD' ,54000	,'2021-12-17'),
(58248,	'Joseph'   ,'Political Science','Experienced'	,'BSc' ,58000	,'2021-09-25'),
(63172,	'David'	   ,'Art History'      ,'Experienced'	,'BSc' ,65000	,'2021-03-11'),
(64378,	'Elvis'	   ,'Physics'	       ,'Senior'	,'MSc' ,87000	,'2018-11-23'),
(96945,	'John'	   ,'Computer Science' ,'Experienced'	,'MSc' ,80000	,'2019-04-20'),
(99231,	'Santosh'  ,'Computer Science' ,'Experienced'	,'BSc' ,74000	,'2020-05-07');



/*
SELECT DISTINCT item(s)
FROM table(s)
WHERE predicate
GROUP BY field(s)
ORDER BY fields;
*/



SELECT TOP 2 id, name, dept_name
FROM departments
ORDER BY id



SET IDENTITY_INSERT departments ON;

INSERT departments (id, name, dept_name, seniority, graduation, salary, hire_date)
VALUES (44552,	'Edmond' ,'Economics'	,'Candidate','BSc' ,60000	,'2021-12-04')

SET IDENTITY_INSERT departments OFF;





CREATE TABLE #salary (
id BIGINT NOT NULL,
name VARCHAR (40) NULL,
salary BIGINT NULL
);


--the two codes below have the same functionality
INSERT #salary
SELECT id, name, salary FROM departments;


--the code below also tries to create #salary table
SELECT id, name, salary 
INTO #salary
FROM departments;


SELECT *
FROM #salary



-- UPDATE a row
UPDATE departments
SET name = 'Edward'
WHERE id = 44552;



-- DELETE from table
DELETE FROM departments WHERE id = 44552;



-- datetime functions
SELECT GETDATE() AS now;


SELECT DATENAME(HOUR, '2021-11-11') AS sample;


SELECT DATEPART(SECOND, GETDATE()) AS sample;

SELECT DAY('2021-11-19') AS sample;

SELECT MONTH('2021-11-19') AS sample;

SELECT YEAR('2021-11-19') AS sample;

SELECT DATEDIFF(week, '2021-01-01', '2021-02-12') AS DateDifference

SELECT DATEADD (SECOND, 1, '2021-12-31 23:59:59') AS NewDate

SELECT EOMONTH('2021-02-10') AS EndofFeb

SELECT ISDATE('2021-02-10') AS isdate_

SELECT ISDATE('15/2008/04') AS isdate_






--STRING FUNCTIONS

SELECT LEN('this is an example') AS sample

SELECT LEN(NULL) AS col1, LEN(10) AS col2, LEN(10.5) AS col3

SELECT CHARINDEX('yourself', 'Reinvent yourself') AS start_position;

SELECT CHARINDEX('r', 'Reinvent yourself') AS motto;

SELECT CHARINDEX('self', 'Reinvent yourself and ourself') AS motto;

SELECT PATINDEX('%ern%', 'this is not a pattern') AS sample

SELECT PATINDEX('%ern', 'this is not a pattern') AS sample

SELECT SUBSTRING('clarusway.com', LEN('clarusway.com')-1, LEN('clarusway.com'));

SELECT UPPER('clarusway') AS col;

SELECT LOWER('CLARUSWAY') AS col;

SELECT value from string_split('John,is,a,very,tall,boy.', ',')

SELECT SUBSTRING('Clarusway', 1, 3) AS substr

SELECT SUBSTRING('Clarusway', -5, 7) AS substr

SELECT SUBSTRING('Clarusway', -6, 2) AS substr

SELECT LEFT('Clarusway', 2) AS leftchars

SELECT RIGHT('Clarusway', 2) AS rightchars

SELECT TRIM('  Reinvent Yourself  ') AS new_string;

SELECT TRIM('@' FROM '@@@clarusway@@@@') AS new_string;

SELECT TRIM('ca' FROM 'cadillac') AS new_string;

SELECT LTRIM('   cadillac') AS new_string;

SELECT RTRIM('   cadillac   ') AS new_string;

SELECT REPLACE('REIMVEMT','M','N');

SELECT REPLACE('I do it my way.','do','did') AS song_name;

SELECT STR(123.45, 6, 1) AS num_to_str;

SELECT STR(123.45, 6, 2) AS num_to_str;

SELECT STR(123.45, 2, 2) AS num_to_str;

SELECT STR(FLOOR (123.45), 8, 3) AS num_to_str;

SELECT 'Reinvent' + ' yourself' AS concat_string;

SELECT CONCAT('Reinvent' , ' yourself') AS concat_string;

SELECT 'Way' + ' to ' + 'Reinvent ' + 'Yourself' AS motto;

SELECT CONCAT ('Robert' , ' ', 'Gilmore') AS full_name 




-- OTHER FUNCTIONS

SELECT 'customer' + '_' + CAST(1 AS VARCHAR(1)) AS col

SELECT CAST(4599.999999 AS numeric(5,1)) AS col

SELECT GETDATE() AS currenttime, CONVERT(DATE, GETDATE()) AS currentdate

SELECT GETDATE() AS currenttime, CONVERT(NVARCHAR, GETDATE(), 11)AS currentdate

SELECT ROUND(565.49, -2) AS col;

SELECT ROUND(123.9994, 3) AS col1, ROUND(123.9995, 3) AS col2;

SELECT ROUND(123.4545, 2) col1, ROUND(123.45, -2) AS col2;

SELECT ROUND(150.75, 0) AS col1, ROUND(150.75, 0, 1) AS col2;

SELECT ISNULL(NULL, 'Not null yet.') AS col;

SELECT ISNULL(1, 2) AS col;

SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value');

SELECT COALESCE(Null, Null, 'William', Null) AS col

SELECT NULLIF(4,4) AS Same, NULLIF(5,7) AS Different;

SELECT NULLIF('2021-01-01', '2021-01-01') AS col

SELECT ISNUMERIC ('William') AS col

SELECT ISNUMERIC (123.455) AS col








