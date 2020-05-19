@echo off
setlocal enabledelayedexpansion

REM 環境変数をセットする
set WARN=80
set CRIT=90

REM 引数を変数にセットする
set DRVNAME=%1:

REM ログファイルの作成
copy nul %~dp0batch_test9.log
set LOG_FILE=%~dp0batch_test9.log

REM 引数があるかを確認・なければ異常終了させる
if "%1" equ "" (
    echo 引数が指定されていません。
    exit /b 1
)

REM 引数で与えられたドライブの存在確認
if not exist %DRVNAME% (
    REM 存在しなければ、異常終了
    echo 指定されたドライバは存在しません。 > %LOG_FILE%
    exit /b 1
)

REM 存在していれば、一時ファイルに書き込む。
if exist %DRVNAME% (
    typeperf -sc 1 -si 1 "\LogicalDisk(%DRVNAME%)\%% Free Space" -o %~dp0batch_test9.txt -y
    for /f "delims=. tokens=1-2 USEBACKQ" %%c in (`findstr /v "Free Space" %~dp0batch_test9.txt`) do (
        set NUM1=%%~c
        set NUM2=%%~d
        echo !NUM1!
    )
)
REM REM 100からNUM1を引き算する
REM set /a NUM3=100-!NUM1!
REM echo %NUM3%

REM REM NUM3と、変数CRITの値を比較する。
REM if %NUM3% geq %CRIT% (
REM     REM NUM3のほうが%CRIT%以上の場合
REM     echo ディスク使用率がクリティカルの値を超えています。
REM     echo ディスク使用率がクリティカルの値を超えています。 > %DRVNAME%\Work\batch_test9.log
REM     del /q %DRVNAME%\Work\batch_test9.txt.log
REM     del /q %DRVNAME%\Work\batch_test9.txt
REM     echo 1

REM ) else if %NUM3% lss %CRIT% (
REM     REM NUM3のほうが%CRIT%未満の場合
REM     echo 2

REM     if %NUM3% geq %WARN% (
REM         REM NUM3のほうが%WARN%以上の場合
REM         echo ディスク使用率が警告の値を超えています。
REM         echo ディスク使用率が警告の値を超えています。 > %DRVNAME%\Work\batch_test9.log
REM         del /q %DRVNAME%\Work\batch_test9.txt.log
REM         del /q %DRVNAME%\Work\batch_test9.txt
REM         echo 3

REM     ) else if %NUM3% lss %WARN% (
REM         REM NUM3のほうが%WARN%未満の場合
REM         echo ディスク使用率は閾値超えていません。
REM         echo ディスク使用率は閾値超えていません。 > !DRVNAME!\Work\batch_test9.log
REM         del /q %DRVNAME%\Work\batch_test9.txt.log
REM         del /q %DRVNAME%\Work\batch_test9.txt
REM         echo 4
REM     )
REM )

REM exit /b 0

REM REM カウンター（FREE SPACE）参考：https://www.sskpc.net/sskpc/w2003s/ch6/6_7_1.html
REM REM findstrコマンドのオプション参考：https://www.k-tanaka.net/cmd/findstr.php
REM REM typeperfコマンド参考：https://4thsight.xyz/14738
REM REM 変数から""を取り除く参考：https://qiita.com/tomotagwork/items/5b9e08f28d5925d96b5f
REM REM echoはoffです解消参考：https://www.google.com/search?sxsrf=ALeKk01xlJL5VFeEdqWDIAYvgy8oWcP6NA%3A1588990955034&ei=6xO2XqjXAaTfmAXI6IKICQ&q=echo%E3%81%AFoff%E3%81%A7%E3%81%99&oq=echo%E3%81%AF&gs_lcp=CgZwc3ktYWIQARgAMgIIADICCAAyBAgAEAQyBAgAEAQyAggAMgIIADoHCAAQRhD_AToHCCMQ6gIQJzoECCMQJzoHCAAQgwEQBDoECAAQQzoFCAAQgwFQqftHWKWhSGDBs0hoAnAAeAGAAfoDiAGCF5IBCTAuNi42LjUtMZgBAKABAaoBB2d3cy13aXqwAQo&sclient=psy-ab
REM REM for /fの使い方：https://www.lisz-works.com/entry/bat-split-for-f
REM REM バッチ内での計算：https://jj-blues.com/cms/wantto-calculationinbatfile/
REM REM 比較演算子：https://qiita.com/plcherrim/items/8edf3d3d33a0ae86cb5c
REM REM ファイル削除の仕方：https://www.k-tanaka.net/cmd/del.php