@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: You must first run Curl-Install.bat and Wget-Install.bat
REM
REM Install AIMP
REM
REM ****************************************

REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
    IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
    ECHO .
    ECHO You need administrator rights to run!
    ECHO .
    GOTO ENDSUB
)

REM ����� ���祭�� ��६�����
set MyFolder=%SystemRoot%\TMP\Mihanikus

set URLaimp="https://www.aimp.ru/?do=download.file&id=4"

REM ���室�� �� ��⥬�� ���
%SystemDrive%

REM ������ ����� ��� �࠭���� ����ਡ�⨢�� � ���室�� � ���
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install AIMP...
ECHO .

	wget.exe --no-check-certificate -O "%MyFolder%\aimp.exe" %URLaimp%
	Start /wait aimp.exe /AUTO /SILENT

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
