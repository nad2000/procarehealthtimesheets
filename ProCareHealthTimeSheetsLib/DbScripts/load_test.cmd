SET SQLCMD="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.EXE"
SET SERVER=(localdb)\MSSQLLocalDB

%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i CompaniesTestData.sql
%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i UsersTestData.sql
%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i genTestTimeSheetData.sql
