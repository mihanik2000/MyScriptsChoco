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
REM Install Notepad++
REM 
REM Репозиторий программы http://download.notepad-plus-plus.org/repository/8.x/
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

set URLNotepad="http://download.notepad-plus-plus.org/repository/8.x/8.6.4/npp.8.6.4.Installer.exe"
set URLNotepad-x64="http://download.notepad-plus-plus.org/repository/8.x/8.6.4/npp.8.6.4.Installer.x64.exe"

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

ECHO .
ECHO Install Notepad++...
ECHO .

    If exist "%SystemDrive%\Program Files (x86)" (
        wget.exe --no-check-certificate -O "%MyFolder%\npp-x64.exe" %URLNotepad-x64%
        Start /wait npp-x64.exe /S
     ) else (
        wget.exe --no-check-certificate -O "%MyFolder%\npp.exe" %URLNotepad%
        Start /wait npp.exe /S
    )

:ENDSUB

echo .
echo Done!
echo .

timeout 3 >> nul

EXIT /B
