@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: No
REM
REM Описание
REM https://habr.com/ru/companies/pt/articles/264763/
REM https://habr.com/ru/articles/267507/
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
echo Блокируем телеметрию Microsoft.
echo .

sc stop DiagTrack
sc config DiagTrack start= disabled

sc stop dmwappushservice
sc config dmwappushservice start= disabled

(echo 127.0.0.1       vortex.data.microsoft.com
echo 127.0.0.1       vortex-win.data.microsoft.com
echo 127.0.0.1       telecommand.telemetry.microsoft.com
echo 127.0.0.1       telecommand.telemetry.microsoft.com.nsatc.net
echo 127.0.0.1       oca.telemetry.microsoft.com
echo 127.0.0.1       oca.telemetry.microsoft.com.nsatc.net
echo 127.0.0.1       sqm.telemetry.microsoft.com
echo 127.0.0.1       sqm.telemetry.microsoft.com.nsatc.net
echo 127.0.0.1       watson.telemetry.microsoft.com
echo 127.0.0.1       watson.telemetry.microsoft.com.nsatc.net
echo 127.0.0.1       redir.metaservices.microsoft.com
echo 127.0.0.1       choice.microsoft.com
echo 127.0.0.1       choice.microsoft.com.nsatc.net
echo 127.0.0.1       df.telemetry.microsoft.com
echo 127.0.0.1       reports.wes.df.telemetry.microsoft.com
echo 127.0.0.1       wes.df.telemetry.microsoft.com
echo 127.0.0.1       services.wes.df.telemetry.microsoft.com
echo 127.0.0.1       sqm.df.telemetry.microsoft.com
echo 127.0.0.1       telemetry.microsoft.com
echo 127.0.0.1       watson.ppe.telemetry.microsoft.com
echo 127.0.0.1       telemetry.appex.bing.net
echo 127.0.0.1       telemetry.urs.microsoft.com
echo 127.0.0.1       telemetry.appex.bing.net:443
echo 127.0.0.1       settings-sandbox.data.microsoft.com
echo 127.0.0.1       vortex-sandbox.data.microsoft.com
echo 127.0.0.1       survey.watson.microsoft.com
echo 127.0.0.1       watson.live.com
echo 127.0.0.1       watson.microsoft.com
echo 127.0.0.1       statsfe2.ws.microsoft.com
echo 127.0.0.1       corpext.msitadfs.glbdns2.microsoft.com
echo 127.0.0.1       compatexchange.cloudapp.net
echo 127.0.0.1       cs1.wpc.v0cdn.net
echo 127.0.0.1       a-0001.a-msedge.net
echo 127.0.0.1       statsfe2.update.microsoft.com.akadns.net
echo 127.0.0.1       sls.update.microsoft.com.akadns.net
echo 127.0.0.1       fe2.update.microsoft.com.akadns.net
echo 127.0.0.1       diagnostics.support.microsoft.com
echo 127.0.0.1       corp.sts.microsoft.com
echo 127.0.0.1       statsfe1.ws.microsoft.com
echo 127.0.0.1       pre.footprintpredict.com
echo 127.0.0.1       i1.services.social.microsoft.com
echo 127.0.0.1       i1.services.social.microsoft.com.nsatc.net
echo 127.0.0.1       feedback.windows.com
echo 127.0.0.1       feedback.microsoft-hohm.com
echo 127.0.0.1       feedback.search.microsoft.com
echo 127.0.0.1       rad.msn.com
echo 127.0.0.1       preview.msn.com
echo 127.0.0.1       ad.doubleclick.net
echo 127.0.0.1       ads.msn.com
echo 127.0.0.1       ads1.msads.net
echo 127.0.0.1       ads1.msn.com
echo 127.0.0.1       a.ads1.msn.com
echo 127.0.0.1       a.ads2.msn.com
echo 127.0.0.1       adnexus.net
echo 127.0.0.1       adnxs.com
echo 127.0.0.1       az361816.vo.msecnd.net
echo 127.0.0.1       az512334.vo.msecnd.net
echo 127.0.0.1       ssw.live.com) >> %SystemRoot%\System32\drivers\etc\hosts

REM *** Task that collects data for SmartScreen in Windows ***
schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable

REM *** Collects program telemetry information if opted-in to the Microsoft Customer Experience Improvement Program ***
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable

REM *** Collects program telemetry information if opted-in to the Microsoft Customer Experience Improvement Program ***
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable

REM *** Aggregates and uploads Application Telemetry information if opted-in to the Microsoft Customer Experience Improvement Program ***
schtasks /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Disable

REM *** This task collects and uploads autochk SQM data if opted-in to the Microsoft Customer Experience Improvement Program ***
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable

REM *** If the user has consented to participate in the Windows Customer Experience Improvement Program, this job collects and sends usage data to Microsoft ***
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable

REM *** The Kernel CEIP (Customer Experience Improvement Program) task collects additional information about the system and sends this data to Microsoft. *** 
REM *** If the user has not consented to participate in Windows CEIP, this task does nothing ***
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable

REM *** The Bluetooth CEIP (Customer Experience Improvement Program) task collects Bluetooth related statistics and information about your machine and sends it to Microsoft ***
REM *** The information received is used to help improve the reliability, stability, and overall functionality of Bluetooth in Windows ***
REM *** If the user has not consented to participate in Windows CEIP, this task does not do anything.***
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable

REM *** Create Object Task ***
schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable

REM *** The Windows Disk Diagnostic reports general disk and system information to Microsoft for users participating in the Customer Experience Program ***
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable

REM *** Measures a system's performance and capabilities ***
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable

REM *** Network information collector ***
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable

REM *** Initializes Family Safety monitoring and enforcement ***
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable

REM *** Synchronizes the latest settings with the Family Safety website ***
schtasks /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable

REM *** SQM (Software Quality Management) ***
schtasks /Change /TN "Microsoft\Windows\IME\SQM data sender" /Disable

REM *** This task initiates the background task for Office Telemetry Agent, which scans and uploads usage and error information for Office solutions ***
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable

REM *** This task initiates Office Telemetry Agent, which scans and uploads usage and error information for Office solutions when a user logs on to the computer ***
schtasks /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable

REM *** Scans startup entries and raises notification to the user if there are too many startup entries ***
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable

REM *** Protects user files from accidental loss by copying them to a backup location when the system is unattended ***
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable

REM *** This task gathers information about the Trusted Platform Module (TPM), Secure Boot, and Measured Boot ***
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable

REM *** This task analyzes the system looking for conditions that may cause high energy use ***
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable

echo Ok!
echo .

:ENDSUB

timeout 3 >> nul

EXIT /B
