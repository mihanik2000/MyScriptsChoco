@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: YES (!!!)
REM
REM ��ਯ� ��⠭���� �⠭���⭮�� ����� �ணࠬ� � ����� ९������
REM
REM ****************************************

REM ������塞 ��� ९����਩ choco

choco source add --name=mihanikus --source=http://choco.mihanik.net/chocolatey

REM ��⠭�������� ���祭�� �������� ��६�����

REM ����砥� ��� �����, � ���ன �ᯮ����� �ਯ�
set ScriptPath=%~dp0

REM ����� ��� �६������ �࠭���� ��⠭������ ��� ᪠砭��� 䠩���
set MyFolder=%SystemRoot%\TMP\Mihanikus

REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
SET HasAdminRights=0

FOR /F %%i IN ('WHOAMI /PRIV /NH') DO (
    IF "%%i"=="SeTakeOwnershipPrivilege" SET HasAdminRights=1
)

IF NOT %HasAdminRights%==1 (
    ECHO .
    ECHO You need administrator rights to run!!!
    ECHO .
    GOTO END
)

REM ����祭�� ०��� ���ய�⠭�� "��᮪�� �ந�����⥫쭮���"
CALL "%ScriptPath%\Powercfg\EnableHighPerformance.bat"

REM �⪫�砥� ��騩 ०��
CALL "%ScriptPath%\Powercfg\DisableHibernation

REM ����ࠨ���� ����� ����� ���짮��⥫�� �� ��������
CALL "%ScriptPath%\UserManagement\SettingUpUserAccounts.bat"

REM ��������㥬 ���������� �몫�祭�� � �������
CALL "%ScriptPath%\WindowsScheduler\EnableDailyShutdown.bat"

REM �믮��塞 ���������� ����ன�� ����⥢��� �࠭�
CALL "%ScriptPath%\WindowsFirewall\InitialFirewallSetup.bat"

REM ��������㥬 ⥫������ Windows
CALL "%ScriptPath%\WindowsFirewall\BlockMicrosoftTelemetry.bat"

REM ������塞 �⨫��� certutil.exe � �᪫�祭�� ����⥢��� �࠭� Windows
CALL "%ScriptPath%\WindowsFirewall\AddCertutilToWindowsFirewallExceptions.bat"

REM ��⠭���� Curl
CALL "%ScriptPath%\ProgramManagement\Curl-Install.bat"

REM ��⠭���� Wget
CALL "%ScriptPath%\ProgramManagement\Wget-Install.bat"

REM ��⠭���� 7Zip
choco install 7zip -y
CALL "%ScriptPath%\ProgramManagement\7Zip-associate.bat"

REM ����ந� ����������� ����������� �� RDP
CALL "%ScriptPath%\WindowsServices\EnableRDPService.bat"

REM ��⠭���� RDP Wrapper
CALL "%ScriptPath%\ProgramManagement\RDPWrapper.bat"

REM ��⠭���� dotNetFx3.5
CALL "%ScriptPath%\ProgramManagement\dotNetFx3.5-install.bat"

REM ��⠭���� dotNetFx4.8
REM �� ��⠭��������, �.�. �� �뫮 ��⠭������ �� �६� ��⠭���� choco
REM CALL "%ScriptPath%\ProgramManagement\dotNetFx4.8-install.bat"

REM ��⠭���� Duplicati 2
CALL "%ScriptPath%\ProgramManagement\Duplicati-Install.bat"

REM ��⠭���� LibreOffice
choco install libreoffice-fresh -y

REM ��⠭���� Java SE Runtime Environment
choco install javaruntime -y

REM ��⠭���� Unreal Commander
choco install unreal-commander -y

REM ��⠭���� Notepad++
choco install notepadplusplus -y

REM ��⠭���� Google Chrome
choco install GoogleChrome -y

REM ��⠭���� Firefox
choco install Firefox -y

REM ��⠭���� Thunderbird
choco install thunderbird -y

REM ��⠭���� LiteManager Pro
CALL "%ScriptPath%\ProgramManagement\LiteManager-Install.bat"

REM ��⠭���� Adobe Acrobat Reader
choco install adobereader -y

REM ��⠭���� K-Lite_Codec_Pack
choco install k-litecodecpackmega -y

REM ��⠭���� AIMP
choco install aimp -y

REM ��⠭���� yandex.browser
choco install yandex.browser --source mihanikus -y

    ECHO .
    ECHO ���!
    ECHO .

:END

timeout 5  >> nul

REM shutdown -r -f -t 00

EXIT /B
