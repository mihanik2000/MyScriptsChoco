@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: YES
REM
REM ����ந� ����������� ����������� �� RDP
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

rem ����稬 ����������� �ᯮ�짮����� RDP
echo ����稬 ����������� �ᯮ�짮����� RDP
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
     
rem ����稬 ����������� �ᯮ�짮����� � 㤠�񭭮�� ����魨��
echo ����稬 ����������� �ᯮ�짮����� � 㤠�񭭮�� ����魨��
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 1 /f

rem ����ந� �᪫�祭�� ����⥢��� �࠭� ��� RDP
echo ����ந� �᪫�祭�� ����⥢��� �࠭� ��� RDP

netsh advfirewall firewall delete rule name="AllowRDP"
netsh advfirewall firewall delete protocol=TCP localport=3389

netsh advfirewall firewall add rule name="AllowRDP" protocol="TCP" localport=3389 action=allow dir=IN

Rem 㪠��� ०�� ����᪠ �㦡� RDP  � auto
echo ����ந� ����� �㦡� RDP
sc config TermService start= auto

rem �����⨬ �㦡� RDP
net start TermService

:ENDSUB

timeout 3 >> nul

EXIT /B
