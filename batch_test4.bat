@echo off
setlocal enabledelayedexpansion

set LISTFILE=%~dp0batch_test4.lst
set FALL_FLG=0
REM Windowsサービスの停止確認
for /f %%a in (%LISTFILE%) do (
	sc query %%a | findstr STOPPED
	set RETURN=%ERRORLEVEL%

	REM 対象のサービスが停止している場合は起動
	if "%RETURN%" neq "0" (
		net start %%a
		set RETURN=%ERRORLEVEL%

		REM　起動しない場合10秒後経過後に再起動
		if "!RETURN!" neq "0" (
			timeout /NOBREAK 10
			net start %%a
			set RETURN=%ERRORLEVEL%

			REM 起動失敗時、FALL_FLGを1にする
			if "!RETURN!" neq "0" (
				echo %%a停止に失敗しました
				set FALL_FLG=1
			)
		) 
	)
)

REM 終了時判定
if "!FALL_FLG!" equ "0" (
	REM batch_test2.bat呼び出し
	call  %~dp0batch_test2.bat
	set RETURN=%ERRORLEVEL%

		REM batch_test2終了判定
		if "!RETURN!" equ "0" (
			echo 正常終了
			exit /b 0
		) else (
			echo 異常終了
			exit /b 1
		)

) else (
	echo 異常終了
	exit /b 1
)



exit 0
