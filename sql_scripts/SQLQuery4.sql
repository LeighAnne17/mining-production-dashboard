USE mining_dashboard;
GO

-- CORE KPIs
----------------------------------------------------------------------------------------------------------
-- Total Ore Produced
SELECT
	SUM(Ore_Tonnes) AS total_ore_produced
FROM production;

--Total Loads Hauled and Total Tonnes Hauled
SELECT
	SUM(Loads) AS total_loads_hauled,
	SUM(Tonnes_Hauled) AS total_tonnes_hauled
FROM truck_loads;

--Total Fuel Consumed 
SELECT
	SUM(Fuel_Litres) AS total_fuel_consumed
FROM fuel_usage;

-- Total Downtime
SELECT
	SUM(Downtime_Hours) AS total_downtime_hours
FROM downtime;

-- BUSINESS ANALYSIS QUERIES
-------------------------------------------------------------------------------------------------------------
-- Best Performing Pit
SELECT TOP 1
	Pit,
	SUM(Ore_Tonnes) AS total_ore
FROM production
GROUP BY Pit
ORDER BY total_ore DESC;

-- Best Performing Shift
SELECT TOP 1
	Shift,
	SUM(Ore_Tonnes) AS total_ore
FROM production
GROUP BY Shift
ORDER BY total_ore DESC;

-- Top 10 Trucks by Tonnes Hauled
SELECT TOP 10
	Truck_ID,
	SUM(Tonnes_Hauled) AS total_hauled
FROM truck_loads
GROUP BY Truck_ID
ORDER BY total_hauled DESC;

--Most Fuel-Consuming Equipment
SELECT
	Equipment_ID,
	SUM(Fuel_Litres) AS total_fuel
FROM fuel_usage
GROUP BY Equipment_ID
ORDER BY total_fuel DESC;

--Downtime by Reason
SELECT
	Reason,
	SUM(Downtime_Hours) AS total_Hours
FROM downtime
GROUP BY Reason
ORDER BY total_hours DESC;

-- Monthly Production Trend
SELECT
	FORMAT([Date], 'yyyy-MM') AS production_month,
	SUM(Ore_Tonnes) AS total_ore
FROM production
GROUP BY FORMAT([Date], 'yyyy-MM')
ORDER BY production_month ASC;
GO