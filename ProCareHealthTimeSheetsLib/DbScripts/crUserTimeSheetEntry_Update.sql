USE [TimeSheetDB]
GO
-- NB!!!
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE dbo.UserTimeSheetEntry_Update
GO
CREATE PROCEDURE [dbo].[UserTimeSheetEntry_Update]
  @Id INT,
  @Date DATE,
  @StartedAt TIME,
  @EndedAt TIME,
  @Break_Id INT,
  @ReportedBy_Id INT
AS
IF @Id IS NULL SELECT @Id=Id FROM dbo.TimeSheetEntries
			   WHERE [Date] = @Date AND ReportedBy_Id = @ReportedBy_Id

-- Delete or ignore if "started at" or "ended at" is NULL:
IF @EndedAt IS NULL OR @Break_Id IS NULL
BEGIN
  DELETE FROM dbo.TimeSheetEntries
  WHERE Id = @Id
  RETURN
END

IF @Id IS NULL
BEGIN
  -- User can submit only following values:
  INSERT INTO dbo.TimeSheetEntries
  ( [Date], StartedAt, EndedAt, Break_Id, ReportedBy_Id)
  SELECT
    @Date, @StartedAt, @EndedAt, @Break_Id, @ReportedBy_Id
  WHERE
	@Date IS NOT NULL
	OR @StartedAt IS NOT NULL
	OR @EndedAt IS NOT NULL
	OR @Break_Id IS NOT NULL
	OR @ReportedBy_Id IS NOT NULL
  IF @@ROWCOUNT > 0
    SET @Id = SCOPE_IDENTITY()
END
ELSE
BEGIN
	UPDATE dbo.[TimeSheetEntries]
	SET [StartedAt] = @StartedAt
	  ,[EndedAt] = @EndedAt
	  ,[Break_Id] = @Break_Id
	WHERE [Id] = @Id
		-- Can cange values only if the ently has not been verified yet
		AND ( IsApproved IS NULL OR IsApproved = 0)
		AND NOT ([StartedAt] = @StartedAt AND [EndedAt] = @EndedAt AND [Break_Id] = @Break_Id)
END

/*SELECT
	Id,
	[Date],
	StartedAt,
	EndedAt,
	IsApproved,
	Comment,
	Break_Id,
	ReportedBy_Id,
	VerifiedBy_Id,
	BreakLength,
	TotalTime
FROM dbo.TimeSheetEntries
WHERE [Id] = @Id
*/

GO
SET ANSI_NULLS ON
GO


