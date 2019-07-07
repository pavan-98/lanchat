

@echo off
mode con: cols=54 lines=15
title Command Prompt Chat By PK

::--------------------
::Below is the code to log-in to the program. 
::--------------------
:login
mode con: cols=54 lines=15
cls
echo ---------------------
echo Log-In to  Chat
echo.
echo.
echo.
echo Please type your username and press enter...
echo [To Create an Account, type 1 and Press Enter]
echo.
set /p username=Username:
::Check if input is 1 to go create an account
if %username% == 1 goto create_account
cls

echo ---------------------
echo Log-In to  Chat
echo.
echo.
echo.
echo Please type your password and press enter...
echo.
set /p password=Password:

::Now we have the username and password set. We can now check to see if they are correct.
::First we need to see if the username exists. 

if exist ".\users\%username%.dll" goto password_check
::If the username does not exist, we will now display
::Incorrect Credentials Message and return to login
:incorrect_credentials
cls
echo I'm sorry, but those credentials were not found. Please try again.
timeout /t 3 >nul
goto login


::If the username did exist, we will now check to see if the password matches.
:password_check

::First, we need to get the password from the file and set it as a variable.
set /p password_file=<".\users\%username%.dll"
::Now, Compare the two
if %password_file%==%password% goto correct_credentials

::if they do not match, go again to incorrect credentials
goto incorrect_credentials

:create_account
::Here we create an account. We need to ask for a username and password.
cls
echo _____________________
echo Create an Account
echo ---------------------
echo.
echo.
echo Please enter your information...
echo.
set /p new_username=Username:

::Clear the screen, re-draw and ask for password
cls
echo _____________________
echo Create an Account
echo ---------------------
echo.
echo.
echo Please enter your information...
echo.
set /p new_password=Password:

::Now that we have the information, we need to 
::write it to the account file. We use the .dll extention
echo %new_password% >".\users\%new_username%.dll"

::now we confirm creation and go home
echo.
echo Account Successfully Created!
timeout /t 2 >nul
goto login



:correct_credentials
::If credentials were correct, start up the message viewer and begin asking for input
start cmd /c ".\Message_Displayer.cmd"
title Chatting as %username%
echo. >>.\chat.txt
echo %username% has joined the room >>chat.txt
echo. >>.\chat.txt


:read_messages

cls
mode con: cols=54 lines=4
set /p input=Message:
::if input is nothing, go back
if "%input%"=="" goto read_messages
::If input is exit, exit the program.


::Input message into chat file
echo %username%: %input% >>chat.txt
::reset the input to prevent spam
set input=
goto read_messages



