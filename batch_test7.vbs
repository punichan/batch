'圧縮するフォルダ
SorceFolder = "C:\Work\"
'zipの作成先
DestZipPath = "D:\test7.zip"


wkArray = Array(80, 75, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
For i = 0 To UBound(wkArray)
  strbuf = strbuf & Chr(wkArray(i))
Next

'空のZIPファイルを作成
Set objFSO = WScript.CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(DestZipPath, 2, True)
objFile.Write(strbuf)
objFile.Close

'ZIPファイルにフォルダ内のファイルをコピー
For Each objFile In objFSO.GetFolder(SorceFolder).Files
   CreateObject("Shell.Application").NameSpace(DestZipPath).CopyHere(objFile.path)
   WScript.sleep 3000
Next

msgbox "圧縮したよ"


' コード元参考：https://haradago.hatenadiary.org/entry/20150417/p1
' FileSystemObject参考：https://nacookan.hatenadiary.org/entry/20080221/1203607060
' OpenTextFile参考：http://wsh.style-mods.net/ref_filesystemobject/opentextfile.htm
' 空ファイルの作成参考：https://tokkan.net/wsh/text.html
' GetFolder参考：https://www.google.com/search?q=GetFolder&oq=GetFolder&aqs=chrome..69i57j0l7.470j0j7&sourceid=chrome&ie=UTF-8
' .files参考：https://bayashita.com/p/entry/show/33
' CreateObjectオブジェクト参考：http://sammaya.jugem.jp/?eid=2
' プロパティとは参考：https://www.google.com/search?q=puropateli&oq=puropateli+&aqs=chrome..69i57j69i59j0l6.3014j1j7&sourceid=chrome&ie=UTF-8