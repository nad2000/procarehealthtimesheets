SET SERVER="(localdb)\MSSQLLocalDB"
"C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.EXE" -S %SERVER% -d TimeSheetDB %* 
