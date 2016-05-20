USE TimeSheetDB

-- CREATE PROC dbo.ApproverTimeSheetEntry_Update AS
GO

-- NB!!!
SET ANSI_NULLS OFF
GO
ALTER PROC dbo.ApproverTimeSheetEntry_Update
  @Id INT,
  @Date DATE,
  @StartedAt TIME,
  @EndedAt TIME,
  @Break_Id INT,
  @IsApproved BIT,
  @Comment NVARCHAR(max),
  @VerifiedBy_Id INT,
  @ReportedBy_UserName NVARCHAR(256)
AS

-- Delete or ignore if "started at" or "ended at" is NULL:
IF @EndedAt IS NULL OR @Break_Id IS NULL
BEGIN
  DELETE FROM dbo.TimeSheetEntries
  WHERE Id = @Id
  RETURN
END

DECLARE @ReportedBy_Id INT = dbo.UserIdByName(@ReportedBy_UserName)
IF @Id IS NULL
BEGIN
  -- User can submit only following values:
  INSERT INTO dbo.TimeSheetEntries
	( [Date], StartedAt, EndedAt, Break_Id, ReportedBy_Id )
  SELECT
    @Date, @StartedAt, @EndedAt, @Break_Id, @ReportedBy_Id
  WHERE
	@Date IS NOT NULL
  IF @@ROWCOUNT > 0
    SET @Id = SCOPE_IDENTITY()
END
IF @Id IS NULL RETURN


UPDATE dbo.[TimeSheetEntries]
SET
  IsApproved = @IsApproved,
  Comment = @Comment,
  VerifiedBy_Id = @VerifiedBy_Id,
  StartedAt = @StartedAt,
  EndedAt = @EndedAt,
  Break_Id  = @Break_Id
WHERE [Id] = @Id AND NOT (
	-- NB!!! Don't forget SET ANSI_NULLS OFF
  ( IsApproved = @IsApproved )
  AND ( Comment = @Comment )
  AND ( VerifiedBy_Id = @VerifiedBy_Id )
  AND ( StartedAt = @StartedAt )
  AND ( EndedAt = @EndedAt )
  AND ( Break_Id  = @Break_Id ) )

GO
SET ANSI_NULLS ON
GO

