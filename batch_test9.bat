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
set DRVNAME=%1:

REM 実行日時をlogに出力する
echo %date% > %~dp0batch_test9.log

REM 一時ファイルのパス
set TMP_FILE=C:\Users\まさみ\Documents\GitHub\batch\batch_test9.txt

REM 引数で与えられたドライブの存在確認
if not exist "%DRVNSME%" (
    REM 存在しなければ、異常終了
    echo 指定されたドライバは存在しません。
    echo 指定されたドライバは存在しません。 > %~dp0batch_test9.log
    exit /b 1

    REM 存在していれば、一時ファイルに書き込む。
) else (
    typeperf -sc 1 -si 1 "\LogicalDisk(%DRVNAME%)\%% Free Space" -o %TMP_FILE% -y
    findstr /v Free %TMP_FILE%
)

REM カウンター（FREE SPACE）参考：https://www.sskpc.net/sskpc/w2003s/ch6/6_7_1.html
REM findstrコマンドのオプション参考：https://www.k-tanaka.net/cmd/findstr.php
