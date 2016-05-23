SET QUOTED_IDENTIFIER ON
GO

USE [TimeSheetDB]
GO

DELETE FROM Users
GO

SELECT IDENTITY(INT) AS [Num], LOWER(UserName) AS UserName, Email, FirstName, LastName 
INTO #Users
FROM (VALUES
('user0', 'user0@nowhere.com','Test', 'User0'),
('user1', 'user1@nowhere.com','Test', 'User1'),
('user2', 'user2@nowhere.com','Test', 'User2'),
('tristique', 'tristique@luctusutpellentesque.com','Hilda', 'Herman'),
('augue', 'augue.malesuada.malesuada@vehicula.org','Cairo', 'Hardy'),
('Duis.sit', 'Duis.sit@nec.edu','Martha', 'Hewitt'),
('posuere.enim.nisl', 'posuere.enim.nisl@nonlaciniaat.ca','Jaquelyn', 'Blair'),
('dictum.mi', 'dictum.mi@ultricesmaurisipsum.com','Sade', 'Blanchard'),
('orci.luctus', 'orci.luctus@auctorodio.ca','Keegan', 'Stein'),
('quam.Curabitur', 'quam.Curabitur@ipsum.ca','Hayes', 'Murphy'),
('erat.semper.rutrum', 'erat.semper.rutrum@ultricies.edu','Scarlett', 'Horne'),
('rutrum.eu.ultrices', 'rutrum.eu.ultrices@imperdietnec.edu','Aubrey', 'Larsen'),
('mus', 'mus@eratEtiamvestibulum.edu','Oren', 'Sweeney'),
('taciti.sociosqu', 'taciti.sociosqu@variusorci.edu','Louis', 'Snider'),
('libero', 'libero@sed.ca','Jonas', 'Martinez'),
('eget', 'eget@mollislectus.ca','Aiko', 'Spears'),
('In', 'In@convallisdolor.org','Chadwick', 'Battle'),
('consectetuer.ipsum.nunc', 'consectetuer.ipsum.nunc@cursusaenim.edu','Gil', 'Mcbride'),
('ut.pharetra', 'ut.pharetra@iaculisnec.com','MacKensie', 'Wilkinson'),
('non', 'non@Infaucibus.org','Abbot', 'Chambers'),
('purus.sapien', 'purus.sapien@non.edu','Honorato', 'Jenkins'),
('consectetuer.cursus.et', 'consectetuer.cursus.et@inmagna.com','Jameson', 'Marquez'),
('pede.Cras', 'pede.Cras@purus.ca','Larissa', 'Mann'),
('Nulla', 'Nulla@anteipsum.com','Ashton', 'King'),
('magna.a.neque', 'magna.a.neque@augueSed.edu','Mufutau', 'Palmer'),
('Quisque', 'Quisque@ac.org','Neil', 'Gibson'),
('vitae', 'vitae@loremutaliquam.ca','Alvin', 'Small'),
('bibendum.ullamcorper.Duis', 'bibendum.ullamcorper.Duis@egetvenenatis.ca','Walker', 'Aguilar'),
('Quisque', 'Quisque@nuncac.edu','Carter', 'Clayton'),
('malesuada', 'malesuada@IntegerurnaVivamus.ca','Anastasia', 'Fleming'),
('Fusce', 'Fusce@sitametconsectetuer.edu','Yoshi', 'Caldwell'),
('scelerisque', 'scelerisque@Suspendissedui.edu','Inez', 'Hunter'),
('egestas', 'egestas@Sedpharetrafelis.ca','Noelle', 'Joyner'),
('sem', 'sem@Crasconvallisconvallis.com','Jenna', 'Patrick'),
('ac.mattis', 'ac.mattis@mus.ca','Abraham', 'Golden'),
('ac.nulla', 'ac.nulla@tinciduntnuncac.ca','Lois', 'Watson'),
('aliquam.arcu', 'aliquam.arcu@nonsollicitudin.org','Cade', 'Powers'),
('eleifend', 'eleifend@morbitristique.org','Faith', 'Sykes'),
('Integer.eu.lacus', 'Integer.eu.lacus@orciadipiscingnon.org','Thane', 'Wilder'),
('massa.Vestibulum', 'massa.Vestibulum@nunc.org','Callie', 'Baird'),
('eget.ipsum', 'eget.ipsum@eratnequenon.ca','Marah', 'Sparks'),
('eu.placerat', 'eu.placerat@Crasvulputate.edu','Anthony', 'Stout'),
('Praesent', 'Praesent@elit.ca','Morgan', 'Meyer'),
('Suspendisse', 'Suspendisse@Loremipsum.edu','Dora', 'Salinas'),
('Morbi', 'Morbi@Nulla.edu','Felicia', 'Mcintyre'),
('metus', 'metus@felis.org','Melanie', 'Mason'),
('Nulla', 'Nulla@montesnasceturridiculus.com','Stella', 'Campbell'),
('mattis', 'mattis@dolorelitpellentesque.com','Destiny', 'Henderson'),
('Cras.dictum', 'Cras.dictum@ultrices.edu','Emerald', 'Strong'),
('non', 'non@Donecnon.com','Lewis', 'Rowland'),
('diam', 'diam@nibhQuisque.com','Camille', 'Hines'),
('eu.tellus.eu', 'eu.tellus.eu@sapienimperdiet.org','Wanda', 'Lester'),
('primis', 'primis@Inatpede.org','Stuart', 'Callahan'),
('enim', 'enim@ipsumDonec.edu','Jason', 'Bell'),
('et.ultrices', 'et.ultrices@egestas.com','Yetta', 'Tyson'),
('odio', 'odio@sedconsequat.org','Thane', 'Ashley'),
('turpis', 'turpis@molestieorci.org','Hedwig', 'Brewer'),
('imperdiet', 'imperdiet@hendrerit.edu','Olivia', 'Sykes'),
('vitae', 'vitae@etnetuset.ca','Avram', 'Dudley'),
('dapibus', 'dapibus@risus.edu','Kieran', 'Bright'),
('tellus.eu.augue', 'tellus.eu.augue@urna.com','Minerva', 'Floyd'),
('turpis.egestas.Fusce', 'turpis.egestas.Fusce@eueleifend.com','Maisie', 'Reed'),
('urna.Nullam', 'urna.Nullam@condimentumDonec.org','Levi', 'Maxwell'),
('sociis.natoque', 'sociis.natoque@tortordictumeu.org','Zena', 'Calderon'),
('Nullam.enim.Sed', 'Nullam.enim.Sed@neque.ca','Gisela', 'Nguyen'),
('urna', 'urna@Nuncmauriselit.edu','Glenna', 'Griffin'),
('sit.amet', 'sit.amet@et.com','Quentin', 'Oneill'),
('ullamcorper', 'ullamcorper.viverra.Maecenas@urna.edu','Baker', 'Carter'),
('cursus', 'semper.cursus.Integer@auctor.org','Karly', 'Gilmore'),
('Aliquam.erat', 'Aliquam.erat@in.ca','Xena', 'Bowen'),
('magnis', 'magnis@luctussit.com','Lance', 'Herman'))
AS TestData (UserName, Email, FirstName, LastName)
GO

INSERT INTO Users (UserName, Email, FirstName, LastName, Code)
SELECT 
	CASE
		WHEN eu.UserName IS NULL THEN u.UserName
		ELSE CAST(u.[Num] AS VARCHAR)+u.UserName
	END AS UserName, u.Email, u.FirstName, u.LastName, 'U00'+CAST(u.[Num] AS VARCHAR)
FROM #Users u LEFT JOIN #Users AS eu ON eu.UserName = u.UserName AND u.Num > eu.Num
GO

DELETE FROM Users WHERE Email = 'nad2000@gmail.com'
GO
INSERT INTO Users ([Email] ,[FirstName],[LastName],[UserName],[Code],[CompanyWorkingFor_Id])
VALUES ('nad2000@gmail.com','Radomirs','Cirskis','nad2000','NAD2K',(SELECT MIN(Id) FROM Companies))
GO
EXECUTE dbo.createAppUser 'nad2000', '12345'
GO

-- Assign to the companies:
--
DECLARE @CompIdMin INT, @CompCount INT;
SELECT @CompIdMin=MIN(Id), @CompCount=(MAX(Id)-MIN(Id))+1
FROM Companies;

UPDATE Users
SET CompanyWorkingFor_Id = Id % @CompCount + @CompIdMin
WHERE ( Id % @CompCount + @CompIdMin ) IN (SELECT Id FROM Companies)
GO

-- Assinge the companies the users can approve timesheets for:
/*DELETE FROM dbo.UserCompany
GO
INSERT INTO dbo.UserCompany (UsersVerifyingTimeSheets_Id, CompanyId)
SELECT DISTINCT u.Id, c.Id
FROM Users AS u JOIN Companies AS c
	ON c.Id % 21 = (u.Id % (SELECT MAX(Id) FROM Companies) ) % 21
	-- OR c.Id = (u.Id % (SELECT MAX(Id) FROM Companies) )
ORDER BY u.Id
*/


DECLARE @UserName VARCHAR(100)
DECLARE UserNames CURSOR LOCAL FOR SELECT LOWER(UserName) AS UserName FROM Users

OPEN UserNames
FETCH NEXT FROM UserNames INTO @UserName
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT '*** ' + @UserName
    EXECUTE dbo.createAppUser @UserName, '12345'
	EXECUTE aspnet_UsersInRoles_AddUsersToRoles '/', @UserName, 'Employees', NULL
	-- EXEC aspnet_UsersInRoles_AddUsersToRoles '/', 'user0', 'Administrators', NULL
	-- EXEC aspnet_UsersInRoles_AddUsersToRoles '/', 'user0', 'Approvers', NULL
    FETCH NEXT FROM UserNames into @UserName
END

CLOSE UserNames
DEALLOCATE UserNames
GO