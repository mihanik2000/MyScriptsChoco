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
REM Uninstall Edge Chromium
REM
REM ****************************************

rem ****************************************************************************************
rem �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
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

ECHO .
ECHO ����塞 Edge Chromium...
ECHO .

 If exist "%programfiles(x86)%" (
		cd "%SystemDrive%\Program Files (x86)\Microsoft\Edge\Application"
	) else (
		cd "%SystemDrive%\Program Files\Microsoft\Edge\Application"
	)

dir /b | findstr [0-9] > ver.txt
SET /p myvar= < ver.txt
cd %myvar%\Installer
setup.exe -uninstall -system-level -verbose-logging -force-uninstall

timeout 10 >> nul

Rem ����⨬ � ���쭥�襬 ᮧ������ ��� ��� Microsoft Edge �� ࠡ�祬 �⮫�
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer /v "DisableEdgeDesktopShortcutCreation" /t REG_DWORD /d "1" /f

rem ����頥� ����������� �� Edge Chromium
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B

