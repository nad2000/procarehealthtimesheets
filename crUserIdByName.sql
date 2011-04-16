USE TimeSheetDB
GO
/*
CREATE FUNCTION dbo.UserIdByName( @UserName NVARCHAR(256) )
RETURNS INT
AS BEGIN RETURN NULL END 
*/
GO 

-- Test: SELECT dbo.UserIdByName('nad2000@gmail.com')
ALTER FUNCTION dbo.UserIdByName( @UserName NVARCHAR(256) )
RETURNS INT
AS
BEGIN
RETURN (SELECT TOP 1 u.Id FROM dbo.Users AS u WHERE u.UserName=@UserName)
END 