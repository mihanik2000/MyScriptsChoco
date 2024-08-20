@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: NO
REM Antivirus software must be disabled: Not necessary
REM Dependencies: No
REM
REM Описание
REM
REM Скрипт выключает компьютер, если какой-то удалённый узел перестаёт пинговаться.
REM Выключение происходит после 4 сбоев ping, произошедщих подряд.
REM
REM Скрипт следует запускать шедулером каждую минуту.
REM
REM ****************************************

If exist "%ALLUSERSPROFILE%\MyPing.txt" (
	set /p MyPing = < "%ALLUSERSPROFILE%\MyPing.txt"
 ) else (
	set /a MyPing = 0
)

ping -n 1 8.8.8.8

if %errorlevel% EQU 0 (
	set /a MyPing = 0
) else (
	set /a MyPing += 1
)

echo %MyPing% > "%ALLUSERSPROFILE%\MyPing.txt"

if %MyPing% GTR 3 (
	echo Пора выключаться!
	shutdown -s -f -t 05
)

timeout 3 > nul

EXIT /B