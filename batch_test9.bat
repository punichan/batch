@echo off
setlocal enabledelayedexpansion

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

REM 引数で与えられたドライブの存在確認
if not exist %DRVNAME% (
    REM 存在しなければ、異常終了
    echo 指定されたドライバは存在しません。
    echo 指定されたドライバは存在しません。 > %DRVNAME%\Work\batch_test9.log
    exit /b 1

) else (
    REM 存在していれば、一時ファイルに書き込む。
    typeperf -sc 1 -si 1 "\LogicalDisk(%DRVNAME%)\%% Free Space" -o %DRVNAME%\Work\batch_test9.txt -y
    findstr /v "Free" %DRVNAME%\Work\batch_test9.txt > %DRVNAME%\Work\batch_test9.txt.log

    REM 一時ファイルから変数のセット
    for /f "delims=, tokens=1-2" %%a in (%DRVNAME%\Work\batch_test9.txt.log) do (
        set COL1=%%~a
        set COL2=%%~b
    )
)

REM カラム2の変数がセットされているか確認 
echo !COL2!
for /f "delims=. tokens=1-2" %%c in ("!COL2!") do (
    set NUM1=%%~c
    set NUM2=%%~d
)

REM 100からNUM1を引き算する
set /a NUM3=100-!NUM1!
echo %NUM3%

REM NUM3と、変数CRITの値を比較する。
if %NUM3% geq %CRIT% (
    REM NUM3のほうが%CRIT%以上の場合
    echo ディスク使用率がクリティカルの値を超えています。
    echo ディスク使用率がクリティカルの値を超えています。 > %DRVNAME%\Work\batch_test9.log
    del /q %DRVNAME%\Work\batch_test9.txt.log
    del /q %DRVNAME%\Work\batch_test9.txt
    echo 1

) else if %NUM3% lss %CRIT% (
    REM NUM3のほうが%CRIT%未満の場合
    echo 2

    if %NUM3% geq %WARN% (
        REM NUM3のほうが%WARN%以上の場合
        echo ディスク使用率が警告の値を超えています。
        echo ディスク使用率が警告の値を超えています。 > %DRVNAME%\Work\batch_test9.log
        del /q %DRVNAME%\Work\batch_test9.txt.log
        del /q %DRVNAME%\Work\batch_test9.txt
        echo 3

    ) else if %NUM3% lss %WARN% (
        REM NUM3のほうが%WARN%未満の場合
        echo ディスク使用率は閾値超えていません。
        echo ディスク使用率は閾値超えていません。 > !DRVNAME!\Work\batch_test9.log
        del /q %DRVNAME%\Work\batch_test9.txt.log
        del /q %DRVNAME%\Work\batch_test9.txt
        echo 4
    )
)

echo 5
exit /b 0

REM カウンター（FREE SPACE）参考：https://www.sskpc.net/sskpc/w2003s/ch6/6_7_1.html
REM findstrコマンドのオプション参考：https://www.k-tanaka.net/cmd/findstr.php
REM typeperfコマンド参考：https://4thsight.xyz/14738
REM 変数から""を取り除く参考：https://qiita.com/tomotagwork/items/5b9e08f28d5925d96b5f
REM echoはoffです解消参考：https://www.google.com/search?sxsrf=ALeKk01xlJL5VFeEdqWDIAYvgy8oWcP6NA%3A1588990955034&ei=6xO2XqjXAaTfmAXI6IKICQ&q=echo%E3%81%AFoff%E3%81%A7%E3%81%99&oq=echo%E3%81%AF&gs_lcp=CgZwc3ktYWIQARgAMgIIADICCAAyBAgAEAQyBAgAEAQyAggAMgIIADoHCAAQRhD_AToHCCMQ6gIQJzoECCMQJzoHCAAQgwEQBDoECAAQQzoFCAAQgwFQqftHWKWhSGDBs0hoAnAAeAGAAfoDiAGCF5IBCTAuNi42LjUtMZgBAKABAaoBB2d3cy13aXqwAQo&sclient=psy-ab
REM for /fの使い方：https://www.lisz-works.com/entry/bat-split-for-f
REM バッチ内での計算：https://jj-blues.com/cms/wantto-calculationinbatfile/
REM 比較演算子：https://qiita.com/plcherrim/items/8edf3d3d33a0ae86cb5c
REM ファイル削除の仕方：https://www.k-tanaka.net/cmd/del.php