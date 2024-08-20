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
REM Install Java SE Runtime Environment
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

set URLjre="http://repo.mihanik.net/Java/jre-8u241-windows-i586.exe"
set URLjre-x64="http://repo.mihanik.net/Java/jre-8u241-windows-x64.exe"

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Java SE Runtime Environment...
ECHO .

	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\jre-x64.exe" %URLjre-x64%
		Start /wait jre-x64.exe	 /s
	) else (
		wget.exe --no-check-certificate -O "%MyFolder%\jre.exe" %URLjre%
		Start /wait jre.exe	 /s
	)

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
