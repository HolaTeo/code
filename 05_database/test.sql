# Mysql - Basic syntax
# Create, Alter, Drop, Insert, SELECT
# 1. Create
# 1.1 Database
SHOW DATABASES;
# test 데이터 베이스 생성
CREATE DATABASE test;

# test 데이터 베이스 선택
USE test;
# 현재 데이터 베이스 확인
SELECT DATABASE()

# 제약조건이 없는 user1 테이블 생성
CREATE TABLE user1(user_id INT, 
name Varchar(20),
email Varchar(30),
age INT(3),
rdate DATE
)

# 제약조건이 있는 user2 테이블 생성
CREATE TABLE user2(
user_id INT PRIMARY KEY AUTO_INCREMENT,
name Varchar(20) NOT NULL,
email Varchar(30) UNIQUE NOT NULL,
age INT(3) DEFAULT '30',
rdate TIMESTAMP
)

# 2. Alter
# 2.1 Database
# ALTER를 이용하여 데이터베이스 encoding을 변경할수 있습니다.
# 현재 문자열 인코딩 확인

show variables like "character_set_database";

# test 데이터 베이스의 문자열 인코딩을 utf8으로 변경
ALTER DATABASE test CHARACTER SET = utf8;
ALTER DATABASE test CHARACTER SET = ASCII;

# 문자열 인코딩 변경 결과 확인
show variables like "character_set_database";
# 2.2 Table
# ALTER를 이용하여 TABLE 컬럼을 추가하거나 삭제하거나 수정할수 있습니다.
# 2.2.1 ADD
# user2 테이블에 TEXT 데이터 타입을 갖는 tmp 컬럼을 추가
ALTER TABLE user2 ADD tmp TEXT;
# 2.2.2 MODIFY
# user2 테이블에 INT(3) 데이터 타입을 갖는 tmp 컬럼으로 수정
ALTER TABLE user2 MODIFY COLUMN tmp INT(3);
# 2.2.3 DROP
# user2 테이블의 tmp 컬럼을 삭제
ALTER TABLE user2 DROP tmp;

# 3. DROP
# DROP을 시용하여 데이터베이스나 테이블를 삭제할수 있습니다.
# 3.1 Database
# tmp 데이터 베이스 생성
CREATE DATABASE tmp;
SHOW DATABASES;
# tmp 데이터 베이스 삭제
DROP DATABASE tmp;
SHOW DATABASES;

#3.2 Table
# tmp 데이터 베이스 생성
CREATE DATABASE tmp;
# tmp 데이터 베이스 선택
USE tmp;
# tmp 테이블 생성
CREATE TABLE tmp( id INT );
# tmp 테이블 삭제
DROP TABLE tmp;
# 4. INSERT
# 4.1 syntax
# test 데이터 베이스 선택
USE test;
INSERT INTO user1(user_id, name, email, age, rdate)
VALUES (1, "jin", "pdj@gmail.com", 30, now()),
(2, "peter", "peter@daum.net", 33, '2017-02-20'),
(3, "alice", "alice@naver.com", 23, '2018-01-05'),
(4, "po", "po@gmail.com", 43, '2002-09-16'),
(5, "andy", "andy@gmail.com", 17, '2016-04-28'),
(6, "jin", "jin1224@gmail.com", 33, '2013-09-02');

# 5. SELECT : 데이터 조회
# 5.1 basic

# user_id, name, rdate 세개의 컬럼 데이터 조회
SELECT user_id, NAME, age
FROM user1

# 5.2 ALIAS
# alias(as)를 이용하여 컬럼명을 변경할수 있습니다. as는 생략이 가능합니다.user1user1user1

SELECT user_id as "ID", name as "Username", rdate as "AGES"
FROM user1

# 5.3 DISTINCT
# DISTINCT를 이용하여 특정 컬럼의 중복 데이터를 제거할수 있습니다.
# name 컬럼을 중복 제거하여 조회
SELECT DISTINCT(NAME) 
FROM user1

# 5.4 WHERE
# 나이가 30살 이상인 user를 조회
SELECT *
FROM user1
WHERE age >= 30

# 등록일이 2016-01-01일 이후의 user를 조회
SELECT *
FROM user1
WHERE rdate >= "2016-01-01"

# 등록일이 2010-01-01에서 2017-12-31인 user를 조회 (AND는 둘다 true이면 true, OR도 사용가능)
SELECT *
FROM user1
WHERE rdate >= "2010-01-01" AND rdate <= "2017-12-13"

#BETWEEN을 사용하여 기간 조회 (숫자데이터도 사용 가능)
SELECT *
FROM user1
WHERE rdate BETWEEN "2010-01-01" AND "2017-12-13"

# 5.5 ORDER BY

# age로 오름차순 정렬 (ASC는 생략이 가능)
SELECT *
FROM user1
ORDER BY age ASC
# age로 내림차순 정렬
SELECT *
FROM user1
ORDER BY age DESC
# age로 내림차순 정렬하고 rdate를 오름차순 정렬
SELECT *
FROM user1
ORDER BY age DESC, rdate

# 나이가 20세에서 40세 사이에 있는 사용자를 이름순으로 정렬
# 중복데이터 제거해서 이름만 출력
SELECT DISTINCT(NAME)
FROM user1
WHERE age BETWEEN 20 AND 39
ORDER BY NAME desc

# 5.6 CONCAT
# CONCAT을 사용하여 select한 데이터를 합쳐서 새로운 컬럼으로 보여주는 것이 가능합니다.
# name과 age를 같이 보여주도록 조회
SELECT email, CONCAT(name, "(", age, ")") AS "name_age"
FROM user1

# email에 gmail이 들어간 데이터 조회
SELECT *
FROM user1
WHERE email LIKE "%@daum%"

# email에 gmail이 들어가지 않는 데이터 조회
SELECT *
FROM user1
WHERE email NOT LIKE "%@gmail%"

# 5.8 IN
# IN은 여러개의 조건을 만족하는 데이터를 조회하고 싶을때 사용합니다. WHERE 절의 조건을 여러개 사용하는것을 간단하게 만들수 있습니다.
# name이 peter와 alice 조회
SELECT *
FROM user1
WHERE name="peter" OR name="alice"

# name이 peter와 alice 조회
SELECT *
FROM user1
WHERE name IN ("peter", "alice")

SELECT *
FROM user1
WHERE name IN (
SELECT distinct(NAME)
FROM user1
WHERE age>30
)

# 5.9 LIMIT
# user1 테이블에서 3개의 데이터 조회
SELECT *
FROM user1
LIMIT 3

# user1 테이블에서 두번째에서 네번째까지의 3개의 데이터 조회
SELECT *
FROM user1
LIMIT 1,3

# 6. UPDATE

# jin 이름을 가지고 있는 사람의 나이를 20, 이메일을 pdj@daum.net으로 변경
UPDATE user1
SET age=20, email="pdj@daum.net"
WHERE name="jin"

SELECT *
FROM user1
WHERE age BETWEEN 20 AND 29

# 7. DELETE

# 2016-01-01 이전 데이터 삭제
DELETE FROM user1
WHERE rdate < "2016-01-01"

# 8. GROUP
# 8.1 GROUP BY

# SQL 아래와 같은 그룹함수가 있습니다.
# count, min, max, sum, avg

# world 데이터 베이스로 이동
# world 데이터 베이스는 city, country, countrylanguage 테이블이 있는 데이터 베이스 입니다.
use world

# 8.1.1 COUNT
# city 테이블의 CountryCode를 묶고 각 코드마다 몇개의 데이터가 있는지 확인
SELECT CountryCode, COUNT(CountryCode) AS Count
FROM city
GROUP BY CountryCode

# countrylanguage 테이블에서 전체 언어가 몇개 있는지 구하시오.
SELECT COUNT(DISTINCT(Language)) as language_count
FROM countrylanguage

# 8.1.2 MAX
# 대륙별 인구수와 GNP 최대 값을 조회
SELECT continent, MAX(Population) as Population, MAX(GNP) as GNP
FROM country
GROUP BY continent

# 8.1.3 MIN
# 대륙별 인구수와 GNP 최소 값을 조회 (GNP와 인구수가 0이 아닌 데이터 중에서)
SELECT continent, MIN(Population) as Population, MIN(GNP) as GNP
FROM country
WHERE GNP != 0 AND Population != 0
GROUP BY continent

# 8.1.4 SUM
# 대륙별 총 인구수와 총 GNP
SELECT continent, SUM(Population) as Population, SUM(GNP) as GNP
FROM country
WHERE GNP != 0 AND Population != 0
GROUP BY continent

# 8.1.5 AVG
# 대륙별 평균 인구수와 평균 GNP 결과를 인구수로 내림차순 정렬
SELECT continent, AVG(Population) as Population, AVG(GNP) as GNP
FROM country
WHERE GNP != 0 AND Population != 0
GROUP BY continent
ORDER BY Population DESC

# 8.2 HAVING
# GROUP BY에서 반환되는 결과에 조건을 줄수 있습니다.
# 대륙별 전체인구를 구하고 5억이상인 대륙만 조회
SELECT continent, SUM(Population) as Population
FROM country
GROUP BY continent
HAVING Population > 500000000

# 대륙별 평균 인구수, 평균 GNP, 1인당 GNP한 결과를 1인당 GNP가 0.01 이상인 데이터를 조회하고1인당 GNP를 내림차순으로 정렬
SELECT continent, AVG(Population) as Population, AVG(GNP) as GNP,
AVG(GNP) / AVG(Population) * 1000 as AVG
FROM country
WHERE GNP != 0 AND Population != 0
GROUP BY continent
HAVING AVG > 0.01
ORDER BY AVG DESC

# 소수점 올림, 반올림, 버림함수
SELECT CEIL(12.345)
SELECT round(12.345,2)
SELECT truncate(12.345,2)

# 
SELECT CODE, round((GNP / population)*1000,2)
FROM country

# 조건문

#if : if(조건, 참, 거짓)
# 도시의 인구가 100만 이상 big city, 100만 미만 small city 출력
# column : city_scale
SELECT NAME, population, if(population >= 1000000, "Big City", "Small City") AS city_scale
FROM city

# ifnull : ifnull(참, 거짓)
# country 테이블에서 독립년도(indepyear)가 없으면 0으로 출력
SELECT NAME, ifnull(indepyear, 0) AS indepyear
FROM country

# CASE
# CASE 
# WHEN (쪼건1) THEN (출력1)
# WHEN (쪼건2) THEN (출력2)
# END AS (컬럼명)

# 나라별 10억 이상, 1억 이상, 1억 이하 조건을 출력
SELECT NAME, population,
case
	WHEN population>10000000 THEN "upper 1 bil"
	WHEN population > 1000000 THEN "upper 100 mil"
	ELSE "below 100 mil"
END AS result
FROM country


# DATE_FORMAT : 날짜 데이터의 포멧을 변경해주는 함수
USE sakila
# sakila 데이터 베이스에서 월별 총 수입
SELECT DATE_FORMAT(payment_date, "%Y-%m") AS monthly, SUM(amount) AS amount
FROM payment
GROUP BY monthly

#4.1 MAKE TEST TABLE & DATA
USE world
# create table & data
CREATE TABLE user (
user_id int(11) unsigned NOT NULL AUTO_INCREMENT,
name varchar(30) DEFAULT NULL,
PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE addr (
id int(11) unsigned NOT NULL AUTO_INCREMENT,
addr varchar(30) DEFAULT NULL,
user_id int(11) DEFAULT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO user(name)
VALUES ("jin"),
("po"),
("alice"),
("petter");

INSERT INTO addr(addr, user_id)
VALUES ("seoul", 1),
("pusan", 2),
("deajeon", 3),
("deagu", 5),
("seoul", 6);

# inner join
SELECT addr.addr, addr.user_id, user.name
FROM addr
JOIN user
ON addr.user_id = user.user_id

# world 도시이름, 국가이름을 출력
SELECT city.countrycode, city.name, country.name
FROM city
JOIN country
ON city.countrycode = country.code

# left join
SELECT id, addr.addr, addr.user_id, IFNULL(user.name, "-")
FROM addr
LEFT JOIN user
ON addr.user_id = user.user_id

# right join
SELECT addr.id, addr.addr, user.user_id, user.name
FROM addr
right JOIN user
ON addr.user_id = user.user_id

# union : select 문의 결과를 합쳐서 출력
# 자동으로 중복을 제거
SELECT NAME
FROM user
union
SELECT addr
FROM addr

# outer join
SELECT user.name, addr.addr, addr.user_id
FROM user
left JOIN addr
ON user.user_id =addr.user_id
union
SELECT user.name, addr.addr, addr.user_id
FROM user
right JOIN addr
ON user.user_id =addr.user_id

# sub-query : 쿼리문안에 쿼리가 있는 문법
# select, from, where

# 전체 나라수, 전체 도시수, 전체 언어수를 출력
SELECT
(SELECT COUNT(*) FROM country) AS total_country,
(SELECT COUNT(*) FROM city) AS total_city,
(SELECT COUNT(DISTINCT(LANGUAGE)) FROM countrylanguage) AS total_language

# 800만 이상이 되는 도시의 국가 코드, 이름, 도시인구수를 출력
SELECT *
from
	(SELECT countrycode, NAME, population
	FROM city
	WHERE population >= 8000000) AS city
JOIN
	(SELECT CODE, NAME
	FROM country) AS country
ON city.countrycode = country.code	

# 800만 이상 도시의 국가코드, 국가이름, 대통령이름을 출력( WHERE 절에 사용 )
SELECT code, name, HeadOfState
FROM country
WHERE code IN (
SELECT DISTINCT(countrycode) 
FROM city WHERE population > 8000000
)