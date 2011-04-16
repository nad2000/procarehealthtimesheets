USE [TimeSheetDB]
GO 
-- CREATE PROC dbo.GetTimeSheetSummary AS
ALTER PROCEDURE dbo.GetTimeSheetSummary (
	@ReportRequestedBy_Id INT = NULL, -- User requesting report
	@DateFrom DATE = NULL,
	@DateTo DATE = NULL,
	@UserName NVARCHAR(256) = NULL )
AS
DECLARE @UserId INT = (SELECT TOP 1 Id FROM Users WHERE UserName=@UserName)
-- Monday of the current week
IF @DateFrom IS NULL
	SET @DateFrom = DATEADD( day, 1-DATEPART( weekday, GETDATE()), GETDATE())
IF @DateTo IS NULL
	SET @DateTo = DATEADD( day, 6, @DateFrom)

SELECT 
	u.Id,
	u.Name,
    @DateFrom AS StartDate,
    @DateTo AS EndDate,    	
	s.ApprovedTotalTime,
	s.NotApprovedTotalTime,
	s.ApprovedTotalBreakTime,
	s.NotApprovedTotalBreakTime,
    ( 
        SELECT  tse.Comment + '
'
        FROM    TimeSheetEntries tse 
        WHERE   tse.Comment IS NOT NULL AND tse.ReportedBy_Id = u.Id
          AND ( @DateTo IS NULL OR tse.[Date] < DATEADD( day, 1, @DateTo ) )
	      AND ( @DateFrom IS NULL OR @DateFrom >= tse.[Date])
        FOR XML PATH('')
    ) AS Comments
FROM (
	SELECT tse.ReportedBy_Id,
	SUM( CASE WHEN tse.IsApproved=1 THEN tse.TotalTime ELSE 0 END) AS ApprovedTotalTime,
	SUM( CASE WHEN tse.IsApproved IS NULL OR tse.IsApproved=0 THEN tse.TotalTime ELSE 0 END) AS NotApprovedTotalTime,
	SUM( CASE WHEN tse.IsApproved=1 THEN tse.BreakLength ELSE 0 END) AS ApprovedTotalBreakTime,
	SUM( CASE WHEN tse.IsApproved IS NULL OR tse.IsApproved=0 THEN tse.BreakLength ELSE 0 END) AS NotApprovedTotalBreakTime
	FROM dbo.TimeSheetEntries AS tse
	WHERE
	  ( @DateTo IS NULL OR tse.[Date] < DATEADD( day, 1, @DateTo ) )
	  AND ( @DateFrom IS NULL OR @DateFrom >= tse.[Date])
	  AND ( @UserName IS NULL OR tse.ReportedBy_Id = @UserId)
	GROUP BY tse.ReportedBy_Id ) AS s -- Summary
	JOIN Users AS u ON u.Id = s.ReportedBy_Id
 