
@echo off
title SWBF2 UnOfficial v1.3 Patch r83
echo.

REM ## ASK IF PLAYING ON GOG OR STEAM, THEN CHECK WHERE THE FILE SHOULD BE TO ENSURE THE GAME DATA IS INSTALLED BEFORE PROCEEDING

REM Set this to be the path of your exe. I've only tested this on the steam version, as you can see in this file path.
SET "W11_EXE_PATH=C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\BattlefrontII.exe"
REM SET "W11_EXE_PATH=GOG PATH

REM setup all the file/folder paths
REM delims is a TAB followed by a space

SET swbf2=%W11_EXE_PATH%
SET swbf2=%swbf2:BattlefrontII.exe=%

SET installed=%swbf2%v1.3patch\settings\installed.txt
SET hasHud=%swbf2%v1.3patch\settings\hasHud.txt
SET hasSides=%swbf2%v1.3patch\settings\hasSides.txt
SET noAwards=%swbf2%v1.3patch\settings\noAwards.txt
SET noColors=%swbf2%v1.3patch\settings\noColors.txt

SET sides=%swbf2%DATA\_LVL_PC\SIDE
SET lvl=%swbf2%DATA\_LVL_PC

SET patch=_v1.3patch
SET retail=.retail

REM Double check for problems
IF NOT EXIST "%swbf2%BattlefrontII.exe" (
echo.
echo.
echo WARNING - Safty check failed:
echo    "%swbf2%BattlefrontII.exe" does not exist
echo.
echo    Halting to prevent possible folder damage
echo.
pause
GOTO END
)

REM auto-install if this batch file is called with the first argument as '1'
IF '%1' == '1' GOTO install

echo.
echo ---- Folders ----
echo SWBF2's GameData:       %swbf2%
echo LVL folder:  %lvl%
echo Side folder: %sides%
echo Installed:   %installed%
echo Has hud:     %hasHud%
echo Has sides:   %hasSides%
echo No effects:  %noAwards%
echo.
SET input=
SET /p input=If these folders seem wrong, type 'n' now to cancel or press Enter to continue: 
IF NOT '%input%'=='' SET input=%input:~0,1%
IF '%input%'=='n' GOTO END
GOTO MAIN_MENU


:MAIN_MENU
cls
echo ---- Main Menu ----
IF NOT EXIST "%installed%" GOTO INSTALL_MENU
IF EXIST "%installed%" GOTO INSTALLED_MENU


:INSTALL_MENU
echo 1. Install the UnOfficial v1.3 Patch
echo 0. Exit
echo.
GOTO PROMPT


:INSTALLED_MENU
echo 2. Uninstall the UnOfficial v1.3 Patch
IF EXIST "%hasHud%" (echo 3. Remove the HUD changes) 
IF NOT EXIST "%hasHud%" (echo 4. Restore the HUD changes)
IF EXIST "%hasSides%" (echo 5. Remove the side changes)
IF NOT EXIST "%hasSides%" (echo 6. Restore the side changes)
IF NOT EXIST "%noAwards%" (echo 7. Disable the award effects)
IF EXIST "%noAwards%" (echo 8. Restore award effects)
IF NOT EXIST "%noColors%" (echo 9. Disable custom map colors)
IF EXIST "%noColors%" (echo 10. Restore custom map colors)
echo 0. Exit
echo.
GOTO PROMPT

:PROMPT
SET input=badInput
SET /p input=Type in a menu item number: 
IF '%input%'=='0' GOTO END
IF '%input%'=='1' GOTO install
IF '%input%'=='2' GOTO uninstall
IF '%input%'=='3' GOTO removeHud
IF '%input%'=='4' GOTO restoreHud
IF '%input%'=='5' GOTO removeSides
IF '%input%'=='6' GOTO restoreSides
IF '%input%'=='7' GOTO disableAwards
IF '%input%'=='8' GOTO enableAwards
IF '%input%'=='9' GOTO disableColors
IF '%input%'=='10' GOTO enableColors
GOTO MAIN_MENU


:install
echo.
echo Installing...
REM install the sides
echo.
CALL .\bats\addSides.bat

REM install the lvls
echo.
CALL .\bats\addMainLVLs.bat

REM install the strings
echo.
echo Updating the strings...
copy "strings\v1.3patch_strings.lvl" "%lvl%\v1.3patch_strings.lvl"

REM install the preview movie
echo.
echo Adding official maps' preview video
copy ".\movie\pre-movie.mvs" "%lvl%\MOVIES\pre-movie.mvs"

REM install the settings
echo.
echo Updating the settings...
mkdir "%swbf2%\v1.3patch\settings\"

:SKIPCOMMANDS2
echo This file tells the UnOfficial v1.3 patch's menu system that the v1.3 patch is installed > "%installed%"
echo This file tells the UnOfficial v1.3 patch's menu system that the custom HUD is being used > "%hasHud%"
echo This file tells the UnOfficial v1.3 patch's menu system that the custom sides are being used > "%hasSides%"
echo.
IF '%1' == '1' GOTO END
GOTO MAIN_MENU


:uninstall
echo.
echo Uninstalling...
REM Uninstall the sides
echo.
CALL .\bats\removeSides.bat

REM Uninstall the lvls
echo.
CALL .\bats\removeMainLVLs.bat

REM Uninstall the strings
echo.
echo Updating the strings...
del "%lvl%\v1.3patch_strings.lvl"

REM Uninstall the preview movie
echo.
echo Removing official maps' preview video
del "%lvl%\MOVIES\pre-movie.mvs"

REM Removing the settings
echo.
echo Updating the settings...
IF EXIST "%installed%" (del "%installed%")
IF EXIST "%hasHud%" (del "%hasHud%")
IF EXIST "%hasSides%" (del "%hasSides%")
IF EXIST "%noAwards%" (del "%noAwards%")
IF EXIST "%noColors%" (del "%noColors%")
rmdir "%swbf2:GameData\=%\v1.3patch\settings"
rmdir "%swbf2:GameData\=%\v1.3patch\"
echo.
pause
GOTO MAIN_MENU


:removeHud
echo Updating the HUD
del "%lvl%\ingame.lvl"
xdelta.exe -d -s ".\retail\ingame.lvl.retail" ".\patch\ingame.lvl_NoHUD_v1.3patch" "%lvl%\ingame.lvl"
del "%hasHud%"
pause
GOTO MAIN_MENU


:removeSides
echo.
CALL .\bats\removeSides.bat
del "%hasSides%"
pause
GOTO MAIN_MENU


:enableAwards
echo Updating award effect settings
del "%noAwards%"
pause
GOTO MAIN_MENU


:restoreHud
echo Updating the HUD
del "%lvl%\ingame.lvl"
xdelta.exe -d -s ".\retail\ingame.lvl.retail" ".\patch\ingame.lvl_v1.3patch" "%lvl%\ingame.lvl"
echo This file tells the UnOfficial v1.3 patch's menu system that the custom HUD is being used > "%hasHud%"
pause
GOTO MAIN_MENU


:restoreSides
echo.
CALL .\bats\addSides.bat
echo This file tells the UnOfficial v1.3 patch's menu system that the custom sides are being used > "%hasSides%"
pause
GOTO MAIN_MENU


:disableAwards
echo Updating award effect settings...
echo Delete this file to renable award effects > "%noAwards%"
pause
GOTO MAIN_MENU


:disableColors
echo Updating map color settings...
echo Delete this file to renable custom map colors > "%noColors%"
pause
GOTO MAIN_MENU


:enableColors
echo Updating map color settings
del "%noColors%"
pause
GOTO MAIN_MENU


:END
echo.
echo Have a nice day and enjoy.
IF '%1' == '1' GOTO STOP
pause

:STOP
