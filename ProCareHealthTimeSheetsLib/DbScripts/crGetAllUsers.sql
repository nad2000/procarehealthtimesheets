USE [TimeSheetDB]
GO
/*

CREATE TABLE dbo.Users (
	Id

ALTER TABLE dbo.Users ADD
LoweredUserName AS LOWER(UserName)
-- NVARCHAR(256)

CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_LoweredUserName]
ON [dbo].[Users]
( [LoweredUserName] ASC )
GO

*/

-- CREATE PROC dbo.GetAllUsers AS
ALTER PROC dbo.GetAllUsers AS
SELECT
	u.Id,
	u.Email,
	u.FullName,
	u.CompanyWorkingFor_Id,
	c.Name AS CompanyName,
	u.UserName
FROM dbo.Users u LEFT JOIN dbo.aspnet_Users AS am
  ON am.LoweredUserName = u.LoweredUserName
  LEFT JOIN dbo.aspnet_Applications AS a
  ON a.ApplicationId = am.ApplicationId
  LEFT JOIN dbo.Companies AS c ON c.Id = u.CompanyWorkingFor_Id
WHERE a.ApplicationName IS NULL OR a.ApplicationName = '/'
ORDER BY u.UserName