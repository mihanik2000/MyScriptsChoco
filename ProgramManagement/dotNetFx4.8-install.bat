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
REM Install dotNetFx4.8
REM
REM ****************************************

rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
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
set URLndp48="https://go.microsoft.com/fwlink/?linkid=2088631"
REM set URLndp48="http://repo.mihanik.net/Microsoft/Microsoft_NET/ndp48-x86-x64-allos-enu.exe"
set MyFolder=%SystemRoot%\TMP\Mihanikus

REM ���室�� �� ��⥬�� ���
%SystemDrive%

REM ������ ����� ��� �࠭���� ����ਡ�⨢�� � ���室�� � ���
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install dotNetFx4.8...
ECHO .

wget.exe --no-check-certificate -O "%MyFolder%\ndp48.exe" %URLndp48%
Start /wait ndp48.exe /q /norestart

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
