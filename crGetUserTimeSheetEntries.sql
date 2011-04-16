USE [TimeSheetDB]

/*
-- Test:
DECLARE @UserName NVARCHAR(256)
DECLARE @Week INT, @Date DATE
SELECT TOP 1
	@UserName = u.UserName,
	@Week = DATEPART( week, [Date]),
	@Date = [Date]
FROM dbo.TimeSheetEntries tse
JOIN dbo.Users u ON u.Id = tse.ReportedBy_Id
ORDER BY NEWID()
SELECT @UserName, @Week, @Date
EXEC dbo.GetUserTimeSheetEntries @UserName, @Date
-- EXEC dbo.GetUserTimeSheetEntries 'nad2000@gmail.com'
-- EXEC dbo.GetUserTimeSheetEntries 'GrahamF'
*/
/* Modify table TimeSheetEntries */
ALTER TABLE dbo.TimeSheetEntries
	ALTER COLUMN [Date] DATE NOT NULL
GO
DROP INDEX [IX_BreakTypesTimeSheetEntry_Date]
ON [dbo].[TimeSheetEntries]
GO
-- User can have only one enty per day:
CREATE UNIQUE NONCLUSTERED INDEX [IX_BreakTypesTimeSheetEntry_Date]
ON [dbo].[TimeSheetEntries] (  ReportedBy_Id, [Date] ASC )
GO

ALTER PROCEDURE dbo.GetUserTimeSheetEntries (
	@UserName NVARCHAR(256), --  @UserId SQL_VARIANT, -- INT (Id) or VARCHAR (UserName)
	@WeekEndingDate DATE = NULL )
AS 
DECLARE @FirstDayOfTheWeek DATE

IF @WeekEndingDate IS NULL
  -- SET @WeekEndingDate = dbo.to_nz_date( GETDATE() )
  SET @WeekEndingDate = GETDATE()
SET @WeekEndingDate
  = DATEADD( DAY, 7-DATEPART( WEEKDAY, @WeekEndingDate), @WeekEndingDate )

-- Day of the year: (@WeekNumber-1)*7+1
SELECT 
  tse.Id,
  CAST ( COALESCE( [Date], WeekDayDate) AS DATE) AS [Date],
  StartedAt,
  EndedAt,
  CAST ( COALESCE( IsApproved, 0) AS BIT) AS IsApproved ,
  Comment,
  TotalTime,
  Break_Id,
  bt.Name AS BreakName,
  COALESCE( ReportedBy_Id, u.Id) AS ReportedBy_Id,
  VerifiedBy_Id
FROM 
( SELECT
	[WeekDay],
	CAST ( DATEADD( DAY, [WeekDay]-7 ,@WeekEndingDate ) AS DATE) AS WeekDayDate
	-- CAST ( ( @FirstDayOfTheWeek+[WeekDay]-1 ) AS date) AS CurrentWeekDayDate
FROM (
SELECT 1 AS [WeekDay]
UNION ALL SELECT 2
UNION ALL SELECT 3
UNION ALL SELECT 4
UNION ALL SELECT 5
UNION ALL SELECT 6
UNION ALL SELECT 7) AS WeekDays ) wd
JOIN dbo.Users AS u ON u.UserName = @UserName
LEFT JOIN dbo.TimeSheetEntries tse
  ON tse.[Date] = wd.WeekDayDate AND tse.ReportedBy_Id = u.Id
LEFT JOIN dbo.BreakTypes AS bt ON bt.Id = tse.Break_Id
GO