@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM		   Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM						   Dependencies: No
REM
REM Uninstall One Drive
REM
REM ****************************************

rem ****************************************************************************************
rem Проверяем наличие у пользователя админских прав...
rem ****************************************************************************************

SET HasAdminRights=0
FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
	IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
	ECHO .
	ECHO You need administrator rights to run!!!
	ECHO .
	GOTO ENDSUB
)

rem ****************************************************************************************
rem Удаляем One Drive
rem ****************************************************************************************

ECHO .
ECHO Удаляем One Drive...
ECHO .

taskkill /f /im OneDrive.exe
	If exist "%SystemDrive%\Program Files (x86)" (
		start "Uninstall One Drive..." /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
	 ) else (
 		start "Uninstall One Drive..." /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
 	)

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B

