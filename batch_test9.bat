@echo off

REM 環境変数をセットする
set WARN=80
set CRIT=90

REM 引数があるかを確認・なければ異常終了させる
if "%1" equ "" (
    echo 引数が指定されていません。
    exit /b 1
)

REM 引数を変数にセットする
set DRVNAME=%1
echo %1

REM 実行日時をlogに出力する
echo %date% > %~dp0batch_test9.log