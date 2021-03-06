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

REM C:\log\eventlogがない場合
if not exist %LOG_FO% (
    REM C:\log\eventlogを作成する。
    md log/eventlog
)

powershell -NoProfile -ExecutionPolicy Unrestricted C:\Work\batch_test12.ps1

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
REM フラグを立てる

REM 昨日のSYSイベントの検索
REM SYSイベントが存在する場合
REM ファイルの作成
REM フラグを立てる

REM 昨日のSECイベントの検索
REM SECイベントが存在する場合
REM ファイルの作成
REM フラグを立てる

REM 3.フラグの判定



REM ####################################################################################################
