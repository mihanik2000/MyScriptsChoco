@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: You must first run Curl-Install.bat, 7Zip-Install.bat and Wget-Install.bat
REM
REM Install Google Chrome
REM
REM ****************************************

REM Проверяем наличие у пользователя админских прав...
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

REM Задаём значения переменных
set MyFolder=%SystemRoot%\TMP\Mihanikus

set URLGoogleChrome="https://dl.google.com/tag/s/dl/chrome/install/GoogleChromeEnterpriseBundle.zip"
set URLGoogleChrome-x64="https://dl.google.com/tag/s/dl/chrome/install/GoogleChromeEnterpriseBundle64.zip"

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Google Chrome...
ECHO .

    If exist "%SystemDrive%\Program Files (x86)" (
        wget.exe --no-check-certificate -O "%MyFolder%\GoogleChromeEnterpriseBundle.zip" %URLGoogleChrome-x64%
     ) else (
        wget.exe --no-check-certificate -O "%MyFolder%\GoogleChromeEnterpriseBundle.zip" %URLGoogleChrome%
    )

    REM Распаковываем архив
    "%ProgramFiles%\7-Zip\7z.exe" x -y "%MyFolder%\GoogleChromeEnterpriseBundle.zip" -o"%MyFolder%\GoogleChrome"

    REM Переходим в папку с установщиком
    cd "%MyFolder%\GoogleChrome\Installers"

    REM Устанавливаем Google Chrome
    If exist "%SystemDrive%\Program Files (x86)" (
        Start /wait GoogleChromeStandaloneEnterprise64.msi /passive /norestart
     ) else (
        Start /wait GoogleChromeStandaloneEnterprise.msi /passive /norestart
    )

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
