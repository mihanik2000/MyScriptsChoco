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
set URLndp48="https://go.microsoft.com/fwlink/?linkid=2088631"
REM set URLndp48="http://choco.mihanik.net/distr/repo/Microsoft/Microsoft_NET/ndp48-x86-x64-allos-enu.exe"
set MyFolder=%SystemRoot%\TMP\Mihanikus

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
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
