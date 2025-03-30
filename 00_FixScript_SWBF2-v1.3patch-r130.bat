
@echo off
title Script Fixing the "SWBF2-v1.3patch-r130.exe" download locations being wrong
REM DEPRECATED
echo.

REM Hard-coded locations for the game on steam
SET addonfolder_Final="C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\addon"
SET dataFolder_Final="C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\data"

SET addonFolder="C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\AAA-v1.3patch"
SET dataFolder="C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\data\_lvl_pc"



IF EXIST %addonFolder% (
	echo %addonFolder%
	rem move /Y "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\addon\AAA-v1.3patch" "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\addon\"
	robocopy "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\addon\AAA-v1.3patch " "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\addon\ " /move /e
	rmdir  "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\addon"
) ELSE (echo "Addon folder location already fixed.")

IF EXIST %dataFolder% (
	echo %dataFolder%
	robocopy "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\data\_lvl_pc\ " "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\data\_lvl_pc\ " /move /e
	rmdir "C:\Program Files (x86)\Steam\steamapps\common\Star Wars Battlefront II Classic\GameData\data"
) ELSE (echo "Data folder location already fixed")

pause
