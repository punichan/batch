@echo off
setlocal enabledelayedexpansion

set LISTFILE=%~dp0batch_test3.lst
set FALL_FLG=0
for /f %%a in (%LISTFILE%) do (
	REM Windowsサービス稼働の確認
	sc query %%a | findstr RUNNING
	set RETURN=%ERRORLEVEL%
	
	if "!RETURN!" neq "0" (
		REM Windowsサービス停止
		net stop %%a
		set RETURN=%ERRORLEVEL%

			if "!RETURN!" neq "0" (
				REM 10秒経過後再度停止を実行
				timeout /NOBREAK 10
				net stop %%a
				set RETURN=%ERRORLEVEL%

				if "!RETURN!" neq "0" (
					echo %%a停止失敗しました
					set FALL_FLG=1
				)
			)
		)	
	)
)

REM 終了時判定		
if "%FALL_FLG%" equ "0" (
	echo 正常終了
	exit /b 0
) else (
	echo 異常終了
	exit /b 1
)

REM 参考
REM 管理者権限でのカレントディレクトリ：http://piyopiyocs.blog115.fc2.com/blog-entry-867.html
REM 変数の宣言：http://capm-network.com/?tag=Windows%E3%83%90%E3%83%83%E3%83%81%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%A4%89%E6%95%B0
REM 比較演算子：https://qiita.com/plcherrim/items/8edf3d3d33a0ae86cb5c