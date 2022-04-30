:: Lolipop: Offline Metadata
:: Important useful variables that are displayed by start_lolipop.bat
:: You probably shouldn't touch this. This only exists to make things easier for the devs everytime we go up a build number or something like that.

:: Opens this file in Notepad when run
setlocal
if "%SUBSCRIPT%"=="" ( start notepad.exe "%CD%\%~nx0" & exit )
endlocal

:: Version number and build number
set LOLIPOP_VER=1.0.0 Private Beta
set LOLIPOP_BLD=05

