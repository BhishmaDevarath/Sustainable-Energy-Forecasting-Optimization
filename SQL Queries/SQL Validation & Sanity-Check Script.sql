-- SQL Validation & Sanity-Check Scripts
-- 1. Basic Table Counts
SELECT 
  (SELECT COUNT(*) FROM Plants) AS TotalPlants,
  (SELECT COUNT(*) FROM EnergyProduction) AS TotalProduction,
  (SELECT COUNT(*) FROM Consumption) AS TotalConsumption,
  (SELECT COUNT(*) FROM Maintenance) AS TotalMaintenance,
  (SELECT COUNT(*) FROM WeatherSnapshots) AS TotalWeatherSnapshots,
  (SELECT COUNT(*) FROM Financials) AS TotalFinancials,
  (SELECT COUNT(*) FROM ForecastSnapshots) AS TotalForecasts;

-- 2. Orphan / Referential Integrity Checks
-- Production → Plants
SELECT COUNT(*) AS Orphan_ProductionPlants
FROM EnergyProduction ep
LEFT JOIN Plants p ON ep.PlantID = p.PlantID
WHERE p.PlantID IS NULL;

-- Maintenance → Plants
SELECT COUNT(*) AS Orphan_MaintenancePlants
FROM Maintenance m
LEFT JOIN Plants p ON m.PlantID = p.PlantID
WHERE p.PlantID IS NULL;

-- Financials → Plants
SELECT COUNT(*) AS Orphan_FinancialsPlants
FROM Financials f
LEFT JOIN Plants p ON f.PlantID = p.PlantID
WHERE p.PlantID IS NULL;

-- 3. Null or Invalid Data Checks
-- Missing critical values
SELECT * FROM Plants WHERE Region IS NULL OR EnergyType IS NULL;
SELECT * FROM EnergyProduction WHERE EnergyGeneratedMWh <= 0;
SELECT * FROM Consumption WHERE EnergyConsumedMWh <= 0;

-- Check date ranges
SELECT 
  MIN(RecordDate) AS MinDate,
  MAX(RecordDate) AS MaxDate
FROM EnergyProduction;

SELECT 
  MIN(RecordDate) AS MinDate,
  MAX(RecordDate) AS MaxDate
FROM Consumption;

-- 4. Range Sanity Checks
-- Efficiency should be 0–100
SELECT COUNT(*) AS InvalidEfficiency
FROM EnergyProduction
WHERE EfficiencyPct < 0 OR EfficiencyPct > 100;

-- Profit sanity
SELECT COUNT(*) AS NegativeRevenue
FROM Financials
WHERE RevenueUSD < 0 OR OperationalCostUSD < 0;

-- 5. Aggregate-level validation
-- Average load vs. generation per region
SELECT 
  ep.Region,
  COUNT(DISTINCT ep.PlantID) AS NumPlants,
  SUM(ep.EnergyGeneratedMWh) AS TotalGeneratedMWh,
  SUM(c.EnergyConsumedMWh) AS TotalConsumedMWh,
  ROUND(SUM(ep.EnergyGeneratedMWh) / NULLIF(SUM(c.EnergyConsumedMWh),0) * 100, 2) AS SupplyToDemandPct
FROM EnergyProduction ep
JOIN Plants p ON ep.PlantID = p.PlantID
JOIN Consumption c ON c.Region = p.Region AND c.RecordDate = ep.RecordDate
GROUP BY ep.Region;

-- Analytical View Definitions
-- 1. Aggregates daily generation vs. consumption balance per region.
GO
CREATE VIEW vw_RegionDailyBalance AS
SELECT 
    p.Region,
    ep.RecordDate,
    SUM(ep.EnergyGeneratedMWh) AS TotalGenerationMWh,
    SUM(c.EnergyConsumedMWh) AS TotalConsumptionMWh,
    (SUM(ep.EnergyGeneratedMWh) - SUM(c.EnergyConsumedMWh)) AS NetSurplusMWh
FROM EnergyProduction ep
JOIN Plants p ON ep.PlantID = p.PlantID
JOIN Consumption c ON c.Region = p.Region AND c.RecordDate = ep.RecordDate
GROUP BY p.Region, ep.RecordDate;
GO

-- 2. Combines production + financial efficiency per plant.
GO
CREATE VIEW vw_PlantPerformance AS
SELECT 
    p.PlantID,
    p.PlantName,
    p.Region,
    p.EnergyType,
    ROUND(AVG(ep.EfficiencyPct), 2) AS AvgEfficiency,
    ROUND(SUM(ep.EnergyGeneratedMWh) / NULLIF(COUNT(DISTINCT ep.RecordDate),0), 2) AS AvgDailyGen,
    ROUND(SUM(f.NetProfitUSD) / NULLIF(SUM(f.RevenueUSD),0) * 100, 2) AS AvgProfitMarginPct
FROM Plants p
JOIN EnergyProduction ep ON p.PlantID = ep.PlantID
JOIN Financials f ON p.PlantID = f.PlantID
GROUP BY p.PlantID, p.PlantName, p.Region, p.EnergyType;
GO

-- 3. Explores how weather factors correlate with energy generation by region.
GO
CREATE VIEW vw_WeatherImpact AS
SELECT 
    p.Region,
    w.SnapshotDate,
    AVG(w.SolarRadiation) AS AvgSolarRadiation,
    AVG(w.WindSpeed) AS AvgWindSpeed,
    SUM(ep.EnergyGeneratedMWh) AS TotalGenerationMWh
FROM EnergyProduction ep
JOIN Plants p ON ep.PlantID = p.PlantID
JOIN WeatherSnapshots w ON p.Region = w.Region AND ep.RecordDate = w.SnapshotDate
GROUP BY p.Region, w.SnapshotDate;
GO

-- 4. Monthly cost–revenue–profit per region.
GO
CREATE VIEW vw_FinancialSummary AS
SELECT 
    p.Region,
    f.MonthStart,
    SUM(f.RevenueUSD) AS TotalRevenue,
    SUM(f.OperationalCostUSD) AS TotalCost,
    SUM(f.NetProfitUSD) AS TotalProfit,
    ROUND(SUM(f.NetProfitUSD) / NULLIF(SUM(f.RevenueUSD),0) * 100, 2) AS ProfitMarginPct
FROM Financials f
JOIN Plants p ON f.PlantID = p.PlantID
GROUP BY p.Region, f.MonthStart;
GO

SELECT * FROM vw_RegionDailyBalance WHERE Region='North' ORDER BY RecordDate;
SELECT * FROM vw_PlantPerformance ORDER BY AvgEfficiency DESC;