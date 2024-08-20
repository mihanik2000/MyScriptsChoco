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
REM ���ᠭ��
REM
REM ��ਯ� �몫�砥� ��������, �᫨ �����-� 㤠��� 㧥� ������� �����������.
REM �몫�祭�� �ந�室�� ��᫥ 4 ᡮ�� ping, �ந��襤�� �����.
REM
REM ��ਯ� ᫥��� ����᪠�� 襤㫥஬ ������ ������.
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
	echo ��� �몫������!
	shutdown -s -f -t 05
)

timeout 3 > nul

EXIT /B