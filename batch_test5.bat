@echo off

set BACKUP_FLD=E:\WindowsImageBackup

REM WIN2016というファイル名があるかを確認
dir /b %BACKUP_FLD% | findstr /x "Win2016"
set RETURN=%ERRORLEVEL%

REM WIN2016というファイル名があればバックアップ不可、異常終了
if "%RETURN%" equ "0" (
	echo Win2016というフォルダが存在します。バックアップができません。
	exit /b 1 
)

REM WindowsServerバックアップ実行
wbadmin start backup -backuptarget:E: -include:C: -quiet
set RETURN=%ERRORLEVEL%

REM バックアップを正常に行えなかった場合、異常終了
if "!RETURN!" neq "0" (
	echo バックアップを正常に行えませんでした。
	exit /b 1
)

REM バックアップファイルのリネーム
set BACKUP_DATE=%date:~0,4%%date:~5,2%%date:~8,2%

ren %BACKUP_FLD%\Win2016 Win2016_%REN_DATE%
set RETURN=%ERRORLEVEL%

REM リネームに失敗した場合、異常終了
if "!RETURN!" neq "0" (
	echo リネームに失敗しました。
	exit /b 1
)

REM 降順にして、3世代保管
set COUNT=2

for /f "skip=%COUNT%" %%a in ('dir %BACKUP_FLD% /b /o-n') do (
	rmdir /s /q %BACKUP_FLD%\%%a
	set RETURN=%ERRORLEVEL%

	REM 世代保管に失敗した場合、異常終了
	if "!RETURN!" neq "0" (
		echo 世代保管に失敗しました。
		exit /b 1
	)	
)

exit /b 0