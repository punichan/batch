 @echo off
setlocal enabledelayedexpansion

set TIME=[%date%:%time%]

REM ���ϐ����Z�b�g����
set WARN=50
set CRIT=60

REM ������ϐ��ɃZ�b�g����
set DRVNAME=%1:

set LOG_FILE=%~dp0batch_test9.log

REM ���������邩���m�F�E�Ȃ���Έُ�I��������
if "%1" equ "" (
    echo �������w�肳��Ă��܂���
    exit /b 1
)

REM �����ŗ^����ꂽ�h���C�u�̑��݊m�F
if not exist %DRVNAME% (
    REM ���݂��Ȃ���΁A�ُ�I��
    echo %TIME% �w�肳�ꂽ�h���C�u�͑��݂��܂��� >  %LOG_FILE%
    exit /b 1
)

REM �h���C�u�����݂��邩�m�F
if exist %DRVNAME% (
    REM �h���C�u�̃t���[�X�y�[�X���擾�A�ꎞ�t�@�C���ɓǂ݂����B
    typeperf -sc 1 -si 1 "\LogicalDisk(%DRVNAME%)\%% Free Space" -o %~dp0batch_test9.txt -y
    for /f "delims=, tokens=1-2 USEBACKQ" %%c in (`findstr /v "Free Space" %~dp0batch_test9.txt`) do (
        set NITIJI=%%~c
        set FREESPACE=%%~d   
        REM�@�ꎞ�t�@�C�����폜
        del /q %~dp0batch_test9.txt
    )

    REM �ϐ�FREESPACE�ɒl���Z�b�g����Ă��邩���m�F
    if defined FREESPACE (  
        REM �ݒ肳��Ă���ꍇ�A�ϐ��̓��e��1�s���ǂ݂���
        for /F "DELIMS=. TOKENS=1-2 USEBACKQ" %%e IN (`echo !FREESPACE!`) do (
            set FREESP1=%%e
            set FREESP2=%%f
            set /A USAGE=100-!FREESP1!
        )

        REM �f�B�X�N�g�p���ƃN���e�B�J�����l���r
        if !USAGE! geq %CRIT% (
            REM�@NUM3�̂ق���%CRIT%�ȏ�̏ꍇ
            echo %TIME%�f�B�X�N�g�p�����N���e�B�J���̒l�𒴂��Ă��܂��B >> !LOG_FILE!
            
        ) else (
            REM �f�B�X�N�g�p���ƌx�����l���r
            if !USAGE! geq !WARN! (
                REM NUM3�̂ق���%WARN%�ȏ�̏ꍇ
                echo %TIME%�f�B�X�N�g�p�����x���̒l�𒴂��Ă��܂��B >> !LOG_FILE!
            )
        )

        REM �h���C�u���ƃf�B�X�N�̎g�p�����o��
        echo %TIME%!DRVNAME!!USAGE! >> %LOG_FILE%
        
    ) else (
        REM �h���C�u�����݂��Ȃ��ꍇ
        echo �h���C�u�����݂��܂���B!DRVNAME!
    )
)

exit /b 0

REM �J�E���^�[�iFREE SPACE�j�Q�l�Fhttps://www.sskpc.net/sskpc/w2003s/ch6/6_7_1.html
REM findstr�R�}���h�̃I�v�V�����Q�l�Fhttps://www.k-tanaka.net/cmd/findstr.php
REM typeperf�R�}���h�Q�l�Fhttps://4thsight.xyz/14738
REM �ϐ�����""����菜���Q�l�Fhttps://qiita.com/tomotagwork/items/5b9e08f28d5925d96b5f
REM echo��off�ł������Q�l�Fhttps://www.google.com/search?sxsrf=ALeKk01xlJL5VFeEdqWDIAYvgy8oWcP6NA%3A1588990955034&ei=6xO2XqjXAaTfmAXI6IKICQ&q=echo%E3%81%AFoff%E3%81%A7%E3%81%99&oq=echo%E3%81%AF&gs_lcp=CgZwc3ktYWIQARgAMgIIADICCAAyBAgAEAQyBAgAEAQyAggAMgIIADoHCAAQRhD_AToHCCMQ6gIQJzoECCMQJzoHCAAQgwEQBDoECAAQQzoFCAAQgwFQqftHWKWhSGDBs0hoAnAAeAGAAfoDiAGCF5IBCTAuNi42LjUtMZgBAKABAaoBB2d3cy13aXqwAQo&sclient=psy-ab
REM for /f�̎g�����Fhttps://www.lisz-works.com/entry/bat-split-for-f
REM �o�b�`���ł̌v�Z�Fhttps://jj-blues.com/cms/wantto-calculationinbatfile/
REM ��r���Z�q�Fhttps://qiita.com/plcherrim/items/8edf3d3d33a0ae86cb5c
REM �t�@�C���폜�̎d���Fhttps://www.k-tanaka.net/cmd/del.php
REM for /f�̃I�v�V�����Fhttps://www.keicode.com/windows/for-command.php
REM if defined �ϐ����ݒ肳��Ă��邩�m�F����Fhttps://maku77.github.io/windows/batch/check-env-var.html