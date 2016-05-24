SET SQLCMD="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.EXE"
SET SERVER=(localdb)\MSSQLLocalDB
SET DB=TimeSheetDB

%SQLCMD% -E -S %SERVER% -d %DB% -Q "SET QUOTED_IDENTIFIER ON; DELETE FROM TimeSheetEntries; DELETE FROM UserCompany; DELETE FROM Users; DELETE FROM Companies;"
%SQLCMD% -E -S %SERVER% -d %DB% -i CompaniesTestData.sql
%SQLCMD% -E -S %SERVER% -d %DB% -i UsersTestData.sql
%SQLCMD% -E -S %SERVER% -d %DB% -i genTestTimeSheetData.sql
