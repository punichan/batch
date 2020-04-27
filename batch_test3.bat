@echo off

for /f %%a in (batch_test3.lst) do (
	sc query %%a | findstr RUNNING
)

for /f %%a in (batch_test3.lst) do (
	net stop %%a
	if errorlevel 1 (
		timeout /NOBREAK 10
		net stop %%a
		if errorlevel 1(
			echo %%a停止失敗しました
		)
	)
)

pause