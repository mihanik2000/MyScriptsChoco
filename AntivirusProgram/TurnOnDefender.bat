@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: YES
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

REM Включим защитника Windows через реестр
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 0 /f

REM Включим защитника Windows через powershell
powershell -command "Set-MpPreference -DisableArchiveScanning $false"
powershell -command "Set-MpPreference -DisableAutoExclusions $false"
powershell -command "Set-MpPreference -DisableBehaviorMonitoring $false"
powershell -command "Set-MpPreference -DisableBlockAtFirstSeen $false"
powershell -command "Set-MpPreference -DisableIOAVProtection $false"
powershell -command "Set-MpPreference -DisablePrivacyMode $false"
powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"
powershell -command "Set-MpPreference -DisableScanningNetworkFiles $false"
powershell -command "Set-MpPreference -DisableScriptScanning $false"
powershell -command "Set-MpPreference -DisableRealtimeMonitoring $false"

:CONTINUE
	ECHO .
	ECHO Сейчас будет выполнена перезагрузка!!!
	ECHO .

shutdown -r -f -t 5

:ENDSUB

timeout 5 > nul

EXIT /B
