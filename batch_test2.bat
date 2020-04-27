@echo off
REM Windowsタイムサービスの確認
sc query w32time | findstr RUNNING
set RETURN=%ERRORLEVEL%

if "%RETURN%" neq "0" (
	REM　Windowsタイムサービスが起動していない場合は起動する。
	net start w32time
	set RETURN=%ERRORLEVEL%

		if "%RETURN%" neq "0" (
			REM 起動失敗
			echo Windowsタイムサービスの起動に失敗しました。
			exit /b 1
		)
)

REM 時刻同期
w32tm /resync
set RETURN=%ERRORLEVEL%

if %RETURN% neq 1 (
	REM 時刻同期失敗
	echo 時刻同期に失敗しました。
	exit /b 1
)

REM 時刻同期確認
w32tm /query /status

exit 0


rem 参考
rem 管理者権限 https://www.adminweb.jp/command/ini/index12.html
rem 条件分岐 https://www.adminweb.jp/command/bat/index8.html#section3
rem 時刻同期設定 https://spiral.hatenadiary.org/entry/20110310/1327558925
rem サービスのステータス https://tipstour.net/command/8289#i-3
rem errorlevelについて https://jj-blues.com/cms/command-errorlevel/