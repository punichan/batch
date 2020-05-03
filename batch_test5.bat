@echo off

set BACKUP_FLD=E:\WindowsImageBackup

REM WIN2016というファイル名があるかを確認
dir /b %BACKUP_FLD% | findstr /x "Win2016"
set RETURN=%ERRORLEVEL%

REM WIN2016というファイル名があればバックアップ不可
if %RETURN% equ 0 (
	echo Win2016というフォルダが存在します。バックアップができません。
	exit /b 1 
)

REM WindowsServerバックアップ実行
wbadmin start backup -backuptarget:E: -include:C:

REM バックアップファイルのリネーム
set BACKUP_DATE=%date:~0,4%%date:~5,2%%date:~8,2%

ren %BACKUP_FLD%\Win2016 Win2016_%REN_DATE%

REM 降順にして、3世代保管
set COUNT=2

for /f "skip=%COUNT%" %%a in ('dir %BACKUP_FLD% /b /o-n') do (
	rmdir /s /q %BACKUP_FLD%\%%a
)

exit /b 0