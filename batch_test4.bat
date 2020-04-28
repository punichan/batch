@echo off
setlocal enabledelayedexpansion

set LISTFILE=%~dp0batch_test4.lst

REM Windowsサービスの停止確認
for /f %%a in (%LISTFILE%) do (
	sc query %%a | findstr STOPPED
)

REM Windowsサービスの起動
for /f %%b in (%LISTFILE%) do (
	net start %%b
	set RETURN=%ERRORLEVEL%

		REM サービスの再起動
		if "!RETURN!" neq "0" (
			timeout /NOBREAK 10
			net start %%b
			set RETURN=%ERRORLEVEL%

				REM　再起動失敗、異常終了
				if "!RETURN!" neq "0" (
					echo サービスの起動に失敗しました。
					exit /b 1
				)
		)
)

REM batch_test2.bat呼び出し
call  %~dp0batch_test2.bat

exit 0
