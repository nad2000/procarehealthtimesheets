DROP TABLE [dbo].[Users];
CREATE TABLE [dbo].[Users]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Email] NVARCHAR(50) NULL, 
    [FirstName] NVARCHAR(100) NOT NULL, 
    [Surname] NVARCHAR(100) NOT NULL,
    [FullName] AS [FirstName] + ' ' + [Surname], 
    [UserName] NVARCHAR(256) NOT NULL, 
    [CompanyWorkingFor_Id] INT NOT NULL, 
)
