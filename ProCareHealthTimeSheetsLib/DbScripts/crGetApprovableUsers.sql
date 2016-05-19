USE TimeSheetDB
GO
-- CREATE PROC dbo.GetApprovableUsers AS 
/*
  Gets users whose timesheets the user (@UserName) has rights to approve.
*/
-- EXEC dbo.GetApprovableUsers 'nad2000@gmail.com'
-- EXEC dbo.GetApprovableUsers 'admin42'
-- EXEC dbo.GetApprovableUsers 'ChristinaM'
-- EXEC dbo.GetApprovableUsers 'GrahamF'
ALTER PROC dbo.GetApprovableUsers ( @UserName NVARCHAR(256))
AS
SELECT u.Id, u.Email, u.FullName, u.UserName
	-- ,u.CompanyWorkingFor_Id, c.Code AS CompanyCode, c.Name AS CompanyName
FROM dbo.Users AS u
	JOIN dbo.Companies AS c ON c.Id = u.CompanyWorkingFor_Id
	JOIN dbo.UserCompany AS uc ON uc.Companies_Id = c.Id
WHERE uc.UsersVerifyingTimeSheets_Id = dbo.UserIdByName( @UserName )
ORDER BY u.FirstName, u.Surname
GO
