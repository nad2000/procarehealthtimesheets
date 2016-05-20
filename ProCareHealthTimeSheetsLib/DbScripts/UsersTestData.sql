SET QUOTED_IDENTIFIER ON
GO

USE [TimeSheetDB]
GO

DELETE FROM Users
GO

-- DROP TABLE #Users
-- GO

SELECT IDENTITY(INT) AS [Num], UserName, Email, FirstName, LastName 
INTO #Users
FROM (VALUES
('tristique', 'tristique@luctusutpellentesque.com','Hilda', 'Herman'),
('augue.malesuada.malesuada', 'augue.malesuada.malesuada@vehicula.org','Cairo', 'Hardy'),
('Duis.sit', 'Duis.sit@nec.edu','Martha', 'Hewitt'),
('posuere.enim.nisl', 'posuere.enim.nisl@nonlaciniaat.ca','Jaquelyn', 'Blair'),
('dictum.mi', 'dictum.mi@ultricesmaurisipsum.com','Sade', 'Blanchard'),
('orci.luctus', 'orci.luctus@auctorodio.ca','Keegan', 'Stein'),
('quam.Curabitur', 'quam.Curabitur@ipsum.ca','Hayes', 'Murphy'),
('erat.semper.rutrum', 'erat.semper.rutrum@ultricies.edu','Scarlett', 'Horne'),
('arcu.Morbi.sit', 'arcu.Morbi.sit@dapibusligula.edu','Hakeem', 'Cote'),
('lorem.semper', 'lorem.semper@dictum.com','Quon', 'Massey'),
('Morbi', 'Morbi@turpisnec.ca','Nero', 'Farmer'),
('metus.In.nec', 'metus.In.nec@habitantmorbitristique.edu','Adena', 'Mullen'),
('consectetuer.adipiscing', 'consectetuer.adipiscing@consequatlectus.edu','Sylvester', 'Alston'),
('lacus.Etiam', 'lacus.Etiam@portaelit.ca','Alden', 'Hancock'),
('In.condimentum.Donec', 'In.condimentum.Donec@atpede.ca','Levi', 'Nelson'),
('tellus.justo.sit', 'tellus.justo.sit@sit.com','Hoyt', 'Burke'),
('ac.urna', 'ac.urna@necleo.edu','Breanna', 'Stewart'),
('nec', 'nec@ipsumacmi.org','Jeanette', 'Mosley'),
('semper.dui', 'semper.dui@nec.edu','Nasim', 'Grant'),
('adipiscing', 'adipiscing@Proin.ca','Gabriel', 'Benton'),
('elit.sed', 'elit.sed@dolor.ca','Nell', 'Vaughn'),
('nunc.In.at', 'nunc.In.at@Curabitursedtortor.ca','Nadine', 'Schwartz'),
('gravida.sagittis', 'gravida.sagittis@tinciduntaliquam.org','Kaitlin', 'Meyer'),
('vel.turpis.Aliquam', 'vel.turpis.Aliquam@liberoMorbiaccumsan.com','acqueline', 'Spears'),
('arcu.eu', 'arcu.eu@Donecatarcu.edu','Blossom', 'Nieves'),
('ultricies.ornare.elit', 'ultricies.ornare.elit@sedpede.org','Hayley', 'Nguyen'),
('Integer.tincidunt', 'Integer.tincidunt@semsemper.edu','Xaviera', 'Wong'),
('sit.amet.orci', 'sit.amet.orci@dolorNulla.org','Lenore', 'Murray'),
('magna', 'magna@rutrumjusto.ca','Ivor', 'English'),
('malesuada', 'malesuada@eterosProin.com','Keiko', 'Leach'),
('Aliquam.tincidunt.nunc', 'Aliquam.tincidunt.nunc@a.edu','Moses', 'Garcia'),
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
('consequat.auctor', 'consequat.auctor@fringillami.ca','Keaton', 'Moon'),
('magna.Duis.dignissim', 'magna.Duis.dignissim@idlibero.edu','Teegan', 'Hensley'),
('tristique.senectus.et', 'tristique.senectus.et@necorci.ca','Upton', 'Alvarez'),
('Aenean.eget.metus', 'Aenean.eget.metus@vitae.ca','Asher', 'Kirkland'),
('dolor.Donec.fringilla', 'dolor.Donec.fringilla@ametrisusDonec.ca','Illana', 'Franklin'),
('Suspendisse.dui.Fusce', 'Suspendisse.dui.Fusce@Aeneansedpede.org','Inga', 'Fitzgerald'),
('pharetra.Quisque.ac', 'pharetra.Quisque.ac@nasceturridiculusmus.edu','Bree', 'Rivas'),
('Fusce', 'Fusce@sitametconsectetuer.edu','Yoshi', 'Caldwell'),
('scelerisque', 'scelerisque@Suspendissedui.edu','Inez', 'Hunter'),
('egestas', 'egestas@Sedpharetrafelis.ca','Noelle', 'Joyner'),
('sem', 'sem@Crasconvallisconvallis.com','Jenna', 'Patrick'),
('enim.Etiam.imperdiet', 'enim.Etiam.imperdiet@nullaIn.org','Donna', 'Petersen'),
('eget.dictum.placerat', 'eget.dictum.placerat@egetvariusultrices.com','Jolie', 'Robbins'),
('ac.mattis', 'ac.mattis@mus.ca','Abraham', 'Golden'),
('ac.nulla', 'ac.nulla@tinciduntnuncac.ca','Lois', 'Watson'),
('aliquam.arcu', 'aliquam.arcu@nonsollicitudin.org','Cade', 'Powers'),
('eleifend', 'eleifend@morbitristique.org','Faith', 'Sykes'),
('Integer.eu.lacus', 'Integer.eu.lacus@orciadipiscingnon.org','Thane', 'Wilder'),
('massa.Vestibulum', 'massa.Vestibulum@nunc.org','Callie', 'Baird'),
('eget.ipsum', 'eget.ipsum@eratnequenon.ca','Marah', 'Sparks'),
('eu.placerat', 'eu.placerat@Crasvulputate.edu','Anthony', 'Stout'),
('erat.Vivamus.nisi', 'erat.Vivamus.nisi@eleifendegestasSed.edu','Ira', 'England'),
('velit.dui.semper', 'velit.dui.semper@Suspendisse.com','Kirsten', 'Lane'),
('lacinia.orci.consectetuer', 'lacinia.orci.consectetuer@ligulaAliquam.com','Kaye', 'Daniel'),
('Praesent', 'Praesent@elit.ca','Morgan', 'Meyer'),
('Suspendisse', 'Suspendisse@Loremipsum.edu','Dora', 'Salinas'),
('Morbi', 'Morbi@Nulla.edu','Felicia', 'Mcintyre'),
('metus', 'metus@felis.org','Melanie', 'Mason'),
('Nulla', 'Nulla@montesnasceturridiculus.com','Stella', 'Campbell'),
('mattis', 'mattis@dolorelitpellentesque.com','Destiny', 'Henderson'),
('Cras.dictum', 'Cras.dictum@ultrices.edu','Emerald', 'Strong'),
('non', 'non@Donecnon.com','Lewis', 'Rowland'),
('diam', 'diam@nibhQuisque.com','Camille', 'Hines'),
('convallis.dolor.Quisque', 'convallis.dolor.Quisque@ultricesiaculis.org','Fitzgerald', 'Kirkland'),
('cursus.in.hendrerit', 'cursus.in.hendrerit@orcitinciduntadipiscing.edu','Britanney', 'Winters'),
('facilisis.non', 'facilisis.non@vestibulumloremsit.edu','Garrison', 'Farmer'),
('lacus.Cras', 'lacus.Cras@pretium.edu','Isaiah', 'Nixon'),
('magna.tellus', 'magna.tellus@enim.org','May', 'Lara'),
('leo', 'leo@Aenean.org','Vernon', 'Guzman'),
('Pellentesque.habitant.morbi', 'Pellentesque.habitant.morbi@scelerisquemollis.com','Colleen', 'Petersen'),
('dictum.augue', 'dictum.augue@Fuscedolorquam.com','August', 'Mendez'),
('montes.nascetur.ridiculus', 'montes.nascetur.ridiculus@eu.edu','Hannah', 'Riley'),
('erat.semper.rutrum', 'erat.semper.rutrum@a.edu','Fatima', 'Baxter'),
('luctus.ut', 'luctus.ut@Classaptent.com','Rajah', 'Freeman'),
('laoreet.posuere.enim', 'laoreet.posuere.enim@Donec.org','Alika', 'Graves'),
('egestas', 'egestas@congueInscelerisque.org','Desiree', 'Blackwell'),
('dui.Cum.sociis', 'dui.Cum.sociis@ultricessitamet.org','Buckminster', 'James'),
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
('ullamcorper.viverra.Maecenas', 'ullamcorper.viverra.Maecenas@urna.edu','Baker', 'Carter'),
('semper.cursus.Integer', 'semper.cursus.Integer@auctor.org','Karly', 'Gilmore'),
('Aliquam.erat', 'Aliquam.erat@in.ca','Xena', 'Bowen'),
('magnis', 'magnis@luctussit.com','Lance', 'Herman'))
AS TestData (UserName, Email, FirstName, LastName)
GO

INSERT INTO Users (UserName, Email, FirstName, LastName)
SELECT STR([Num])+UserName, Email, FirstName, LastName
FROM #Users
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
INSERT INTO dbo.UserCompany (UsersVerifyingTimeSheets_Id, Companies_Id)
SELECT DISTINCT u.Id, c.Id
FROM Users AS u JOIN Companies AS c
	ON c.Id % 21 = (u.Id % (SELECT MAX(Id) FROM Companies) ) % 21
	-- OR c.Id = (u.Id % (SELECT MAX(Id) FROM Companies) )
ORDER BY u.Id
*/