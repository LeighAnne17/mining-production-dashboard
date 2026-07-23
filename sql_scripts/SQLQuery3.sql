--Creating downtime table
USE mining_dashboard;
GO

CREATE TABLE downtime (
	downtime_id INT IDENTITY(1,1) PRIMARY KEY,
	[date] DATE NOT NULL,
	Equipment_ID VARCHAR(20) NOT NULL,
	Reason VARCHAR(100) NOT NULL,
	Downtime_Hours DECIMAL(5,2) NOT NULL
);
GO

--Converting data types and migrate data from staging table
INSERT INTO downtime ([date], Equipment_ID, Reason, Downtime_Hours)
SELECT
	TRY_CONVERT(DATE, [date]) AS [date],
	Equipment_ID,
	Reason,
	TRY_CONVERT(DECIMAL(5,2), [Downtime_Hours]) AS Downtime_Hours
FROM downtime_staging
WHERE TRY_CONVERT(DECIMAL(5,2), [Downtime_Hours]) IS NOT NULL;
GO

DROP TABLE downtime_staging;
GO