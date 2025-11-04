-- Database SetUp 
CREATE DATABASE SusEnergyFor;
GO

USE SusEnergyFor;
GO

-- Table creation
-- Plants (power plants / generation assets)
CREATE TABLE Plants (
    PlantID INT PRIMARY KEY,
    PlantName NVARCHAR(100) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    EnergyType NVARCHAR(30) NOT NULL,      -- Solar, Wind, Hydro, Biomass, Gas
    InstalledCapacityMW DECIMAL(10,2) NOT NULL,
    CommissionDate DATE,
    Status NVARCHAR(30)                     -- Operational, Under Maintenance, Decommissioned
);

-- EnergyProduction (daily aggregated production per plant)
CREATE TABLE EnergyProduction (
    ProductionID INT PRIMARY KEY,
    PlantID INT NOT NULL,
    RecordDate DATE NOT NULL,
    EnergyGeneratedMWh DECIMAL(12,3) NOT NULL,
    DowntimeHours DECIMAL(6,2) NOT NULL,
    EfficiencyPct DECIMAL(6,2) NOT NULL,
    CO2SavedTons DECIMAL(12,3) NOT NULL,
    CONSTRAINT FK_EP_Plant FOREIGN KEY (PlantID) REFERENCES Plants(PlantID)
);

-- Consumption (daily consumption per region and sector)
CREATE TABLE Consumption (
    ConsumptionID INT PRIMARY KEY,
    Region NVARCHAR(50) NOT NULL,
    RecordDate DATE NOT NULL,
    Sector NVARCHAR(50) NOT NULL,           -- Residential / Industrial / Commercial / Agricultural
    EnergyConsumedMWh DECIMAL(12,3) NOT NULL,
    PeakLoadMW DECIMAL(10,3) NOT NULL
);

-- Maintenance events
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY,
    PlantID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    MaintenanceType NVARCHAR(50),
    DowntimeHours DECIMAL(8,2),
    CostUSD DECIMAL(14,2),
    CONSTRAINT FK_MAINT_Plant FOREIGN KEY (PlantID) REFERENCES Plants(PlantID)
);

-- WeatherSnapshots (daily region-level weather drivers)
CREATE TABLE WeatherSnapshots (
    SnapshotID INT PRIMARY KEY,
    Region NVARCHAR(50) NOT NULL,
    SnapshotDate DATE NOT NULL,
    AvgTemperature DECIMAL(6,2),
    SolarRadiation DECIMAL(9,2),    -- W/m2
    WindSpeed DECIMAL(6,2),         -- m/s
    RainfallMM DECIMAL(8,3)
);

-- Financials (monthly per plant)
CREATE TABLE Financials (
    RecordID INT PRIMARY KEY,
    PlantID INT NOT NULL,
    MonthStart DATE NOT NULL,       -- first day of month
    OperationalCostUSD DECIMAL(14,2),
    RevenueUSD DECIMAL(14,2),
    SubsidyUSD DECIMAL(14,2),
    NetProfitUSD DECIMAL(14,2),
    CONSTRAINT FK_FIN_Plant FOREIGN KEY (PlantID) REFERENCES Plants(PlantID)
);

-- ForecastSnapshots (daily per region forecasts)
CREATE TABLE ForecastSnapshots (
    ForecastID INT PRIMARY KEY,
    Region NVARCHAR(50) NOT NULL,
    ForecastDate DATE NOT NULL,
    PredictedDemandMWh DECIMAL(12,3),
    PredictedProductionMWh DECIMAL(12,3),
    ForecastErrorPct DECIMAL(6,3)
);