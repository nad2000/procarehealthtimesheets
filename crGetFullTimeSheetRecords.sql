USE [TimeSheetDB]
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- CREATE PROCEDURE [dbo].[GetFullTimeSheetRecords] AS 
/*
DECLARE @DateFrom DATE = GETDATE()-30
DECLARE @DateTo DATE = GETDATE()
EXEC [dbo].[GetFullTimeSheetRecords] NULL, @DateFrom, @DateTo, 1
EXEC [dbo].[GetFullTimeSheetRecords] NULL, NULL, NULL, 1
EXEC [dbo].[GetFullTimeSheetRecords] 1804, NULL, NULL, NULL, NULL, NULL
EXEC [dbo].[GetFullTimeSheetRecords] @IncludeUnapproved=1

*/
ALTER PROCEDURE [dbo].[GetFullTimeSheetRecords] (
	@ReportRequestedBy_Id INT = NULL, -- User requesting report
	@DateFrom DATE = NULL,
	@DateTo DATE = NULL,
	@IncludeUnapproved BIT = 1,
	@CompanyId INT = NULL,
	@UserName NVARCHAR(256) = 'ALL')
AS
/*INSERT INTO dbo.SPLog (LogRec) VALUES ( 
dbo.DumpParam(@ReportRequestedBy_Id)+', '+
dbo.DumpParam(@DateFrom)+', '+ 
dbo.DumpParam(@DateTo)+', '+
dbo.DumpParam(@CompanyId)+', '+
dbo.DumpParam(@UserName)) */
-- SELECT * FROM dbo.SPLog ORDER BY LogTimeStamp DESC
-- DELETE dbo.SPLog

IF @UserName='ALL' SET @UserName = NULL
IF @IncludeUnapproved IS NULL SET @IncludeUnapproved = 1

DECLARE @UserId INT = (SELECT TOP 1 Id FROM Users WHERE UserName=@UserName)
-- Default date interval: the first day of the last week till the end of the current week (2 weeks)
IF @DateFrom IS NULL
	SET @DateFrom = DATEADD( day, 1-DATEPART( weekday, GETDATE())-7, GETDATE())
IF @DateTo IS NULL
	SET @DateTo = DATEADD( day, 13, @DateFrom)
SELECT 
	tse.Id,
	c.Code AS CompanyCode,
	u.Id AS UserId,
	u.Code,
	u.FullName,
	tse.[Date],
	tse.StartedAt,
	tse.EndedAt,
	Break_Id,
	bt.Name AS BreakTypeName,
	tse.TotalTime,
	tse.IsApproved,
	tse.Comment
FROM dbo.TimeSheetEntries AS tse 
	JOIN dbo.Users AS u ON u.Id = tse.ReportedBy_Id
	LEFT JOIN dbo.BreakTypes AS bt ON tse.Break_Id = bt.Id
	LEFT JOIN dbo.Companies AS c ON c.Id = u.CompanyWorkingFor_Id
WHERE 
	( @UserId IS NULL OR u.Id = @UserId )
	AND ( @DateFrom IS NULL OR @DateFrom <= tse.[Date] )
	AND ( @DateTo IS NULL OR @DateTo >= tse.[Date] )
	AND ( @IncludeUnapproved = 1 OR tse.IsApproved = 1)
	AND ( @CompanyId IS NULL OR @CompanyId = u.CompanyWorkingFor_Id)
ORDER BY c.Code, u.Id, tse.[Date]
GO
