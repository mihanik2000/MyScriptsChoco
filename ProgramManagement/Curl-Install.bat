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
REM Install curl
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

echo .
echo Устанавливаем CURL
echo .

REM Создаём папку для CURL
mkdir  "%ProgramFiles%\Curl\"

REM Получаем имя папки, в которой расположен скрипт и переходим в эту папку
set CurlScriptPath=%~dp0
cd  %CurlScriptPath%

REM Скачиваем CURL
If exist "%SystemDrive%\Program Files (x86)" (
	copy /y "..\Distr\curl\win64\libcurl-x64.dll" "%ProgramFiles%\curl\libcurl-x64.dll"
	copy /y "..\Distr\curl\win64\curl.exe" "%ProgramFiles%\curl\curl.exe"
	copy /y "..\Distr\curl\win64\curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	copy /y "..\Distr\curl\win64\libcurl-x64.def" "%ProgramFiles%\curl\libcurl-x64.def"
 ) else (
 	copy /y "..\Distr\curl\win32\libcurl.dll" "%ProgramFiles%\curl\libcurl.dll"
	copy /y "..\Distr\curl\win32\curl.exe" "%ProgramFiles%\curl\curl.exe"
	copy /y "..\Distr\curl\win32\curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	copy /y "..\Distr\curl\win32\libcurl.def" "%ProgramFiles%\curl\libcurl.def"
)

rem Установим скачанный сертификат для всех пользователей
certutil -f -addstore "My" "%ProgramFiles%\curl\curl-ca-bundle.crt"

rem Добавим путь к curl в path
setx PATH "%PATH%;%ProgramFiles%\curl" 
PATH=%PATH%;%ProgramFiles%\curl

rem Добавляем утилиту curl.exe в исключения брандмауера Windows
netsh advfirewall firewall del rule name="curl"
netsh advfirewall firewall add rule name="curl" dir=in action=allow program="%ProgramFiles%\Curl\curl.exe"

echo .
echo Установка CURL закончена
echo .

:ENDSUB

timeout 3 >> nul

EXIT /B
