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
REM ������塞 �⨫��� certutil.exe � �᪫�祭�� ����⥢��� �࠭� Windows
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

REM ������塞 �⨫��� certutil.exe � �᪫�祭�� ����⥢��� �࠭� Windows

netsh advfirewall firewall delete rule name="Certutil"
netsh advfirewall firewall add rule name="Certutil" dir=in action=allow program="C:\Windows\System32\certutil.exe"

:ENDSUB

timeout 3 >> nul

EXIT /B
