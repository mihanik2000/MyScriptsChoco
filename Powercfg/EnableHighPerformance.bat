@echo off
REM ****************************************
REM
REM Written by Michael Medvedev aka mihanik.
REM
REM https://mihanik.net
REM
REM Require administrator rights: NO
REM
REM ****************************************

    REM Включение режима электропитания "Высокая производительность"
    powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

    echo Режим электропитания "Высокая производительность" включен.

EXIT /B
