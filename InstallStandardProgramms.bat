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
REM Скрипт установки стандартного пакета программ с моего репозитория
REM
REM ****************************************

REM Устанавливаем значение некоторых переменных

REM Получаем имя папки, в которой расположен скрипт
set ScriptPath=%~dp0

REM Папка для временного хранения установичных или скачанных файлов
set MyFolder=%SystemRoot%\TMP\Mihanikus

REM Проверяем наличие у пользователя админских прав...
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

REM Включение режима электропитания "Высокая производительность"
CALL "%ScriptPath%\Powercfg\EnableHighPerformance.bat"

REM Отключаем спящий режим
CALL "%ScriptPath%\Powercfg\DisableHibernation

REM Настраиваем учётные записи пользователей на компьютере
CALL "%ScriptPath%\UserManagement\SettingUpUserAccounts.bat"

REM Запланируем ежедневное выключение в полночь
CALL "%ScriptPath%\WindowsScheduler\EnableDailyShutdown.bat"

REM Выполняем минимальную настройку межсетевого экрана
CALL "%ScriptPath%\WindowsFirewall\InitialFirewallSetup.bat"

REM Заблокируем телеметрию Windows
CALL "%ScriptPath%\WindowsFirewall\BlockMicrosoftTelemetry.bat"

REM Добавляем утилиту certutil.exe в исключения межсетевого экрана Windows
CALL "%ScriptPath%\WindowsFirewall\AddCertutilToWindowsFirewallExceptions.bat"

REM Установим Curl
CALL "%ScriptPath%\ProgramManagement\Curl-Install.bat"

REM Установим Wget
CALL "%ScriptPath%\ProgramManagement\Wget-Install.bat"

REM Установим 7Zip
CALL "%ScriptPath%\ProgramManagement\7Zip-Install.bat"
CALL "%ScriptPath%\ProgramManagement\7Zip-associate.bat"

REM Настроим возможность подключаться по RDP
CALL "%ScriptPath%\WindowsServices\EnableRDPService.bat"

REM Установим RDP Wrapper
CALL "%ScriptPath%\ProgramManagement\RDPWrapper.bat"

REM Установим dotNetFx3.5
CALL "%ScriptPath%\ProgramManagement\dotNetFx3.5-install.bat"

REM Установим dotNetFx4.8
CALL "%ScriptPath%\ProgramManagement\dotNetFx4.8-install.bat"

REM Установим Duplicati 2
CALL "%ScriptPath%\ProgramManagement\Duplicati-Install.bat"

REM Установим LibreOffice
CALL "%ScriptPath%\ProgramManagement\LibreOffice-Install.bat"

REM Установим Java SE Runtime Environment
CALL "%ScriptPath%\ProgramManagement\JavaRE-Install.bat"

REM Установим Unreal Commander
CALL "%ScriptPath%\ProgramManagement\UnrealCommander-Install.bat"

REM Установим Notepad++
CALL "%ScriptPath%\ProgramManagement\Notepad++-Install.bat"

REM Установим Google Chrome
CALL "%ScriptPath%\ProgramManagement\GoogleChrome-Install.bat"

REM Установим Firefox
CALL "%ScriptPath%\ProgramManagement\Firefox-Install.bat"

REM Установим Thunderbird
CALL "%ScriptPath%\ProgramManagement\Thunderbird-Install.bat"

REM Установим LiteManager Pro
CALL "%ScriptPath%\ProgramManagement\LiteManager-Install.bat"

REM Установим Adobe Acrobat Reader
CALL "%ScriptPath%\ProgramManagement\AcrobatReader-Install.bat"

REM Установим K-Lite_Codec_Pack
CALL "%ScriptPath%\ProgramManagement\KLiteCodecPack-Install.bat"

REM Установим AIMP
CALL "%ScriptPath%\ProgramManagement\AIMP-Install.bat"

    ECHO .
    ECHO Всё!
    ECHO .

:END

timeout 5  >> nul

REM shutdown -r -f -t 00

EXIT /B
