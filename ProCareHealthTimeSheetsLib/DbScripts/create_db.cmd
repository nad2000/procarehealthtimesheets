SET SQLCMD="C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.EXE"
SET SERVER=(localdb)\MSSQLLocalDB

%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i dropAllTables.sql
%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i crTables.sql
%SQLCMD% -E -S %SERVER% -d TimeSheetDB -i crTimeSheetEntries.sql

FOR %%F IN (
	crBase64.sql
	crApproverTimeSheetEntry_Update.sql
	crBreakTypes.sql
	crCreateAppUser.sql
	crChangeAppUserPwd.sql
	crGetAllUsers.sql
	crGetApprovableUsers.sql
	crGetFullTimeSheetRecords.sql
	crGetTimeSheetSummary.sql
	crGetSummaryReport.sql
	crGetUserDataByUserName.sql
	crGetUserTimeSheetEntries.sql
	crSplitFunction.sql
	crTimeSheetEntries_UpdateTotalTime_TR.sql
	crToNZDateTime.sql
	crUserIdByName.sql
	crUserTimeSheetEntry_Update.sql
	crUser_Select.sql
	crWeekDays.sql
	crWeekEndingDates.sql ) DO %SQLCMD% -E -S %SERVER% -d TimeSheetDB -i %%F
