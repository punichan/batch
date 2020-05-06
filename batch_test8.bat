@echo off
echo zipファイル作成します。
powershell -NoProfile -ExecutionPolicy Unrestricted .\batch_test8.ps1
echo zipファイルが作成されました。
exit /b 0

REM powershellの権限変更参考：https://qiita.com/tomoko523/items/df8e384d32a377381ef9