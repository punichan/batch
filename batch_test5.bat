@echo off

REM WindowsServerバックアップ実行
wbadmin start backup -backuptarget:E: -include:C: