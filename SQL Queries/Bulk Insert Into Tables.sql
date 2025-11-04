-- Bulk Insert Into Tables
BULK INSERT dbo.Plants
FROM 'D:\Sustainable-Energy-Forecasting\DataSet\Plants.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

BULK INSERT dbo.Consumption
FROM 'D:\Sustainable-Energy-Forecasting\DataSet\Consumption.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

BULK INSERT dbo.EnergyProduction
FROM 'D:\Sustainable-Energy-Forecasting\DataSet\EnergyProduction.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

BULK INSERT dbo.Financials
FROM 'D:\Sustainable-Energy-Forecasting\DataSet\Financials.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

BULK INSERT dbo.ForecastSnapshots
FROM 'D:\Sustainable-Energy-Forecasting\DataSet\ForecastSnapshots.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

BULK INSERT dbo.Maintenance
FROM 'D:\Sustainable-Energy-Forecasting\DataSet\Maintenance.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

BULK INSERT dbo.WeatherSnapshots
FROM 'D:\Sustainable-Energy-Forecasting\DataSet\WeatherSnapshots.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  TABLOCK
);

CREATE INDEX IX_EP_PlantID_RecordDate ON EnergyProduction(PlantID, RecordDate);
CREATE INDEX IX_Cons_Region_RecordDate ON Consumption(Region, RecordDate);
CREATE INDEX IX_WS_Region_Date ON WeatherSnapshots(Region, SnapshotDate);