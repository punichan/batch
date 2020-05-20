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

REM ドライブが存在するか確認
if exist %DRVNAME% (
    REM ドライブのフリースペースを取得、一時ファイルに読みだす。
    typeperf -sc 1 -si 1 "\LogicalDisk(%DRVNAME%)\%% Free Space" -o %~dp0batch_test9.txt -y
    for /f "delims=, tokens=1-2 USEBACKQ" %%c in (`findstr /v "Free Space" %~dp0batch_test9.txt`) do (
        set NITIJI=%%~c
        set FREESPACE=%%~d

        REM 変数FREESPACEに値がセットされているかを確認
        if defined FREESPACE (
            REM 設定されている場合、変数の内容を1行ずつ読みだす
            for /F "DELIMS=. TOKENS=1-2 USEBACKQ" %%e IN (`echo !FREESPACE!`) do (
                set FREESP1=%%e
                set FREESP2=%%f
                set /A USAGE=100-!FREESP1!

                REM ディスク使用率とクリティカル闘値を比較
                if !USAGE! geq !CRIT! (
                    REM　NUM3のほうが%CRIT%以上の場合
                    echo ディスク使用率がクリティカルの値を超えています。
                    echo ディスク使用率がクリティカルの値を超えています。 > %DRVNAME%\Work\batch_test9.log
                    del /q %DRVNAME%batch_test9.txt
                ) else (
                    REM ディスク使用率と警告闘値を比較
                    if !USAGE! geq !WARN! (
                        REM NUM3のほうが%WARN%以上の場合
                        echo ディスク使用率が警告の値を超えています。
                        echo ディスク使用率が警告の値を超えています。 > %DRVNAME%\Work\batch_test9.log
                        del /q %DRVNAME%\Work\batch_test9.txt
                    )
                )
            )
        )
    )
)




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
REM for /fのオプション：https://www.keicode.com/windows/for-command.php
REM if defined 変数が設定されているか確認する：https://maku77.github.io/windows/batch/check-env-var.html