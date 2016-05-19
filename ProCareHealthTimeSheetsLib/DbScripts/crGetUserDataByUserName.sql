-- CREATE PROC dbo.GetUserDataByUserName AS
-- Test: EXEC dbo.GetUserDataByUserName 'nad2000@gmail.com'
ALTER PROC dbo.GetUserDataByUserName(
	 @UserName NVARCHAR(256))
AS
SELECT
  u.Id,
  u.Code,
  u.UserName,
  u.FirstName,
  u.Surname,
  u.FullName,
  u.Email,
  c.Code AS CompanyCode,
  c.Name AS CompanyName
FROM dbo.Users AS u LEFT JOIN dbo.Companies AS c
	ON c.Id = u.CompanyWorkingFor_Id
WHERE u.UserName = @UserName
GO
/*
-- Update records:
INSERT INTO dbo.Users 
 ( UserName, Name, Email) 
SELECT 
	-- u.UserId,
	u.UserName,
	m.Email,
	m.Email
FROM dbo.aspnet_Applications AS a
JOIN dbo.aspnet_Users AS u ON u.ApplicationId = a.ApplicationId
JOIN dbo.aspnet_Membership AS m ON m.UserId = u.UserId
LEFT JOIN dbo.Users AS au ON au.UserName = u.UserName
WHERE a.ApplicationName = '/' AND au.Id IS NULL
*/