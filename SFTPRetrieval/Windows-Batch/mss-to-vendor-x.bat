@echo off
setlocal

REM Lines beginning with "REM" are comments - they are ignored by 
REM the script, and used to explain to YOU what's happening

REM ====================================================
REM THINGS YOU NEED TO DO TO MAKE THIS SCRIPT WORK
REM ====================================================
REM 1. Download WinSCP portable and put winscp.exe AND winscp.com in 
REM    the same folder as this batch file.
REM 2. Set the variables below in the "THINGS YOU NEED TO SET" section

REM Don't use this file for more than one vendor at a time - make a 
REM separate version for each vendor, to make troubleshooting easier. 
REM Give each copy of this batch file it's own folder to live in. 
REM For example:
REM   C:\Sync\Clever\this-batch-file.bat
REM   C:\Sync\BusPlanner\this-batch-file.bat
REM   C:\Sync\Vendor XXXXX\this-batch-file.bat

REM ====================================================
REM THINGS YOU NEED TO SET
REM ====================================================

REM The path to the MSS SFTP server
set mssSFTPPATH=sftp-path-here.myschoolsask.com

REM Your MSS username
set mssSFTPUsername=yourusername

REM Your MSS password
set mssSFTPPassword=yourpassword

REM The names of all of the files you want to retrieve from MSS
REM Separate multiple file with spaces
REM  example: set mssFileNames=one.csv two.csv
set mssFileNames=one.csv two.csv

REM Your Vendor SFTP username
set vendorSFTPUsername=yourusername

REM Your Vendor SFTP password
set vendorSFTPPassword=yourpassword


REM ====================================================
REM The script starts below this line - you probably
REM don't need to edit anything here.
REM ====================================================

REM -----------------------------------------------
REM Check if folders for logging exist and
REM create them if they don't
REM -----------------------------------------------

IF NOT EXIST LOGS MKDIR LOGS
IF NOT EXIST LOGS\FTP MKDIR LOGS\FTP
IF NOT EXIST LOGS\SCRIPT MKDIR LOGS\SCRIPT

REM -----------------------------------------------
REM Set up a timestamp to use for logging purposes
REM You shouldn't need to edit this section
REM -----------------------------------------------
for /f "tokens=1-7 delims=:/-, " %%i in ('echo exit^|cmd /q /k"prompt $d $t"') do (
   for /f "tokens=2-4 delims=/-,() skip=1" %%a in ('echo.^|date') do (
      set dow=%%i
      set %%a=%%j
      set %%b=%%k
      set %%c=%%l
      set hh=%%m
      set min=%%n
      set ss=%%o
   )
)
set timestamp=%yy%-%mm%-%dd%
set fulltimestamp=%yy%-%mm%-%dd%-%hh%%min%

set scriptLogPath="%cd%\LOGS\SCRIPT\%timestamp%.txt"
set ftpLogPath="%cd%\LOGS\FTP\%fulltimestamp%\"
set originPath="%cd%"

echo %date% %time%: Script started >> %scriptLogPath%
echo Logging script progress to %scriptLogPath%
echo %date% %time%: Script is running in directory %originPath% >> %scriptLogPath%
echo %date% %time%: Logging script progress to %scriptLogPath% >> %scriptLogPath%

mkdir %ftpLogPath%
cd %ftpLogPath%

REM -----------------------------------------------
REM Connect to MSS SFTP and retrieve our files
REM -----------------------------------------------
REM Build SFTP batch file
echo %date% %time%: Retrieving files from MySchoolSask... >> %scriptLogPath%
winscp.com /script=winscp_batch_commands.txt /log="WinSCP-%fulltimestamp%.log" /loglevel=0

REM -----------------------------------------------
REM Send the file(s) to the vendors
REM -----------------------------------------------
echo %date% %time%: Sending files to vendor... >> %scriptLogPath%
REM winscp.com /script=winscp_batch_commands.txt /log="WinSCP-%fulltimestamp%.log" /loglevel=0

cd %originPath%
echo %date% %time%: Script complete >> %scriptLogPath%
