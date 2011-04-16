-- Generate Test data for the current week:
USE TimeSheetDB
GO
INSERT INTO dbo.TimeSheetEntries
( [Date], ReportedBy_Id, StartedAt, EndedAt, Break_Id)
SELECT 
	wd.CurrentWeekDayDate,
	u.Id,
	DATEADD( MINUTE, ABS(CHECKSUM(NEWID())) % 180, cast( '7:00' as Time)), 
	DATEADD( MINUTE, ABS(CHECKSUM(NEWID())) % 600, cast( '13:00' as Time)),
	(SELECT TOP 1 Id FROM dbo.BreakTypes ORDER BY NEWID())
FROM dbo.WeekDays wd
CROSS JOIN Users u
LEFT JOIN dbo.TimeSheetEntries tse ON tse.ReportedBy_Id = u.Id 
 AND tse.[Date] = wd.CurrentWeekDayDate
WHERE tse.Id IS NULL