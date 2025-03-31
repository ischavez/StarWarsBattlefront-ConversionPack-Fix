
@echo off
title Script Fixing the "KotORGC2.exe" download locations being wrong
REM When time permits, modularize so that you can just enter the KotORGC1 foler path and have it get fixed regardless of location, using this script
echo.

REM Location that the Installation is at
SET ErrorLocation1="C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\KotORGC1"


IF EXIST %ErrorLocation1% (
	echo %ErrorLocation1%
	robocopy "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\KotORGC1\GameData " "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData " /move /e
	rmdir  "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\KotORGC1"
) ELSE (echo "KotOR Galactic Conquest folder location already fixed.")

pause
