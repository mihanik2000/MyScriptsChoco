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
REM Install LibreOffice
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

set URLLibreOffice="https://mirror.truenetwork.ru/tdf/libreoffice/stable/7.6.5/win/x86/LibreOffice_7.6.5_Win_x86.msi"

set URLLibreOffice-x64="https://mirror.truenetwork.ru/tdf/libreoffice/stable/7.6.5/win/x86_64/LibreOffice_7.6.5_Win_x86-64.msi"

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install LibreOffice...
ECHO .

    If exist "%SystemDrive%\Program Files (x86)" (
        wget.exe --no-check-certificate -O "%MyFolder%\LibreOffice_x64.msi" %URLLibreOffice-x64%
        Start /wait LibreOffice_x64.msi  /passive /norestart
        rem wget.exe --no-check-certificate -O "%MyFolder%\LibreOffice_x64_helppack_ru.msi" %URLLibreOffice-helppack-x64%
        rem Start /wait LibreOffice_x64_helppack_ru.msi  /passive /norestart
    ) else (
        wget.exe --no-check-certificate -O "%MyFolder%\LibreOffice_x86.msi" %URLLibreOffice%
        Start /wait LibreOffice_x86.msi  /passive /norestart
        rem wget.exe --no-check-certificate -O "%MyFolder%\LibreOffice_x86_helppack_ru.msi" %URLLibreOffice-helppack%
        rem Start /wait LibreOffice_x86_helppack_ru.msi /passive /norestart
    )

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
