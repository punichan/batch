@echo off
REM Windowsサービス稼働の確認
REM set LISTFILE=C:\Users\まさみ\Documents\GitHub\batch\batch_test3.lst
REM for /f %%a in (%LISTFILE%) do (
REM 	sc query %%a | findstr RUNNING
REM )

set LISTFILE=%~dp0batch_test3.lst

for /f %%a in (%LISTFILE%) do (
	sc query %%a | findstr RUNNING
)

REM Windowsサービス停止
for /f %%b in (%LISTFILE%) do (
	net stop %%b
	set RETURN=%ERRORLEVEL%

	REM Windowsサービス停止失敗、10秒停止後、再度停止
	if %RETURN% neq 0 (
		timeout /NOBREAK 10
		net stop %%b
		set RETURN=%ERRORLEVEL%
		
		if %RETURN% neq 0 (
			echo %%b停止失敗しました
			exit /b 1
		)
	)
)

pause