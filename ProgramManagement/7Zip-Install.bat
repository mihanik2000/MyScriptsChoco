@echo off
REM ****************************************
REM check
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: You must first run Curl-Install.bat and Wget-Install.bat
REM
REM Install 7-Zip
REM
REM ****************************************

rem Проверяем наличие у пользователя админских прав...
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
set URL7Zip="https://www.7-zip.org/a/7z2401.msi"
set URL7Zip-x64="https://www.7-zip.org/a/7z2401-x64.msi"
set MyFolder=%SystemRoot%\TMP\Mihanikus

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install 7-Zip...
ECHO .
 If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\7z-x64.msi" %URL7Zip-x64%
		start /wait 7z-x64.msi /passive /norestart
	) else (
		wget.exe --no-check-certificate -O "%MyFolder%\7z.msi" %URL7Zip%
		start /wait 7z.msi /passive /norestart
	)

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
