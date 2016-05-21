-- NB! change the DB name!
USE TimeSheetDB
GO

DROP FUNCTION dbo.WeekEndingDates
GO
-- SELECT * FROM dbo.WeekEndingDates(DEFAULT)
CREATE FUNCTION dbo.WeekEndingDates( @Count TINYINT = 10 )
RETURNS @WeekEndings TABLE (WeekEndingDate DATE)
AS
BEGIN
  DECLARE @CurrentWeekEndingDate DATE
   -- = dbo.to_nz_date( DATEADD( DAY, 7-DATEPART( WEEKDAY, GETDATE()), GETDATE() ) )
   = DATEADD( DAY, 7-DATEPART( WEEKDAY, GETDATE()), GETDATE() )
   DECLARE @WeekNum TINYINT = 0
  WHILE @WeekNum < @Count+1
  BEGIN
	INSERT INTO @WeekEndings
	VALUES ( DATEADD( WEEK, -@WeekNum, @CurrentWeekEndingDate ))
	SET @WeekNum = @WeekNum + 1
  END
	RETURN
END
GO

DROP PROC dbo.GetWeekEndingDates
GO
-- CREATE PROC dbo.GetWeekEndingDates
CREATE PROC dbo.GetWeekEndingDates( @Count TINYINT = 10 )
AS
SELECT WeekEndingDate FROM dbo.WeekEndingDates(@Count)
GO

DROP FUNCTION dbo.ThisWeekEndingDate
GO
CREATE FUNCTION dbo.ThisWeekEndingDate()
GO
-- Test: SELECT dbo.ThisWeekEndingDate()
-- Actually - the last week ending date :)
CREATE FUNCTION dbo.ThisWeekEndingDate()
RETURNS DATE
AS
BEGIN
-- RETURN ( dbo.to_nz_date(
--   DATEADD(DAY, -DATEPART( WEEKDAY, dbo.to_nz_datetime(GETDATE())), dbo.to_nz_datetime(GETDATE()) )) )
  RETURN ( DATEADD(DAY, -DATEPART( WEEKDAY, GETDATE()), GETDATE() ))
END
GO

/*
SELECT DATEPART( WEEKDAY, dbo.to_nz_date(GETDATE()))
SELECT DATEPART( WEEKDAY, GETDATE()), GETDATE(), cast(  dbo.to_nz_datetime(GETDATE()) as date)
*/
GO

DROP FUNCTION dbo.LastWeekEndingDate
GO
-- Test: SELECT dbo.LastWeekEndingDate()
-- Actually - the last week before the last ending date :)
CREATE FUNCTION dbo.LastWeekEndingDate()
RETURNS DATE
AS
BEGIN
  RETURN ( DATEADD(DAY, -7, dbo.ThisWeekEndingDate() ) )
   -- RETURN ( dbo.to_nz_date( DATEADD(DAY, -DATEPART( WEEKDAY, GETDATE())-7 , GETDATE() )) )
END
GO