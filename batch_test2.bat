@echo off
REM Windowsタイムサービス起動確認
sc query w32time | findstr RUNNING
set RETURN=%ERRORLEVEL%

if "%RETURN%" neq "0" (
    REM Windowsタイムサービスが起動していない場合は、起動する。
	net start w32time
	set RETURN=%ERRORLEVEL%
	
	if "%RETURN%" neq "0" (
		REM 起動失敗
		echo WindowsTimeサービスの起動に失敗しました。
		exit /b 1
	)
)

REM 時刻同期
w32tm /resync
set RETURN=%ERRORLEVEL%

if "%RETURN%" neq "0" (
	REM 時刻同期失敗
	echo 時刻同期に失敗しました。
	exit /b 1
)

REM 時刻同期確認
w32tm /query /status

exit /b 0