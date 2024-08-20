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

REM Добавляем мой репозиторий choco

choco source add --name=mihanikus --source=http://choco.mihanik.net/chocolatey

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
choco install 7zip -y
CALL "%ScriptPath%\ProgramManagement\7Zip-associate.bat"

REM Настроим возможность подключаться по RDP
CALL "%ScriptPath%\WindowsServices\EnableRDPService.bat"

REM Установим RDP Wrapper
CALL "%ScriptPath%\ProgramManagement\RDPWrapper.bat"

REM Установим dotNetFx3.5
CALL "%ScriptPath%\ProgramManagement\dotNetFx3.5-install.bat"

REM Установим dotNetFx4.8
REM Не устанавливаем, т.к. это было установлено во время установки choco
REM CALL "%ScriptPath%\ProgramManagement\dotNetFx4.8-install.bat"

REM Установим Duplicati 2
CALL "%ScriptPath%\ProgramManagement\Duplicati-Install.bat"

REM Установим LibreOffice
choco install libreoffice-fresh -y

REM Установим Java SE Runtime Environment
choco install javaruntime -y

REM Установим Unreal Commander
choco install unreal-commander -y

REM Установим Notepad++
choco install notepadplusplus -y

REM Установим Google Chrome
choco install GoogleChrome -y

REM Установим Firefox
choco install Firefox -y

REM Установим Thunderbird
choco install thunderbird -y

REM Установим LiteManager Pro
CALL "%ScriptPath%\ProgramManagement\LiteManager-Install.bat"

REM Установим Adobe Acrobat Reader
choco install adobereader -y

REM Установим K-Lite_Codec_Pack
choco install k-litecodecpackmega -y

REM Установим AIMP
choco install aimp -y

REM Установим yandex.browser
choco install yandex.browser --source mihanikus -y

    ECHO .
    ECHO Всё!
    ECHO .

:END

timeout 5  >> nul

REM shutdown -r -f -t 00

EXIT /B
