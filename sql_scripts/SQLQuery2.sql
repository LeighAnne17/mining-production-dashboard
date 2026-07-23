-- creating the permanent production table with optimised data types
USE mining_dashboard;
GO

CREATE TABLE fuel_usage (
	fuel_entry_id INT IDENTITY(1,1) PRIMARY KEY,
	Equipment_ID VARCHAR(20) NOT NULL,
	[date] DATE NOT NULL,
	Fuel_Litres DECIMAL(10,2) NOT NULL
);
GO

-- convert the data types and migrate data from the staging table
INSERT INTO fuel_usage (Equipment_ID, [date], Fuel_Litres)
SELECT
	Equipment_ID,
	TRY_CONVERT(DATE, [date]) AS [date],
	TRY_CONVERT(DECIMAL(10,2), Fuel_Litres) AS Fuel_litres
FROM fuel_usage_staging
WHERE TRY_CONVERT(DECIMAL(10,2), Fuel_Litres) IS NOT NULL;
GO

--cleaning database by dropping the temporary staging table
DROP TABLE fuel_usage_staging;
GO