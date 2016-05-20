USE TimeSheetDB
GO
-- EXEC dbo.changeAppUserPwd 'GrahamF'
-- CREATE PROC dbo.changeAppUserPwd AS
ALTER PROCEDURE dbo.changeAppUserPwd
  @UserName nvarchar(256),
  @ClearTextPassword nvarchar(128) = '1234567',
  @UserId uniqueidentifier = NULL OUTPUT
AS
BEGIN

DECLARE
	@CurrentTimeUtc datetime = GETDATE(),
	@UniqueEmail int = 1,
	@IsApproved bit = 1,
	@ApplicationName nvarchar(256) = '/',
	@salt uniqueidentifier=NEWID(),
	@encoded_hashed_password nvarchar(128),
	@encoded_salt nvarchar(128),
	@RC int

SET @encoded_salt = dbo.base64_encode(@salt)
SET @encoded_hashed_password = dbo.base64_encode(HASHBYTES('SHA1', Cast(@salt as varbinary(MAX)) + CAST(@ClearTextPassword AS varbinary(MAX)) ))

EXECUTE @RC = dbo.aspnet_Membership_SetPassword
		@ApplicationName=@ApplicationName,
		@UserName=@UserName,
		@NewPassword=@encoded_hashed_password,
		@PasswordSalt=@encoded_salt,
		@CurrentTimeUtc=@CurrentTimeUtc,
		@PasswordFormat=1
END