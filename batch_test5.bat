@echo off

REM WindowsServerバックアップ実行
wbadmin start backup -backuptarget:E: -include:C:

REM バックアップファイルのリネーム
set BACKUP_DATE=%date:~0,4%%date:~5,2%%date:~8,2%
set BACKUP_FLD=E:\WindowsImageBackup

if 
ren %BACKUP_FLD%\Win2016 Win2016_%REN_DATE%

REM 降順にして、3世代保管
set COUNT=2
for /f "skip=%COUNT%" %%a in ('dir %BACKUP_FLD% /b /o-n') do (
	rmdir /s /q %BACKUP_FLD%\%%a
)

exit /b 0