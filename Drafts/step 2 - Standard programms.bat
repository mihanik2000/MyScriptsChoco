@echo off

Rem Скрипт установки стандартного пакета программ с моего репозитория

rem Windows XP не поддерживается!!!
ver | find "5.1."

If %errorlevel%==0  (
	Echo Windows XP unsupported!!!
	Exit /b 1
 ) 

rem ****************************************************************************************
rem Проверяем наличие у пользователя админских прав...
rem ****************************************************************************************

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

rem ****************************************************************************************
rem Описываем переменные.
rem ****************************************************************************************
set MyFolder=%SystemRoot%\TMP\Mihanikus
set MyUserAgent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36"

set URL7Zip="https://www.7-zip.org/a/7z1900.msi"
set URL7Zip-x64="https://www.7-zip.org/a/7z1900-x64.msi"

set URLndp48="http://repo.mihanik.net/Microsoft/Microsoft_NET/ndp48-x86-x64-allos-enu.exe"
rem set URLndp48="https://go.microsoft.com/fwlink/?linkid=2088631"

set URLduplicati="https://updates.duplicati.com/beta/duplicati-2.0.5.1_beta_2020-01-18-x86.msi"
set URLduplicati-x64="https://updates.duplicati.com/beta/duplicati-2.0.5.1_beta_2020-01-18-x64.msi"

set URLjre="http://repo.mihanik.net/Java/jre-8u241-windows-i586.exe"
set URLjre-x64="http://repo.mihanik.net/Java/jre-8u241-windows-x64.exe"

set URLLibreOffice="http://libreoffice-mirror.rbc.ru/pub/libreoffice/libreoffice/stable/7.0.1/win/x86/LibreOffice_7.0.1_Win_x86.msi"
set URLLibreOffice-helppack="http://libreoffice-mirror.rbc.ru/pub/libreoffice/libreoffice/stable/7.0.1/win/x86/LibreOffice_7.0.1_Win_x86_helppack_ru.msi"

set URLLibreOffice-x64="http://libreoffice-mirror.rbc.ru/pub/libreoffice/libreoffice/stable/7.0.1/win/x86_64/LibreOffice_7.0.1_Win_x64.msi"
set URLLibreOffice-helppack-x64="http://libreoffice-mirror.rbc.ru/pub/libreoffice/libreoffice/stable/7.0.1/win/x86_64/LibreOffice_7.0.1_Win_x64_helppack_ru.msi"

set URLuncomsetup="https://unrealcommander.org/download/evolution/uncomsetup3.57(build1486).exe"

set URLGoogleChrome="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B5E813859-E748-6A1E-715A-14E59A2D35C5%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dstable-arch_x86-statsdef_0%26brand%3DGCEA/dl/chrome/install/googlechromestandaloneenterprise.msi"
set URLGoogleChrome-x64="https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B5E813859-E748-6A1E-715A-14E59A2D35C5%7D%26lang%3Den%26browser%3D3%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dtrue%26ap%3Dx64-stable-statsdef_0%26brand%3DGCEA/dl/chrome/install/googlechromestandaloneenterprise64.msi"

set URLSkype="https://download.skype.com/s4l/download/win/Skype-8.65.0.76.exe"

set URLNotepad="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9/npp.7.9.Installer.exe"
set URLNotepad-x64="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9/npp.7.9.Installer.x64.exe"

set URLthunderbird="https://download.mozilla.org/?product=thunderbird-78.3.2-SSL&os=win&lang=ru"
set URLthunderbird-x64="https://download.mozilla.org/?product=thunderbird-78.3.2-SSL&os=win64&lang=ru"

set URLFirefoxSetup="https://yandex.ru/firefox/download?from=lp_s"
set URLFirefoxSetup-x64="https://yandex.ru/firefox/download?from=lp_s"

set URLWget="https://eternallybored.org/misc/wget/1.20.3/32/wget.exe"
set URLWget-x64="https://eternallybored.org/misc/wget/1.20.3/64/wget.exe"

set URLaimp="https://www.aimp.ru/?do=download.file&id=4"

set URLKLite="https://files3.codecguide.com/K-Lite_Codec_Pack_1575_Mega.exe"

rem ****************************************************************************************
rem Настраиваем учётные записи пользователей на компьютере
rem ****************************************************************************************

rem активируем встроенного Админа
net user Администратор "AdminPass" /active:yes

rem Создадим пользователя user с паролем 321
net user user "321"  /add /expires:never

rem ****************************************************************************************
rem Настроим некоторые параметры необходимые для удалённого администрирования.
rem ****************************************************************************************

rem включим режим электропитания "Высокая производительность"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

Rem Отбражаем Мой компьютер
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

rem отключаем спящий режим
powercfg -hibernate off
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HiberFileSizePercent /t REG_DWORD /d 0 /f
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f

rem Запланируем ежедневное выключение в полночь
SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC DAILY /TN "Microsoft\Office\Office Shutdown" /TR  "\"C:\Windows\System32\shutdown.exe\" /s /f /t 00"  /ST 00:00 /RL HIGHEST

rem Включаем ADMIN шару
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t reg_sz /d 1 /f

rem Включим межсетевой экран
netsh advfirewall set allprofiles state on

rem Разрешим отвечать на ping 
netsh firewall set icmpsetting 8

rem ****************************************************************************************
rem Настроим возможность подключаться по RDP
rem ****************************************************************************************

rem Включим возможность использования RDP
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
     
rem Включим возможность использования и удалённого помощника
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fAllowToGetHelp /t REG_DWORD /d 1 /f

rem Исключение сетевого экрана для RDP
netsh advfirewall firewall del rule name="AlowRDP"
netsh firewall del portopening tcp 3389

netsh firewall set service remoteadmin enable
netsh firewall set service remotedesktop enable

netsh advfirewall firewall add rule name="AlowRDP" protocol="TCP" localport=3389 action=allow dir=IN
netsh firewall set portopening tcp 3389 AlowRDP enable 

Rem укажем режим запуска службы RDP  в auto
sc config TermService start= auto

rem Запустим службу RDP
net start TermService

rem Добавляем утилиту certutil.exe в исключения брандмауера Windows
netsh advfirewall firewall del rule name="Certutil"
netsh firewall add allowedprogram "C:\Windows\System32\certutil.exe" Certutil
netsh advfirewall firewall add rule name="Certutil" dir=in action=allow program="C:\Windows\System32\certutil.exe"

rem ****************************************************************************************
rem Начинаем устанавливать все программы по очереди
rem ****************************************************************************************

rem Переходим на системный диск
%SystemDrive%

rem Создаём папку для хранения дистрибутивов и переходим в неё
mkdir "%MyFolder%"
cd "%MyFolder%"

ECHO Install curl...
ECHO .
mkdir  "%ProgramFiles%\curl\"

If exist "%SystemDrive%\Program Files (x86)" (
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/libcurl-x64.dll" "%ProgramFiles%\curl\libcurl-x64.dll"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/curl.exe" "%ProgramFiles%\curl\curl.exe"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win64/libcurl-x64.def" "%ProgramFiles%\curl\libcurl-x64.def"

 ) else (
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/libcurl.dll" "%ProgramFiles%\curl\libcurl.dll"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/curl.exe" "%ProgramFiles%\curl\curl.exe"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/curl-ca-bundle.crt" "%ProgramFiles%\curl\curl-ca-bundle.crt"
	certutil -urlcache -split -f "http://repo.mihanik.net/curl/win32/libcurl.def" "%ProgramFiles%\curl\libcurl.def"
)

rem Установим скачанный сертификат для всех пользователей
rem certutil -f -addstore "My" "%ProgramFiles%\curl\curl-ca-bundle.crt"

rem Добавим путь к curl в path
setx PATH "%ProgramFiles%\curl\;%Path%"
PATH=%ProgramFiles%\curl\;%Path%

rem Добавляем утилиту curl.exe в исключения брандмауера Windows
netsh advfirewall firewall del rule name="curl"
netsh firewall add allowedprogram "%ProgramFiles%\curl\curl.exe" curl
netsh advfirewall firewall add rule name="curl" dir=in action=allow program="%ProgramFiles%\curl\curl.exe"

ECHO Install wget...
ECHO .
mkdir  "%ProgramFiles%\wget\"
ECHO .
 If exist "%SystemDrive%\Program Files (x86)" (
		curl.exe -k -o "%ProgramFiles%\wget\wget.exe" %URLWget-x64%
	) else (
		curl.exe -k -o "%ProgramFiles%\wget\wget.exe" %URLWget%
	)

rem Добавим путь к wget в path
setx PATH "%ProgramFiles%\wget\;%Path%"
PATH=%ProgramFiles%\wget\;%Path%

rem Добавляем утилиту wget.exe в исключения брандмауера Windows
netsh advfirewall firewall del rule name="wget"
netsh firewall add allowedprogram "%ProgramFiles%\wget\wget.exe" wget
netsh advfirewall firewall add rule name="wget" dir=in action=allow program="%ProgramFiles%\wget\wget.exe"

ECHO .
ECHO Install 7-Zip...
ECHO .
 If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\7z-x64.msi" %URL7Zip-x64%
		start /wait 7z-x64.msi /passive /norestart
	) else (
		wget.exe --no-check-certificate -O "%MyFolder%\7z.msi" %URL7Zip%
		start /wait 7z.msi /passive /norestart
	)

ECHO Install dotNetFx3.5...
	Dism /online /enable-feature /featurename:NetFx3

ECHO .	
ECHO Install dotNetFx4.8...
	wget.exe --no-check-certificate -O "%MyFolder%\ndp48.exe" %URLndp48%
	Start /wait ndp48.exe /q /norestart
	
ECHO .
ECHO Install Duplicati...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\duplicati-x64.msi" %URLduplicati-x64%
		Start /wait duplicati-x64.msi /passive /norestart
	 ) else (
 		wget.exe --no-check-certificate -O "%MyFolder%\duplicati-x86.msi" %URLduplicati%
		Start /wait duplicati-x86.msi  /passive /norestart
 	)

rem Исключение сетевого экрана для Duplicati
netsh advfirewall firewall del rule name="Duplicati"
netsh firewall del portopening tcp 8200
netsh advfirewall firewall add rule name="Duplicati" protocol="TCP" localport=8200 action=allow dir=IN
netsh firewall set portopening tcp 8200 Duplicati enable 

"%ProgramFiles%\Duplicati 2\Duplicati.WindowsService.exe" install

sc start Duplicati

del /q /s "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Duplicati 2.lnk"

ECHO .
ECHO Install Java SE Runtime Environment...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\jre-x64.exe" %URLjre-x64%
		Start /wait jre-x64.exe  /s
	) else (
		wget.exe --no-check-certificate -O "%MyFolder%\jre.exe" %URLjre%
		Start /wait jre.exe  /s
	)

ECHO .
ECHO Install LibreOffice...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\LibreOffice_x64.msi" %URLLibreOffice-x64%
		Start /wait LibreOffice_x64.msi  /passive /norestart
		wget.exe --no-check-certificate -O "%MyFolder%\LibreOffice_x64_helppack_ru.msi" %URLLibreOffice-helppack-x64%
		Start /wait LibreOffice_x64_helppack_ru.msi  /passive /norestart
	) else (
		wget.exe --no-check-certificate -O "%MyFolder%\LibreOffice_x86.msi" %URLLibreOffice%
		Start /wait LibreOffice_x86.msi  /passive /norestart
		wget.exe --no-check-certificate -O "%MyFolder%\LibreOffice_x86_helppack_ru.msi" %URLLibreOffice-helppack%
		Start /wait LibreOffice_x86_helppack_ru.msi /passive /norestart
	)

ECHO .
ECHO Install Unreal Commander...
		wget.exe --no-check-certificate -O "%MyFolder%\uncomsetup.exe" %URLuncomsetup%
		start uncomsetup.exe /SILENT

REM ECHO .
REM ECHO Install Google Chrome...
	REM wget.exe --no-check-certificate -O "%MyFolder%\ChromeSetup.exe" %URLGoogleChrome-x64%
	REM start /wait ChromeSetup.exe /silent /install

ECHO .
ECHO Install Google Chrome...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\googlechromestandaloneenterprise64.msi" %URLGoogleChrome-x64%
		Start /wait googlechromestandaloneenterprise64.msi /passive /norestart
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\googlechromestandaloneenterprise.msi" %URLGoogleChrome%
 		Start /wait googlechromestandaloneenterprise.msi /passive /norestart
 	)

ECHO .
ECHO Install Skype
	wget.exe --no-check-certificate -O "%MyFolder%\Skype.exe" %URLSkype%
	start /wait Skype.exe /silent

ECHO .
ECHO Install Notepad++...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\npp-x64.exe" %URLNotepad-x64%
		Start /wait npp-x64.exe /S
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\npp.exe" %URLNotepad%
 		Start /wait npp.exe /S
 	)

ECHO .
ECHO Install Thunderbird...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\ThunderbirdSetup-x64.exe" %URLthunderbird-x64%
		 Start /wait ThunderbirdSetup-x64.exe -ms
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\ThunderbirdSetup.exe" %URLthunderbird%
 		Start /wait ThunderbirdSetup.exe -ms
 	)

ECHO .
ECHO Install FirefoxSetup...
	If exist "%SystemDrive%\Program Files (x86)" (
		wget.exe --no-check-certificate -O "%MyFolder%\FirefoxSetup.x64.exe" %URLFirefoxSetup-x64%
		 Start /wait FirefoxSetup.x64.exe /SILENT
	 ) else (
		wget.exe --no-check-certificate -O "%MyFolder%\FirefoxSetup.exe" %URLFirefoxSetup%
 		Start /wait FirefoxSetup.exe /SILENT
 	)

ECHO .
ECHO Install LiteManager Pro...
	wget.exe --no-check-certificate -O "%MyFolder%\LiteManagerPro-Server.msi" "http://repo.mihanik.net/LiteManager/LiteManagerPro-Server.msi"
 	Start /wait LiteManagerPro-Server.msi /passive /norestart	
	sc start ROMService

ECHO .
ECHO Install Adobe Acrobat Reader...
		wget.exe --no-check-certificate -O "%MyFolder%\AcroRdrDC1900820071_ru_RU_win.exe" "http://repo.mihanik.net/Adobe_Acrobat_Reader/AcroRdrDC1900820071_ru_RU.exe"
		Start /wait AcroRdrDC1900820071_ru_RU_win.exe /sPB

REM ECHO ...
REM ECHO Install Adobe flash player
REM ECHO ...

rem Windows 7?
rem ver | find "6.1."

rem If %errorlevel%==0  (
rem 		"%ProgramFiles%\curl\curl.exe" -k -o "%MyFolder%\WinXP-7-Chrome-install_flash_player_ppapi.exe" "http://repo.mihanik.net/Adobe_Flash_Player/WinXP-7-Chrome-install_flash_player_ppapi.exe"
rem 		"%ProgramFiles%\curl\curl.exe" -k -o "%MyFolder%\WinXP-7-Explorer-install_flash_player_ax.exe" "http://repo.mihanik.net/Adobe_Flash_Player/WinXP-7-Explorer-install_flash_player_ax.exe"
rem 		"%ProgramFiles%\curl\curl.exe" -k -o "%MyFolder%\WinXP-7-Firefox-install_flash_player.exe" "http://repo.mihanik.net/Adobe_Flash_Player/WinXP-7-Firefox-install_flash_player.exe"
rem 		Start /wait WinXP-7-Chrome-install_flash_player_ppapi.exe /VERYSILENT
rem 		Start /wait WinXP-7-Explorer-install_flash_player_ax.exe /VERYSILENT
rem 		Start /wait WinXP-7-Firefox-install_flash_player.exe /VERYSILENT
rem  ) else (
rem 		"%ProgramFiles%\curl\curl.exe" -k -o "%MyFolder%\Win8-10-Chrome-install_flash_player_ppapi.exe" "http://repo.mihanik.net/Adobe_Flash_Player/Win8-10-Chrome-install_flash_player_ppapi.exe"
rem 		"%ProgramFiles%\curl\curl.exe" -k -o "%MyFolder%\Win8-10-Firefox-install_flash_player.exe" "http://repo.mihanik.net/Adobe_Flash_Player/Win8-10-Firefox-install_flash_player.exe"
rem 		Start /wait Win8-10-Chrome-install_flash_player_ppapi.exe /VERYSILENT
rem 		Start /wait Win8-10-Firefox-install_flash_player.exe /VERYSILENT
rem )

ECHO .
ECHO Install K-Lite_Codec_Pack...
		wget.exe --no-check-certificate -O "%MyFolder%\K-Lite_Codec_Pack_Mega.exe" %URLKLite%
		Start /wait K-Lite_Codec_Pack_Mega.exe /silent

ECHO .
ECHO Install AIMP...
		wget.exe --no-check-certificate -O "%MyFolder%\aimp.exe" %URLaimp%
		Start /wait aimp.exe /AUTO /SILENT

REM Включим защитника Windows
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 0 /f

:CONTINUE
	ECHO .
	ECHO Всё!
	ECHO .
	
:END

ping -n 10 127.0.0.1 >> nul

shutdown -r -f -t 00

EXIT /B
