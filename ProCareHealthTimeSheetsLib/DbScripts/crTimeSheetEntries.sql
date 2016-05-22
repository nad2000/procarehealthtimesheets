USE [TimeSheetDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TimeSheetEntries] (
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Date] [date] NOT NULL,
	[StartedAt] [time](7) NOT NULL,
	[EndedAt] [time](7) NOT NULL,
	ModifiedAt DATETIME NULL,
	[Comment] [nvarchar](max) NULL,
	[Break_Id] [smallint] NULL,
	[ReportedBy_Id] [int] NOT NULL,
	[VerifiedBy_Id] [int] NULL,
	[BreakLength] [smallint] NULL,
	[TotalTime]  AS (
		CONVERT([int],datediff(minute,[StartedAt],[EndedAt])-coalesce([BreakLength],(0)),(0))
	),
	[IsApproved] [bit] NULL
)
ON [PRIMARY]

GO

ALTER TABLE [dbo].[TimeSheetEntries]  WITH CHECK ADD  
CONSTRAINT [FK_TimeSheetEntries_BreakTypes] FOREIGN KEY([Break_Id])
REFERENCES [dbo].[BreakTypes] ([Id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[TimeSheetEntries]
CHECK CONSTRAINT [FK_TimeSheetEntries_BreakTypes]
GO

ALTER TABLE [dbo].[TimeSheetEntries]
WITH CHECK ADD  CONSTRAINT [FK_UserTimeSheetEntry]
FOREIGN KEY([ReportedBy_Id])
REFERENCES [dbo].[Users] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TimeSheetEntries]
CHECK CONSTRAINT [FK_UserTimeSheetEntry]
GO

ALTER TABLE [dbo].[TimeSheetEntries]
WITH CHECK ADD  CONSTRAINT [FK_TimeSheetEntries_Users]
FOREIGN KEY([VerifiedBy_Id])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[TimeSheetEntries]
CHECK CONSTRAINT [FK_TimeSheetEntries_Users]
GO
