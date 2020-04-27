@echo off
sc query w32time | findstr RUNNING
if errorlevel 1 (
	net start w32time
	sc query w32time
)

w32tm /resync
if errorlevel 1 (
	echo 時刻同期に失敗しました。
)

w32tm /query /status

pause


rem 参考
rem 管理者権限 https://www.adminweb.jp/command/ini/index12.html
rem 条件分岐 https://www.adminweb.jp/command/bat/index8.html#section3
rem 時刻同期設定 https://spiral.hatenadiary.org/entry/20110310/1327558925
rem サービスのステータス https://tipstour.net/command/8289#i-3
rem errorlevelについて https://jj-blues.com/cms/command-errorlevel/