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
set LIST_FILE=%~dp0batch_test13.lst

powershell Get-Date (Get-Date).AddDays(-1) -format "yyyyMMdd" > C:\Work\log1.txt
for /f %%a in (C:\Work\log1.txt) do (
	set REF_DATE=%%a
	del /q C:\Work\log1.txt
)

REM batch_test13.lstの存在確認
if not exist %LIST_FILE% (
    REM  存在しない場合、異常終了
    exit /b 1
)

REM リフレッシュ対象ファイルの存在確認
for /f "delims=, tokens=1-3" %%b in (%LIST_FILE%) do (
	set TRAGET_FLE=%%b
	set REF_FLE=%%c
	set HOLD_DATE=%%d

    if exist !TRAGET_FLE! (
        type !TRAGET_FLE! > !TRAGET_FLE!.%REF_DATE%
	null > !TRAGET_FLE!
    )
)
REM ####################################################################################################
REM #参考サイト一覧
REM バッチ内のパワーシェルの呼び出し：https://microsoftou.com/powershell-if/
REM ファイルを空にする方法：https://japanrock-pg.hatenablog.com/entry/20080819/1219126642
REM ####################################################################################################

REM ####################################################################################################
REM #流れ
REM batch_test13.lstの存在確認
REM     存在しない場合、異常終了

REM batch_test13.lstを1つずつ読みだす

REM リフレッシュ対象ファイルの存在確認
REM     ファイルが存在しない場合、次のリフレッシュ対象を読みだす。
REM     ファイルが存在する場合、ファイルをリフレッシュ後ログの格納先に収納
REM     リフレッシュ対象のファイルに対して、NULLコピーする
REM     戻り値をセットする。
REM     戻り値判定
REM     0以外であれば、メッセージを出力、エラーフラグを立てる
REM 上記を繰り返す。

REM 世代保管を超えているログを削除する。
REM     戻り値をセットする。
REM     戻り値判定
REM     0以外であれば、メッセージを出力、エラーフラグを立てる

REM 最後にエラーフラグを判定し、フラグが立っている場合は異常終了。
REM ####################################################################################################
