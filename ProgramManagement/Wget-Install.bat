@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: You must first run Curl-Install.bat
REM
REM Install wget
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

echo .
echo ��⠭�������� Wget
echo .

set URLWget="https://eternallybored.org/misc/wget/1.20.3/32/wget.exe"
set URLWget-x64="https://eternallybored.org/misc/wget/1.20.3/64/wget.exe"

rem ���室�� �� ��⥬�� ���
%SystemDrive%

REM ������ ����� ��� WGET
mkdir  "%ProgramFiles%\Wget\"

REM ���室�� � ᮧ������ �����
cd "%ProgramFiles%\Wget\"

If exist "%SystemDrive%\Program Files (x86)" (
		curl.exe -k -o "%ProgramFiles%\Wget\wget.exe" %URLWget-x64%
	) else (
		curl.exe -k -o "%ProgramFiles%\Wget\wget.exe" %URLWget%
	)

rem ������� ���� � wget � path
setx PATH "%PATH%;%ProgramFiles%\Wget" 
PATH=%PATH%;%ProgramFiles%\Wget

rem ������塞 �⨫��� wget.exe � �᪫�祭�� �࠭����� Windows
netsh advfirewall firewall del rule name="wget"
netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\Wget\wget.exe"

echo .
echo ��⠭���� Wget �����祭�
echo .

:ENDSUB

timeout 3 >> nul

EXIT /B
