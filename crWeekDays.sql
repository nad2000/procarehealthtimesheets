DROP TABLE dbo.WeekDays 
GO
CREATE TABLE dbo.WeekDays (
  [WeekDay] TINYINT NOT NULL PRIMARY KEY,
  CurrentWeekDayDate AS
    CAST ( DATEADD( DAY, [WeekDay]-DATEPART( WEEKDAY, GETDATE()), GETDATE()) AS DATE ),
  WeekDayName AS
    DATENAME( WEEKDAY, DATEADD( DAY, [WeekDay]-DATEPART( WEEKDAY, GETDATE()), GETDATE()))
)
INSERT INTO dbo.WeekDays VALUES (1),(2),(3),(4),(5),(6),(7)
SELECT * FROM dbo.WeekDays

