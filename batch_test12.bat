@ECHO OFF
setlocal enabledelayedexpansion
REM ####################################################################################################
REM #処理概要
REM #　イベントログの取得
REM #引数
REM #  なし
REM #入力ファイル
REM #  なし
REM #戻り値
REM #  0 正常終了
REM #  1 異常終了
REM #出力ファイル
REM #　
REM ####################################################################################################

REM イベントログフォルダ
set LOG_FO = C:\log\eventlog
REM ファイル作成日
set yy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set /a dd=%dd%-1
set dd=00%dd%
set dd=%dd:~-2%
if %dd%==00 (
if %mm%==01 (set mm=12&& set dd=31&& set /a yy=%yy%-1)
if %mm%==02 (set mm=01&& set dd=31)
if %mm%==03 (set mm=02&& set dd=28&& if %ymod%==0 (set dd=29))
if %mm%==04 (set mm=03&& set dd=31)
if %mm%==05 (set mm=04&& set dd=30)
if %mm%==06 (set mm=05&& set dd=31)
if %mm%==07 (set mm=06&& set dd=30)
if %mm%==08 (set mm=07&& set dd=31)
if %mm%==09 (set mm=08&& set dd=31)
if %mm%==10 (set mm=09&& set dd=30)
if %mm%==11 (set mm=10&& set dd=31)
if %mm%==12 (set mm=11&& set dd=30)
)

REM C:\log\eventlogがない場合
if not exist %LOG_FO% (
    REM C:\log\eventlogを作成する。
    md log/eventlog
)

REM ####################################################################################################
REM #参考サイト一覧
REM #フォルダ作成コマンド：https://jj-blues.com/cms/command-mkdirmd/
REM #Powershell イベントログの表示の仕方：https://qiita.com/gtom7156/items/f2e29d2abadb0134560f
REM #
REM #
REM ####################################################################################################

REM ####################################################################################################
REM #流れ
REM 1.C:\log\eventlogのフォルダが存在確認
REM C:\log\eventlogの検索
REM 存在しない場合
REM C:\log\eventlogを作成

REM 2.イベントの存在確認
REM 昨日のAPPイベントの検索
REM APPイベントが存在する場合
REM ファイルの作成

REM 昨日のSYSイベントの検索
REM SYSイベントが存在する場合
REM ファイルの作成

REM 昨日のSECイベントの検索
REM SECイベントが存在する場合
REM ファイルの作成

REM 3.戻り値の判定


REM ####################################################################################################
