USE TimeSheetDB
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[createAppUser]') AND type in (N'P', N'PC'))
  DROP PROC dbo.createAppUser
GO

CREATE PROCEDURE dbo.createAppUser
  @UserName nvarchar(256),
  @ClearTextPassword nvarchar(128) = '1234567',
  @Email nvarchar(256) = NULL,
  @PasswordQuestion nvarchar(256) = '?',
  @PasswordAnswer nvarchar(128) = '!',
  @UserId uniqueidentifier = NULL OUTPUT
AS
BEGIN

IF @Email IS NULL SET @Email = @UserName+'@noemail.com'

DECLARE
	@CurrentTimeUtc datetime = GETDATE(),
	@CreateDate datetime = GETDATE(),
	@UniqueEmail int = 1,
	@IsApproved bit = 1,
	@ApplicationName nvarchar(256) = '/',
	@salt uniqueidentifier=NEWID(),
	@encoded_hashed_password nvarchar(128),
	@encoded_salt nvarchar(128),
	@RC int

SET @encoded_salt = dbo.base64_encode(@salt)
SET @encoded_hashed_password = dbo.base64_encode(HASHBYTES('SHA1', Cast(@salt as varbinary(MAX)) + CAST(@ClearTextPassword AS varbinary(MAX)) ))
 
EXECUTE @RC = aspnet_Membership_CreateUser
		@ApplicationName=@ApplicationName,
		@UserName=@UserName,
		@Password=@encoded_hashed_password,
		@PasswordSalt=@encoded_salt,
		@Email=@Email,
		@PasswordQuestion='?',
		@PasswordAnswer='!',
		@PasswordFormat=1,
		@IsApproved=1,
		@CurrentTimeUtc=@CurrentTimeUtc,
		@CreateDate=NULL,
		@UniqueEmail=1,
		@UserId=@UserId OUTPUT
END