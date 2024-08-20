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
REM Install Duplicati 2
REM
REM ****************************************

REM �஢��塞 ����稥 � ���짮��⥫� �����᪨� �ࠢ...
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

REM ����� ���祭�� ��६�����
set MyFolder=%SystemRoot%\TMP\Mihanikus

set URLduplicati="https://updates.duplicati.com/beta/duplicati-2.0.5.1_beta_2020-01-18-x86.msi"
set URLduplicati-x64="https://updates.duplicati.com/beta/duplicati-2.0.5.1_beta_2020-01-18-x64.msi"

REM ���室�� �� ��⥬�� ���
%SystemDrive%

REM ������ ����� ��� �࠭���� ����ਡ�⨢�� � ���室�� � ���
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Duplicati 2...
ECHO .

    If exist "%SystemDrive%\Program Files (x86)" (
        wget.exe --no-check-certificate -O "%MyFolder%\duplicati-x64.msi" %URLduplicati-x64%
        Start /wait duplicati-x64.msi /passive /norestart
     ) else (
        wget.exe --no-check-certificate -O "%MyFolder%\duplicati-x86.msi" %URLduplicati%
        Start /wait duplicati-x86.msi  /passive /norestart
    )

REM �᪫�祭�� �⥢��� �࠭� ��� Duplicati
netsh advfirewall firewall del rule name="Duplicati"
netsh firewall del portopening tcp 8200
netsh advfirewall firewall add rule name="Duplicati" protocol="TCP" localport=8200 action=allow dir=IN
netsh firewall set portopening tcp 8200 Duplicati enable

REM ��⠭���� � �����⨬ �㦡� Duplicati
"%ProgramFiles%\Duplicati 2\Duplicati.WindowsService.exe" install
sc start Duplicati

REM ������ ��譨� ��모
del /q /s "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Duplicati 2.lnk"

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
