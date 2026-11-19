@echo off
setlocal
cd /d "%~dp0"
title BO1 Living Zombies V1.0.1 - installer
set "DST=%LOCALAPPDATA%\Plutonium"
set "PLG=%DST%\plugins"
set "LIV=%DST%\plugins\bo1_living"
set "ZOM=%DST%\storage\t5\scripts\sp\zom"
echo.
echo  BO1 Living Zombies V1.0.1 (Oct 31 2026, single-player)
echo  Installing into %DST%
echo.
if not exist "Plutonium\plugins\ragdoll-m5.dll" (
  echo  Can't find the package files next to install.bat. Unzip the whole folder first.
  goto fail
)
tasklist /fi "imagename eq plutonium-bootstrapper-win32.exe" 2>nul | find /i "plutonium-bootstrapper" >nul && (
  echo  The game is running. Close Black Ops / Plutonium, then run this again.
  goto fail
)
if not exist "%DST%" (
  echo  %DST% was not found. Install and run Plutonium once first.
  goto fail
)
if not exist "%LIV%" mkdir "%LIV%"
if not exist "%ZOM%" mkdir "%ZOM%"

rem --- back up anything we are about to replace (first backup is kept; nothing is deleted)
call :bak "%PLG%\ragdoll-m5.dll"
call :bak "%ZOM%\ragdoll_m5_living.gsc"
for %%F in (Plutonium\plugins\bo1_living\*) do call :bak "%LIV%\%%~nxF"

rem --- copy
xcopy /e /i /y /q "Plutonium\plugins" "%PLG%" >nul || goto copyfail
xcopy /e /i /y /q "Plutonium\storage" "%DST%\storage" >nul || goto copyfail

rem --- mark the V1 policies newest so the plugin picks them over older policy files
pushd "%LIV%"
copy /b "bo1_zombie_walker_walk_sprint_turn_engine.r2rpolicy"+,, "bo1_zombie_walker_walk_sprint_turn_engine.r2rpolicy" >nul
copy /b "bo1_zombie_getup_keepers_nofillers_best_engine.r2rpolicy"+,, "bo1_zombie_getup_keepers_nofillers_best_engine.r2rpolicy" >nul
popd

echo  Done. Start the game and load any Zombies map.
echo  Turn it off any time in the console: living_enable 0
echo.
pause
exit /b 0

:bak
if exist "%~1" if not exist "%~1.bak_pre_v1" copy /y "%~1" "%~1.bak_pre_v1" >nul
exit /b 0

:copyfail
echo  Copy FAILED. Close the game (and anything holding the files) and try again.
:fail
echo.
pause
exit /b 1
