SET QUOTED_IDENTIFIER OFF;
GO
USE [TimeSheetDB];
GO

INSERT INTO dbo.BreakTypes
(Code, TimeValue, Name)
VALUES 
('HH', 30, '1/2 hr'),
('1H', 60, '1 hr'),
('2H', 120, '2 hrs')
GO

