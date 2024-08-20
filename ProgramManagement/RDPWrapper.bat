@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM        Require administrator rights: YES
REM Antivirus software must be disabled: Not necessary
REM                        Dependencies: wget, 7-Zip
REM
REM Описание
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

REM Задаём значения переменных
set RDPWrapper="https://github.com/stascorp/rdpwrap/releases/download/v1.6.2/RDPWrap-v1.6.2.zip"
set RDPWrapperIni="https://raw.githubusercontent.com/sebaxakerhtc/rdpwrap.ini/master/rdpwrap.ini"
set MyFolder=%SystemRoot%\TMP\Mihanikus

REM Переходим на системный диск
%SystemDrive%

REM Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%" >> nul
cd "%MyFolder%"

REM Создаём папку для RDP Wrapper
MkDir "%ProgramFiles%\RDP Wrapper"

REM Задаём исключения для Windows Defender
powershell -command "Add-MpPreference -ExclusionPath \"$env:SystemRoot\TMP\Mihanikus\RDPWrap.zip\""
powershell -command "Add-MpPreference -ExclusionPath \"$env:SystemRoot\TMP\Mihanikus\RDPWrap\""
powershell -command "Add-MpPreference -ExclusionPath \"$env:SystemRoot\TMP\Mihanikus\RDPWrap\RDPCheck.exe\""
powershell -command "Add-MpPreference -ExclusionPath \"$env:SystemRoot\TMP\Mihanikus\RDPWrap\RDPConf.exe\""
powershell -command "Add-MpPreference -ExclusionPath \"$env:SystemRoot\TMP\Mihanikus\RDPWrap\RDPWInst.exe\""

powershell -command "Add-MpPreference -ExclusionPath \"$env:ProgramFiles\RDP Wrapper\""
powershell -command "Add-MpPreference -ExclusionPath \"$env:ProgramFiles\RDP Wrapper\rdpwrap.dll\""
powershell -command "Add-MpPreference -ExclusionPath \"$env:ProgramFiles\RDP Wrapper\rdpwrap.ini\""

REM Скачиваем RDP Wrapper
"%ProgramFiles%\Wget\wget.exe" --no-check-certificate -O "%MyFolder%\RDPWrap.zip" %RDPWrapper%

REM Распаковываем RDP Wrapper
"%ProgramFiles%\7-Zip\7z.exe" x -y  "%MyFolder%\RDPWrap.zip" -o"%MyFolder%\RDPWrap"

REM Устанавливаем RDP Wrapper
"%SystemRoot%\TMP\Mihanikus\RDPWrap\RDPWInst.exe" -i -o

REM Останавливаем службу удалённых столов
rem powershell -command "Stop-Service termservice -Force"
net stop UmRdpService
net stop TermService

REM Подгружаем конфигурационный файл
"%ProgramFiles%\Wget\wget.exe" --no-check-certificate -O "%ProgramFiles%\RDP Wrapper\rdpwrap.ini" %RDPWrapperIni%

REM Запускаем службу удалённых столов
rem powershell -command "Start-Service termservice -Force"
net start TermService
net start UmRdpService

:ENDSUB

timeout 3 >> nul

EXIT /B
