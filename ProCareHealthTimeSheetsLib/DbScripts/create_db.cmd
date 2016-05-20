SET SQLCMD="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.EXE"
SET SERVER=(localdb)\MSSQLLocalDB

%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i dropAllTables.sql
%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i crTables.sql
%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i crTimeSheetEntries.sql
