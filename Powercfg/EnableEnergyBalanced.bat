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

    REM Включение режима электропитания "Сбалансированный"
    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e

    echo Режим электропитания "Сбалансированный" включен.

EXIT /B
