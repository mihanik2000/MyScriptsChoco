@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: YES
REM
REM Настроим возможность подключаться по RDP
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

rem Включим возможность использования RDP
echo Включим возможность использования RDP
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
     
rem Включим возможность использования и удалённого помощника
echo Включим возможность использования и удалённого помощника
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 1 /f

rem Настроим исключения межсетевого экрана для RDP
echo Настроим исключения межсетевого экрана для RDP

netsh advfirewall firewall delete rule name="AllowRDP"
netsh advfirewall firewall delete protocol=TCP localport=3389

netsh advfirewall firewall add rule name="AllowRDP" protocol="TCP" localport=3389 action=allow dir=IN

Rem укажем режим запуска службы RDP  в auto
echo Настроим запуск службы RDP
sc config TermService start= auto

rem Запустим службу RDP
net start TermService

:ENDSUB

timeout 3 >> nul

EXIT /B
