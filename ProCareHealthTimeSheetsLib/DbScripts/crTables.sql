USE [TimeSheetDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
DROP TABLE [dbo].[TimeSheetEntries]
GO
DROP TABLE dbo.UserCompany
GO
DROP TABLE dbo.Users
GO
DROP TABLE dbo.Companies
GO
*/

CREATE TABLE dbo.Companies
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[Code] VARCHAR(10) NOT NULL,
	[Name] NVARCHAR(256) NOT NULL
)
GO

CREATE TABLE [dbo].[Users]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
    [Email] NVARCHAR(50) NULL,
    [FirstName] NVARCHAR(100) NOT NULL,
    [LastName] NVARCHAR(100) NOT NULL,
    [FullName] AS [FirstName] + ' ' + [LastName],
	[Name] AS [FirstName] + ' ' + [LastName],
    [UserName] NVARCHAR(256) NOT NULL,
	[Code] VARCHAR(10) NULL,
	[LoweredUserName] AS LOWER(UserName),
    [CompanyWorkingFor_Id] INT NULL,
	FOREIGN KEY (CompanyWorkingFor_Id) REFERENCES dbo.Companies ([Id]) ON DELETE CASCADE ON UPDATE CASCADE
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_LoweredUserName]
ON [dbo].[Users]  ( [LoweredUserName] ASC )
GO

CREATE TABLE dbo.UserCompany
(
	[UsersVerifyingTimeSheets_Id] INT NOT NULL ,
	[CompanyId] INT NOT NULL,
	UNIQUE (UsersVerifyingTimeSheets_Id, CompanyId),
	FOREIGN KEY (UsersVerifyingTimeSheets_Id) REFERENCES dbo.Users ([Id]) ON DELETE CASCADE,
	FOREIGN KEY (CompanyId) REFERENCES dbo.Companies ([Id]))
GO
