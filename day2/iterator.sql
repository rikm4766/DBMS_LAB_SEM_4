--q1
SELECT fname
FROM ACTOR
WHERE aid IN (
    SELECT C.aid
    FROM MOVIE M
    JOIN CASTING C ON M.mid = C.mid
    WHERE M.m_year BETWEEN 1801 AND 1900
)
AND aid IN (
    SELECT C.aid
    FROM MOVIE M
    JOIN CASTING C ON M.mid = C.mid
    WHERE M.m_year BETWEEN 1901 AND 1950
);



--Q2

SELECT `MOVIE`.name FROM `MOVIE` WHERE `MOVIE`.mid IN(
SELECT `MOVIE_DIRECTOR`.mid from `MOVIE_DIRECTOR` LEFT JOIN `MOVIE` ON `MOVIE_DIRECTOR`.mid=`MOVIE`.mid WHERE(`MOVIE`.m_year%4=0)AND(`MOVIE`.m_year%100!=0)OR(`MOVIE`.m_year%400=0)
)

--Q3


SELECT M1.name, M1.m_year, M1.m_rank
FROM MOVIE M1
JOIN MOVIE M2 ON `M1`.m_year = M2.m_year
WHERE M2.name = 'CityLights'
AND M1.m_rank > M2.m_rank;

--Q4

SELECT CONCAT(ACTOR.fname," ",`ACTOR`.lname) FROM `ACTOR`
JOIN `CASTING` ON `ACTOR`.aid=`CASTING`.aid 
JOIN `MOVIE` ON `CASTING`.mid=`MOVIE`.mid
WHERE `MOVIE`.name='Devdas';


--q5

SELECT `MOVIE`.name ,COUNT(`CASTING`.aid) as CAST_SIZE FROM `CASTING` JOIN `MOVIE` ON `CASTING`.mid=`MOVIE`.mid 
GROUP BY `MOVIE`.name
ORDER BY CAST_SIZE DESC
LIMIT 1;

-- q5

SELECT `MOVIE`.name ,COUNT(`CASTING`.aid) as CAST_SIZE FROM `CASTING` JOIN `MOVIE` ON `CASTING`.mid=`MOVIE`.mid 
GROUP BY `MOVIE`.name
ORDER BY CAST_SIZE ASC
LIMIT 1;

-- q6

SELECT A.aid, A.fname, A.lname
FROM ACTOR A
JOIN CASTING C ON A.aid = C.aid
JOIN MOVIE_DIRECTOR MD ON C.mid = MD.mid
GROUP BY A.aid, A.fname, A.lname
HAVING COUNT(DISTINCT MD.did) >= 3;

-- q7
SELECT fname, lname
FROM ACTOR
WHERE aid NOT IN (
    SELECT C.aid
    FROM CASTING C
    JOIN MOVIE M ON C.mid = M.mid
    WHERE M.m_year >= 2003
);



-- q8

SELECT `ACTOR`.fname, COUNT(*) AS TOTAL_MOVIE FROM `CASTING` JOIN `ACTOR` ON `ACTOR`.aid = `CASTING`.aid WHERE `ACTOR`.gender='FEMALE' GROUP BY `ACTOR`.aid 
ORDER BY TOTAL_MOVIE DESC;

-- q9
SELECT 
    A1.fname AS male_actor,
    A2.fname AS female_actor,
    COUNT(DISTINCT C1.mid) AS total_movies
FROM CASTING C1
JOIN CASTING C2 ON C1.mid = C2.mid
JOIN ACTOR A1 ON C1.aid = A1.aid
JOIN ACTOR A2 ON C2.aid = A2.aid
WHERE A1.gender = 'MALE'
AND A2.gender = 'FEMALE'
GROUP BY A1.aid, A2.aid
ORDER BY total_movies DESC;


--Q10

SELECT `MOVIE`.name,`MOVIE`.m_rank  FROM `ACTOR` 
JOIN `CASTING` ON `ACTOR`.aid=`CASTING`.aid
JOIN `MOVIE` ON `CASTING`.mid=`MOVIE`.mid
WHERE (`ACTOR`.fname='Hrithik') 
ORDER BY `MOVIE`.m_rank DESC;



--q11

SELECT CONCAT(`ACTOR`.fname," ",`ACTOR`.lname) FROM `CASTING`
JOIN `MOVIE` ON `CASTING`.mid=`MOVIE`.mid
JOIN `ACTOR` ON `CASTING`.aid=`ACTOR`.aid
WHERE `MOVIE`.name='3 Idiots'



--q12

SELECT 
    A.fname,
    A.lname,
    M.name AS movie_name,
    COUNT(DISTINCT C.role) AS role_count
FROM ACTOR A
JOIN CASTING C ON A.aid = C.aid
JOIN MOVIE M ON C.mid = M.mid
GROUP BY A.aid, M.mid;


--q13

SELECT A.fname, A.lname, M.name
FROM ACTOR A
JOIN CASTING C ON A.aid = C.aid
JOIN MOVIE M ON C.mid = M.mid
WHERE C.aid IN (
    SELECT aid
    FROM CASTING
    GROUP BY aid
    HAVING COUNT(*) >= 2
);


--q14



    SELECT m_year
    FROM MOVIE
    GROUP BY m_year
    ORDER BY COUNT(*) DESC
    LIMIT 1



--Q15

SELECT DISTINCT D.fname, D.lname
FROM DIRECTOR D
JOIN MOVIE_DIRECTOR MD ON D.did = MD.did
JOIN MOVIE M ON MD.mid = M.mid
WHERE M.m_rank >= 8;


--Q17

SELECT DISTINCT A.fname, A.lname
FROM ACTOR A
JOIN CASTING C ON A.aid = C.aid
WHERE C.mid IN (
    SELECT C2.mid
    FROM CASTING C2
    JOIN ACTOR A2 ON A2.aid = C2.aid
    WHERE A2.fname = 'Shah Rukh' AND A2.lname = 'Khan'
);


--q18

SELECT m_year, COUNT(*) 
FROM MOVIE
WHERE m_rank = 7
GROUP BY m_year;


--q19

SELECT name
FROM MOVIE
ORDER BY m_rank DESC
LIMIT 1;

--q20

SELECT `MOVIE`.name,`MOVIE`.m_year FROM `MOVIE` WHERE mid IN(
SELECT `GENRE`.mid FROM `GENRE` WHERE `type`='Romance')
ORDER BY `MOVIE`.m_rank DESC
LIMIT 1;



SELECT dt.dept_name, dt.total_salary
FROM 
    (SELECT dept_name, SUM(salary) AS total_salary
     FROM instructor
     GROUP BY dept_name) AS dt,

    (SELECT AVG(total_salary) AS avg_salary
     FROM 
        (SELECT dept_name, SUM(salary) AS total_salary
         FROM instructor
         GROUP BY dept_name) AS inner_dt
    ) AS avg_dt

WHERE dt.total_salary > avg_dt.avg_salary;

