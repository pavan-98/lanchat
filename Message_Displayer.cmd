


@echo off
mode con: cols=60 lines=42
title Incoming Messages
:home
if not exist ".\chat.txt" goto create
cls
type .\chat.txt
echo.
timeout /t 1 >nul
goto home


:create
echo PK CHAT >.\chat.txt
echo ================================= >>.\chat.txt
goto home