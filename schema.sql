SELECT * 
FROM dbo.CovidData_Deaths

SELECT * 
FROM dbo.CovidData_Vaccinations


SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM dbo.CovidData_Deaths
ORDER BY 1

-- Total Cases vs Total Deaths
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percentage 
FROM dbo.CovidData_Deaths
WHERE total_cases > 0 AND location LIKE '%states%'

-- Total Cases vs Population
SELECT location, date, population, total_cases, (total_cases/population)*100 AS Case_Percentage 
FROM dbo.CovidData_Deaths
WHERE location LIKE '%states%'


-- Highest Infection Rate compared to Population
SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Infected_Percent 
FROM dbo.CovidData_Deaths
WHERE population > 0
GROUP BY location, population
ORDER BY Infected_Percent DESC

--Countries with Highest Death Count
SELECT location, MAX(total_deaths) AS Total_Death_Count 
FROM dbo.CovidData_Deaths
WHERE LEN(continent)>0
GROUP BY location
ORDER BY Total_Death_Count DESC

SELECT location, MAX(total_deaths) AS Total_Death_Count 
FROM dbo.CovidData_Deaths
WHERE LEN(continent)=0
GROUP BY location
ORDER BY Total_Death_Count DESC

SELECT continent, MAX(total_deaths) AS Total_Death_Count 
FROM dbo.CovidData_Deaths
--WHERE LEN(continent)=0
GROUP BY continent
ORDER BY Total_Death_Count DESC


-- Global Numbers
SELECT date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as Death_percentage
FROM dbo.CovidData_Deaths
WHERE LEN(continent)>0 AND new_cases > 0
GROUP BY date
ORDER BY 1,2