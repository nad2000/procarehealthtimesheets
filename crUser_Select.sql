USE [TimeSheetDB]
GO
/*

ALTER TABLE dbo.Users ADD
LoweredUserName AS LOWER(UserName)
-- NVARCHAR(256) 

CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_LoweredUserName]
ON [dbo].[Users] 
( [LoweredUserName] ASC ) 
GO

*/
-- EXEC dbo.User_Select @Id = 1002
-- CREATE PROC dbo.User_Select AS
ALTER PROC dbo.User_Select
( @Id INT = NULL)
AS
SELECT
	u.Id,
	u.Email, 
	u.FirstName,
	u.Surname,
	u.FullName, 
	u.CompanyWorkingFor_Id,
	c.Name AS CompanyName,
	u.UserName
FROM dbo.Users u JOIN dbo.aspnet_Users AS am
  ON am.LoweredUserName = u.LoweredUserName
  JOIN dbo.aspnet_Applications AS a
  ON a.ApplicationId = am.ApplicationId
  LEFT JOIN dbo.Companies AS c ON c.Id = u.CompanyWorkingFor_Id
WHERE ( a.ApplicationName IS NULL OR a.ApplicationName = '/' )
	AND u.Id = @Id
ORDER BY u.LoweredUserName 