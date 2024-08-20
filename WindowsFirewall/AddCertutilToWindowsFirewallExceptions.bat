@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: NO

REM
REM Добавляем утилиту certutil.exe в исключения межсетевого экрана Windows
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

REM Добавляем утилиту certutil.exe в исключения межсетевого экрана Windows

netsh advfirewall firewall delete rule name="Certutil"
netsh advfirewall firewall add rule name="Certutil" dir=in action=allow program="C:\Windows\System32\certutil.exe"

:ENDSUB

timeout 3 >> nul

EXIT /B
