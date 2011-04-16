USE [TimeSheetDB]
GO
/****** Object:  Trigger [dbo].[TimeSheetEntries_UpdateTotalTime_TR]    Script Date: 09/07/2010 11:07:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Radomirs Cirskis <rad@nowITworks.eu>
-- Create date: 
-- Description:	
-- =============================================
ALTER TRIGGER [dbo].[TimeSheetEntries_UpdateTotalTime_TR] 
   ON  [dbo].[TimeSheetEntries] 
   FOR INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE tse
	SET
		tse.BreakLength = bt.TimeValue, 
		tse.ModifiedAt = GETDATE()
	FROM dbo.TimeSheetEntries tse JOIN [inserted] ins ON ins.Id = tse.Id
	  LEFT JOIN dbo.BreakTypes bt ON bt.id = ins.Break_Id

END
