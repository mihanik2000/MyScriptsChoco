@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: NO
REM
Rem Отбражаем значок "Мой компьютер" на рабочем столе пользователя
REM
REM ****************************************

echo Отбражаем значок "Мой компьютер" на рабочем столе пользователя

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f

timeout 5 > nul

EXIT /B
