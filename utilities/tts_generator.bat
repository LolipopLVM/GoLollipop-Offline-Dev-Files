:: TTS Generator
:: Author: RedBoi/#8423 
:: Suggested By: jaime.#8359
:: License: MIT
::::::::::::::::::::
:: Initialization ::
::::::::::::::::::::

title Lolipop: Offline TTS Generator [Initializing...]

:: Stop commands from spamming stuff, cleans up the screen
@echo off && cls

:: Lets variables work or something idk im not a nerd
SETLOCAL ENABLEDELAYEDEXPANSION

:: Make sure we're starting in the correct folder, and that it worked (otherwise things would go horribly wrong)
pushd "%~dp0"
if !errorlevel! NEQ 0 ( set ERROR=y & goto error_location )
if not exist "balcon" ( set ERROR=y & goto error_location )

:: Check *again* because it seems like sometimes it doesn't go into dp0 the first time???
pushd "%~dp0"
if !errorlevel! NEQ 0 ( set ERROR=y & goto error_location )
if not exist "balcon" ( set ERROR=y & goto error_location )
set SUBSCRIPT=y
if exist "config.bat" ( 
	call config.bat
	set "SUBSCRIPT="
) else (
	set ERROR=y
	set "SUBSCRIPT="
	goto error_location
)

:error_location
if !ERROR!==n ( goto noerror_location )
echo Doesn't seem like this script is in a Lolipop: Offline utilities folder.
pause && exit
:noerror_location

:: patch detection
if exist "..\patch.jpg" ( 
	goto patched 
) else ( 
	goto init
)

:patched
echo 

:init
:: Checking if the voices (like SAPI 4, OLD Cepstral/Some Voiceforge Voices, and OLD Ivona Voices) 
:: are installed - jaime
title Lolipop: Offline TTS Generator [Checking voice dependencies...]
if !SKIPCHECKDEPENDSVOICES!==y (
	echo Checking voice dependencies has been skipped.
	PING -n 4 127.0.0.1>nul
	echo:
	cls & goto main
)

if !VERBOSEWRAPPER!==n (
	echo Checking for voice dependencies...
	echo:
)

:check_sapifour
echo Checking if SAPI 4 voices are installed...
balcon\balcon.exe -l | findstr "SAPI 4" > nul
if !errorlevel! == 0 (
	echo SAPI 4 voices are not installed.
	echo:
	set SAPIFOUR_DETECTED=n
	set ADMINREQUIRED=y
	set NEEDTHEDEPENDERS=y
) else (
	echo SAPI 4 voices are installed.
	echo:
	set SAPIFOUR_DETECTED=y
)
:check_cepstral
echo Checking if the OLD Cepstral/Some Voiceforge voices are installed...
balcon\balcon.exe -l | findstr "Cepstral" > nul
if !errorlevel! == 0 (
	echo OLD Cepstral/Some Voiceforge voices are not installed.
	set CEPSTRAL_DETECTED=n
	set ADMINREQUIRED=y
	set NEEDTHEDEPENDERS=y
) else (
	echo OLD Cepstral/Some Voiceforge voices are installed.
	set CEPSTRAL_DETECTED=y
)
:check_ivona
echo Checking if the OLD IVONA voices are installed...
balcon\balcon.exe -l | findstr "IVONA" > nul
if !errorlevel! == 0 (
	echo OLD IVONA voices are not installed.
	set IVONA_DETECTED=n
	set ADMINREQUIRED=y
	set NEEDTHEDEPENDERS=y
) else (
	echo OLD IVONA voices are installed.
	set IVONA_DETECTED=y
)
:: if it is checked then it gets directly to the main tts generator
:: if not then it installs missing dependencies
if !NEEDTHEDEPENDERS!==y (
	if !SKIPDEPENDINSTALLVOICES!==n (
		echo:
		echo Installing missing voice dependencies...
		echo:
	) else (
	echo Skipping voice dependencies install.
	goto main
	)
) else (
	echo All dependencies are available.
	echo Turning off checking dependencies...
	echo:
	:: Initialize vars
	set CFG=config.bat
	set TMPCFG=tempconfig.bat
	:: Loop through every line until one to edit
	if exist !tmpcfg! del !tmpcfg!
	set /a count=1
	for /f "tokens=1,* delims=0123456789" %%a in ('find /n /v "" ^< !cfg!') do (
		set "line=%%b"
		>>!tmpcfg! echo(!line:~1!
		set /a count+=1
		if !count! GEQ 20 goto linereached
	)
	:linereached
	:: Overwrite the original setting
	echo set SKIPCHECKDEPENDSVOICES=y>> !tmpcfg!
	echo:>> !tmpcfg!
	:: Print the last of the config to our temp file
	more +15 !cfg!>> !tmpcfg!
	:: Make our temp file the normal file
	copy /y !tmpcfg! !cfg! >nul
	del !tmpcfg!
	:: Set in this script
	set SKIPCHECKDEPENDSVOICES=y
	goto main
)

title Lolipop: Offline TTS Generator [Installing voice dependencies...]

:: Preload variables
set INSTALL_FLAGS=ALLUSERS=1 /norestart
set SAFE_MODE=n
set CPU_ARCHITECTURE=what
if /i "!processor_architecture!"=="x86" set CPU_ARCHITECTURE=32
if /i "!processor_architecture!"=="AMD64" set CPU_ARCHITECTURE=64
if /i "!PROCESSOR_ARCHITEW6432!"=="AMD64" set CPU_ARCHITECTURE=64
if /i "!SAFEBOOT_OPTION!"=="MINIMAL" set SAFE_MODE=y
if /i "!SAFEBOOT_OPTION!"=="NETWORK" set SAFE_MODE=y

:: Check for admin if installing Cepstral, SAPI 4, or IVONA voices
:: Skipped in Safe Mode, just in case anyone is running Lolipop in safe mode... for some reason
:: and also because that was just there in the code i used for this and i was like "eh screw it why remove it"
if !ADMINREQUIRED!==y (
	if !VERBOSEWRAPPER!==y ( echo Checking for Administrator rights... && echo:)
	if /i not "!SAFE_MODE!"=="y" (
		fsutil dirty query !systemdrive! >NUL 2>&1
		if /i not !ERRORLEVEL!==0 (
			color cf
			if !VERBOSEWRAPPER!==n ( cls )
			echo:
			echo ERROR
			echo:
			echo Lolipop: Offline needs to install these voices:
			echo:
			if !SAPIFOUR_DETECTED!==n ( echo SAPI 4 )
			if !CEPSTRAL_DETECTED!==n ( echo OLD Cepstral/Some Voiceforge )
			if !IVONA_DETECTED!==n ( echo OLD Ivona ^(2^) )
			echo To do this, it must be started with Admin rights.
			echo:
			echo Press any key to restart this window and accept any admin prompts that pop up.
			pause
			if !DRYRUN!==n (
				echo Set UAC = CreateObject^("Shell.Application"^) > %tmp%\requestAdmin.vbs
				set params= %*
				echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> %tmp%\requestAdmin.vbs
				start "" %tmp%\requestAdmin.vbs
				exit /B
			) else (
				goto dryrungobrrr
			)
			:dryrungobrrr
			echo:
			if !DRYRUN!==y (
				echo ...yep, dry run is going great so far, let's skip the exit
				pause
				goto installing
			)
		)
	)
	if !VERBOSEWRAPPER!==y ( echo Admin rights detected. && echo:)
)

:: Installing missing voices
:installing
if !SAPIFOUR_DETECTED!==n (
	echo Installing SAPI 4 voices and requirements for SAPI 4...
	if not exist "installers\SAPI-four" ( 
		echo ......
		PING -n 4 127.0.0.1>nul
		echo This is an issue here....
		echo The SAPI 4 voices and requirements for SAPI 4 does not exist.
		echo A normal copy of Lolipop: Offline should come with one.
		echo You should be able to find a copy on these websites, here:
		echo https://ia802904.us.archive.org/view_archive.php?archive=/35/items/speakonia_1036/speakonia-1.0.zip
		echo https://ia802904.us.archive.org/view_archive.php?archive=/35/items/speakonia_1036/speakonia-langmodules.zip
		echo Although SAPI 4 voices are needed, Offline will try to install anything else it can.
		pause
		goto after_sapifour_installed
	)
	if !DRYRUN!==n (
		pushd installers\SAPI-four
		start lhttseng.exe
		start msttsl.exe
		start spchapi.exe
		start tv_enua.exe
		popd
		goto sapifour_installed
	)
	:sapifour_installed
	echo SAPI 4 voices and requirements for SAPI 4 are now installed.
	set SAPIFOUR_DETECTED=y
	goto after_sapifour_installed
)

:after_sapifour_installed
if !CEPSTRAL_DETECTED!==n (
	echo Installing OLD Cepstral/Some Voiceforge voices...
	if not exist "installers\old-cepstral-voices" ( 
		echo ......
		PING -n 4 127.0.0.1>nul
		echo This is an issue here....
		echo All of the OLD Cepstral/Some Voiceforge voices does not exist.
		echo A normal copy of Lolipop: Offline should come with one.
		echo You should be able to find a copy on the website:
		echo https://drive.google.com/file/d/1Mxa-jbt0Xw_7t0Cx0u1wVlAcllh-NAMu/view?usp=sharing
		echo Although the OLD Cepstral voices are needed, Offline will try to install anything else it can.
		pause
		goto after_cepstral_installed
	)
	echo Proper Node.js installation doesn't seem possible to do automatically.
	echo You can just keep clicking next until it finishes, and Lolipop: Offline will continue once it closes.	
	if !DRYRUN!==n (
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Allison_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Amy_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Calie_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Damien_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_David_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Duchness_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Duncan_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Emily_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Lawrence_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Robin_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_Walter_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		msiexec /qn+ /i "installers\old-cepstral-voices\Cepstral_William_windows_5.2.2b1.msi" !INSTALL_FLAGS!
		goto cepstral_installed
	)
	:cepstral_installed
	echo The OLD Cepstral/Some Voiceforge voices are now installed.
	set CEPSTRAL_DETECTED=y
	goto after_cepstral_installed
)

:after_cepstral__installed
if !IVONA_DETECTED!==n (
	echo Installing OLD IVONA ^(2^) voices...
	if not exist "installers\old-ivona-voices" ( 
		echo ......
		PING -n 4 127.0.0.1>nul
		echo This is an issue here....
		echo All of the OLD IVONA ^(2^) voices does not exist.
		echo A normal copy of Lolipop: Offline should come with one.
		echo You should be able to find a copy on these websites:
		echo https://www.deskshare.com/download/voices/Eric.exe
		echo http://web.archive.org/web/20100923222606/http://deskshare.com/download/voices/Jennifer.exe
		echo http://web.archive.org/web/20100923222606/http://deskshare.com/download/voices/Joey.exe
		echo http://web.archive.org/web/20160324154301/http://www.deskshare.com/download/voices/Salli.exe
		echo https://www.deskshare.com/download/voices/Ivy.exe
		echo https://www.deskshare.com/download/voices/Brian.exe
		echo https://www.deskshare.com/download/voices/Amy.exe
		echo https://www.deskshare.com/download/voices/Emma.exe
		echo https://www.deskshare.com/download/voices/Kendra.exe
		echo https://www.deskshare.com/download/voices/Kimberly.exe
		echo Although the OLD IVONA ^(2^) voices are needed, Offline will try to install anything else it can.
		pause
		goto after_ivona_installed
	)
	echo Proper Ivona 2 voices installation doesn't seem possible to do automatically.
	echo You can just keep clicking next until it finishes, and Lolipop: Offline will continue once it closes.	
	if !DRYRUN!==n (
		if !CPU_ARCHITECTURE!==32 (
			start "runasti\RunAsTI32.exe" "installers\old-ivona-voices\Eric.exe"
		)
		if !CPU_ARCHITECTURE!==64 (
			start "runasti\RunAsTI64.exe" "installers\old-ivona-voices\Eric.exe"
		)
		goto ivona_installed
	)
	:ivona_installed
	echo The OLD IVONA ^(2^) voices are now installed.
	set IVONA_DETECTED=y
	goto after_ivona_installed
)

:after_ivona_installed
if !ADMINREQUIRED!==y (
	color 20
	if !VERBOSEWRAPPER!==n ( cls )
	echo:
	echo Dependencies needing Admin now installed^!
	echo:
	echo Lolipop: Offline no longer needs Admin rights,
	echo please restart normally by double-clicking the tts_generator.bat.
	echo:
	echo If you saw this from running normally,
	echo Lolipop: Offline should continue normally after a restart.
	echo:
	if !DRYRUN!==y (
		echo ...you enjoying the dry run experience? Skipping closing.
		pause
		color 7
		goto main
	)
	pause
	exit
)

:main
:: Welcome to TTS Generator, RedBoi.
