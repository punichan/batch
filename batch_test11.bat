@ECHO OFF
setlocal enabledelayedexpansion
REM ####################################################################################################
REM #処理概要
REM #　タスクスケジューラーの動作確認
REM #引数
REM #  なし
REM #入力ファイル
REM #  なし
REM #戻り値
REM #  0 正常終了
REM #  1 異常終了
REM #出力ファイル
REM #　一時ファイル：%~dp0batch_test11.txt
REM #　ログファイル：%~dp0batch_test11.log 
REM ####################################################################################################

REM 確認したいスケジューラ名
set SCH=batchテスト\CHECK_DISK
REM 一時ファイル名
set TMPFLE=%~dp0batch_test11.txt
REM ログファイル
set LOGFLE=%~dp0batch_test11.log
REM 日付
set TIME=[%date%:%time%]

REM 処理を9999回続ける。
for /l %%n in (1,1,9999) do (
    REM CHECK_DISKスケジューラの状態を変数に収納
    schtasks /query /tn %SCH% /fo csv /nh > %TMPFLE%
    for /f "delims=, tokens=1-3 USEBACKQ" %%a in (%TMPFLE%) do (
        set STAT=%%c
        REM　一時ファイルを削除
        del /q %TMPFLE%
    )

    REM スケジューラの状態比較
    if "!STAT!" equ "実行中" (
        REM 60分スリーブさせる
        powershell sleep 3600 > nul
        del /q %~dp0null

    ) else (
        REM スケジューラを起動させる
        schtasks /run /tn %SCH%
        set RETURN=%ERRORLEVEL%

            REM スケジューラ起動確認
            if "!RETURN!" equ "0" (
                echo %TIME% スケジューラが起動しました。 >> %LOGFLE%
            ) else (
                echo %TIME% スケジューラの起動に失敗しました。 >> %LOGFLE%
            )

        REM 60分スリーブさせる
        powershell sleep 3600 > nul
        del /q %~dp0null
    )
)

exit /b 0
REM ####################################################################################################
REM #参考サイト一覧
REM #スケジューラコマンドschtasks：　https://www.atmarkit.co.jp/ait/articles/0506/25/news016.html
REM #スケジューラコマンドschtasks：　マニュアル
REM #
REM #
REM #
REM ####################################################################################################