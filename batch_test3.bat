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

REM 参考
REM 管理者権限でのカレントディレクトリ：http://piyopiyocs.blog115.fc2.com/blog-entry-867.html
REM 変数の宣言：http://capm-network.com/?tag=Windows%E3%83%90%E3%83%83%E3%83%81%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E5%A4%89%E6%95%B0
REM 比較演算子：https://qiita.com/plcherrim/items/8edf3d3d33a0ae86cb5c