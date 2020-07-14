SELECT distinct(continent)
FROM country

SELECT NAME, Population
FROM city
WHERE CountryCode = "KOR" and population >=1000000
ORDER BY Population DESC

SELECT NAME, Countrycode, Population
FROM city
WHERE population BETWEEN 8000000 AND 10000000
ORDER BY population DESC

SELECT Code, concat(NAME, "(" ,IndepYear, ")"), 
Continent, Population
FROM country
WHERE IndepYear BETWEEN 1940 AND 1950
ORDER BY IndepYear, Population DESC

SELECT *
FROM countrylanguage
WHERE LANGUAGE IN ("English", "Spanish", "Korean")
AND Percentage >= 50
ORDER BY Percentage desc

SELECT CODE, NAME, Continent, GovernmentForm, population 
FROM country
WHERE CODE LIKE "A%" AND GovernmentForm LIKE "%Republic%"