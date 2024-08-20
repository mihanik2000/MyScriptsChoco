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
REM Install Adobe Acrobat Reader
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

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Adobe Acrobat Reader...
ECHO .

    wget.exe --no-check-certificate -O "%MyFolder%\AcroRdrDC1900820071_ru_RU_win.exe" "http://repo.mihanik.net/Adobe_Acrobat_Reader/AcroRdrDC1900820071_ru_RU.exe"
    Start /wait AcroRdrDC1900820071_ru_RU_win.exe /sPB

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
