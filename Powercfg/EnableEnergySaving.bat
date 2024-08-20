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

    REM Включение режима электропитания "Экономия энергии"
    powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a

    echo Режим электропитания "Экономия энергии" включен.

EXIT /B
