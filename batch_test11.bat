@ECHO OFF
setlocal enabledelayedexpansion
REM ####################################################################################################
REM #処理概要
REM # タスクスケジューラーの動作確認
REM #引数
REM #  なし
REM #入力ファイル
REM #  C:\Work\batch_test10.bat
REM #戻り値
REM #  0 正常終了
REM #  1 異常終了
REM #出力ファイル
REM #  無し
REM ####################################################################################################

REM 確認したいスケジューラ名
set SCH=batchテスト\CHECK_DISK
REM 一時ファイル名
set FLE=%~dp0batch_test11.txt

REM 処理を9999回続ける。
for /l %%n in (1,1,9999) do (
    REM CHECK_DISKスケジューラの動作確認
    schtasks /query /tn %SCH% /FO csv /NH > %FLE%
    for /f "delims=, tokens=1-3 USEBACKQ" %%a in (%FLE%) do (
        set STAT=%%c
        REM　一時ファイルを削除
        del /q %FLE%
    )
)

REM ####################################################################################################
REM #参考サイト一覧
REM #スケジューラコマンドschtasks：　https://www.atmarkit.co.jp/ait/articles/0506/25/news016.html
REM #スケジューラコマンドschtasks：　マニュアル
REM #
REM #
REM #
REM ####################################################################################################