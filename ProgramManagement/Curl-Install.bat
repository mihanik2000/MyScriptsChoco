@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: YES (!!!)
REM
REM Install curl
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
echo ��⠭�������� CURL
echo .

REM ������ ����� ��� CURL
mkdir  "%ProgramFiles%\Curl\"

REM ����砥� ��� �����, � ���ன �ᯮ����� �ਯ� � ���室�� � ��� �����
set CurlScriptPath=%~dp0
cd  %CurlScriptPath%

REM ���稢��� CURL
If exist "%SystemDrive%\Program Files (x86)" (
	copy /y "..\Distr\curl\win64\libcurl-x64.dll" "%ProgramFiles%\curl\libcurl-x64.dll"
	copy /y "..\Distr\curl\win64\curl.exe" "%ProgramFiles%\curl\curl.exe"
	copy /y "..\Distr\curl\win64\curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	copy /y "..\Distr\curl\win64\libcurl-x64.def" "%ProgramFiles%\curl\libcurl-x64.def"
 ) else (
 	copy /y "..\Distr\curl\win32\libcurl.dll" "%ProgramFiles%\curl\libcurl.dll"
	copy /y "..\Distr\curl\win32\curl.exe" "%ProgramFiles%\curl\curl.exe"
	copy /y "..\Distr\curl\win32\curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	copy /y "..\Distr\curl\win32\libcurl.def" "%ProgramFiles%\curl\libcurl.def"
)

rem ��⠭���� ᪠砭�� ���䨪�� ��� ��� ���짮��⥫��
certutil -f -addstore "My" "%ProgramFiles%\curl\curl-ca-bundle.crt"

rem ������� ���� � curl � path
setx PATH "%PATH%;%ProgramFiles%\curl" 
PATH=%PATH%;%ProgramFiles%\curl

rem ������塞 �⨫��� curl.exe � �᪫�祭�� �࠭����� Windows
netsh advfirewall firewall del rule name="curl"
netsh advfirewall firewall add rule name="curl" dir=in action=allow program="%ProgramFiles%\Curl\curl.exe"

echo .
echo ��⠭���� CURL �����祭�
echo .

:ENDSUB

timeout 3 >> nul

EXIT /B
