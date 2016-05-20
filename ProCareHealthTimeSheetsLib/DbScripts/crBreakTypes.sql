USE [TimeSheetDB]
GO

/****** Object:  Table [dbo].[BreakTypes]    Script Date: 08/15/2010 21:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER TABLE [dbo].[TimeSheetEntries]
DROP CONSTRAINT [FK_BreakTypesTimeSheetEntry]
GO

DROP TABLE [dbo].[BreakTypes]
GO

CREATE TABLE [dbo].[BreakTypes](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) UNIQUE  NOT NULL,
	[AlternateCode] [varchar](10) NULL,
	[Name] [nvarchar](100) UNIQUE NOT NULL,
	[TimeValue] [int] UNIQUE NOT NULL,
 CONSTRAINT [PK_BreakTypes] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO dbo.BreakTypes
(Code, TimeValue, Name)
VALUES
('5H', 300, '5 hrs'),
('HH', 30, '1/2 hr'),
('1H', 60, '1 hr'),
('1.5H', 90, '1 1/2 hr'),
('2H', 120, '2 hrs')
GO

ALTER TABLE [dbo].[TimeSheetEntries]
WITH CHECK ADD  CONSTRAINT [FK_BreakTypesTimeSheetEntry] FOREIGN KEY([Break_Id])
REFERENCES [dbo].[BreakTypes] ([Id])
GO

INSERT INTO dbo.BreakTypes
(Code, TimeValue, Name)
SELECT
CASE h
WHEN 0 THEN ''
ELSE h_str+'H'
END +m_str+'M',
breaks.interval,
CASE breaks.h
WHEN 0 THEN ''
WHEN 1 THEN '1 hr '
ELSE h_str+' hrs '
END
+ CASE m WHEN 0 THEN '' ELSE m_str+' min' END
FROM
( SELECT
h,
m,
h*60+m AS interval,
CAST ( h as varchar(1000)) h_str,
CAST ( m as varchar(1000)) m_str
FROM ( VALUES (0),(15),(30),(45) ) AS MinVals(m),
( VALUES (0),(1),(2),(3),(4) ) AS HrVals(h)) AS breaks
LEFT JOIN dbo.BreakTypes AS bt ON bt.TimeValue = breaks.interval
WHERE bt.Id IS NULL AND m+h <> 0
ORDER BY 2
