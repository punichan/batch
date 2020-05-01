@echo off

REM バックアップされた日付の変数
set BACKUP_DATE=%date:~0,4%%date:~5,2%%date:~8,2%

REM WindowsServerバックアップ実行
wbadmin start backup -backuptarget:E: -include:C:

REM バックアップファイルのリネーム
ren E:\WindowsImageBackup\Win2016 Win2016_%REN_DATE%