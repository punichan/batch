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
set TMP_FILE=%~dp0batch_test9.txt

REM 引数で与えられたドライブの存在確認
if exist %DRVNAME% (
    REM 存在していれば、一時ファイルに書き込む。
    typeperf -sc 1 -si 1 "\LogicalDisk(%DRVNAME%)\% Free Space" -o %TMP_FILE% -y
    findstr /v Free %TMP_FILE% > %TMP_FILE%

    for /f "delims=, tokens=1-2" %%a in (%TMP_FILE%) do (
        set COL1 = %%a
        set COL2 = %%b
    )
) else (
        REM 存在しなければ、異常終了
        echo 指定されたドライバは存在しません。
        echo 指定されたドライバは存在しません。 > %~dp0batch_test9.log
        exit /b 1
    )

REM カウンター（FREE SPACE）参考：https://www.sskpc.net/sskpc/w2003s/ch6/6_7_1.html
REM findstrコマンドのオプション参考：https://www.k-tanaka.net/cmd/findstr.php


