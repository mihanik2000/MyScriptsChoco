@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM		   Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM						   Dependencies: You must first run Curl-Install.bat and Wget-Install.bat
REM
REM Install Thunderbird
REM
REM ****************************************

REM Проверяем наличие у пользователя админских прав...
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

REM Задаём значения переменных
set MyFolder=%SystemRoot%\TMP\Mihanikus

set URLthunderbird="https://download.mozilla.org/?product=thunderbird-msi-latest-ssl&os=win&lang=ru"
set URLthunderbird-x64="https://download.mozilla.org/?product=thunderbird-msi-latest-ssl&os=win64&lang=ru"

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Thunderbird...
ECHO .

	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\ThunderbirdSetup.msi" %URLthunderbird-x64%
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\ThunderbirdSetup.msi %URLthunderbird%
 	)
	
	Start /wait ThunderbirdSetup.msi /passive /norestart

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
