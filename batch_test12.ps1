####################################################################################################
#処理概要
#　イベントログの取得
#引数
#  なし
#入力ファイル
#  なし
#戻り値
#  0 正常終了
#  1 異常終了
#出力ファイル
#　
####################################################################################################

$YESTER=Get-Date (Get-Date).AddDays(-1) -format "yyyyMMdd"
$APP_LOGFILE="C:\log\eventlog\Application.log.$YESTER"
$SYS_LOGFILE="C:\log\eventlog\System.log.$YESTER"
$SEC_LOGFILE="C:\log\eventlog\Security_log.$YESTER"

# 昨日の日付
$START=Get-Date (Get-Date).AddDays(-1) -format "yyyy/MM/dd 00:00:00"
$END=Get-Date (Get-Date).AddDays(-1) -format "yyyy/MM/dd 23:59:59"

# APPイベントログの存在確認
Get-EventLog -LogName Application -source * -After $START -Before $END
$RETURN_APP=$?

# APPログが存在する場合
if ("$RETURN_APP" -eq "True") {
    Get-EventLog -LogName Application -source * -After $START -Before $END > $APP_LOGFILE
}

# SYSイベントログの存在確認
Get-EventLog -LogName System -source * -After $START -Before $END
$RETURN_SYS=$?

# APPログが存在する場合
if ("$RETURN_SYS" -eq "True") {
    Get-EventLog -LogName System -source * -After $START -Before $END > $SYS_LOGFILE
}

# SECイベントログの存在確認
Get-EventLog -LogName Security -source * -After $START -Before $END
$RETURN_SEC=$?

# APPログが存在する場合
if ("$RETURN_SEC" -eq "True") {
    Get-EventLog -LogName Security -source * -After $START -Before $END > $SEC_LOGFILE
}


if ("$RETURN_APP" -and "$RETURN_SYS" -and "$RETURN_SEC" -eq "True") {
    exit 0
} 

####################################################################################################
#参考
# powershell,ps1の決まり：https://qiita.com/opengl-8080/items/bb0f5e4f1c7ce045cc57#%E8%AB%96%E7%90%86%E6%BC%94%E7%AE%97
# 戻り値の取得方法：　https://qiita.com/toshihirock/items/5845edef939f8232a167
# ファイル名取得エラー解決の参考：https://www.ipentec.com/document/windows-powershell-execute-powershell-script-in-dos-prompt
# get-eventlogの使い方：https://www.atmarkit.co.jp/ait/articles/1608/23/news023.htm
####################################################################################################