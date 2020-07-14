SELECT COUNT(DISTINCT(continent)) AS count 
from country

SELECT continent, COUNT(continent) AS count
FROM country
GROUP BY continent
ORDER BY count desc


SELECT countrycode, sum(population) AS population
FROM city
GROUP BY countrycode
HAVING population >= 50000000
ORDER BY population DESC

SELECT LANGUAGE, COUNT(LANGUAGE) AS count
FROM countrylanguage
GROUP BY language
ORDER BY COUNT desc
LIMIT 4, 6

SELECT LANGUAGE, COUNT(LANGUAGE) AS count
FROM countrylanguage
GROUP BY LANGUAGE
HAVING COUNT >= 15
ORDER BY COUNT desc

SELECT continent, sum(surfacearea) AS surfacearea
FROM country
GROUP BY continent
ORDER BY surfacearea desc