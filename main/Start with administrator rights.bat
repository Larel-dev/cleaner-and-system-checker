@color 20
@chcp 65001
@title System Checker
:LanguageS
@cls
@echo off
@echo What language will you use?
@echo Какой язык вы будете использовать?
@choice /C:12 /m "1 - English, 2 - Русский"
@If Errorlevel ==2 goto MenuRus
@If Errorlevel ==1 goto MenuEng
goto End

:MenuEng
@cls
@echo *****************************
@echo  Script by Larel and Wolfa22
@echo *****************************
@echo What do you want?
@echo If you want to check the system for any errors, then enter 3
@echo If you want to clear the system, then enter 2
@choice /C:123 /m "If you want to optimize the system, then enter 1"
@If Errorlevel ==3 goto CheckingE
@If Errorlevel ==2 goto CleaningE
@If Errorlevel ==1 goto OptimizingE
goto End

:MenuRus
@cls
@echo ********************************
@echo  Скрипт сделан Larel и Wolfa22
@echo ********************************
@echo Что вы хотите?
@echo Если вы хотите просканировать вашу систему на какие-нибудь ошибки, тогда нажмите 3
@echo Если вы хотите очистить вашу систему от мусорных файлов, тогда нажмите 2
@choice /C:123 /m "Если вы хотите оптимизировать вашу систему, тогда нажмите 1"
@If Errorlevel ==3 goto CheckingR
@If Errorlevel ==2 goto CleaningR
@If Errorlevel ==1 goto OptimizingR
goto End

:CheckingE
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
chkdsk C: /f /r /x
@echo Checking is finished!
Goto MenuEng

:CheckingR
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
chkdsk C: /f /r /x
@echo Проверка системы завершена!
Goto MenuRus

:CleaningE
@echo Cleaning system files, please wait

taskkill /f /IM opera.exe
taskkill /f /IM discord.exe
taskkill /f /IM chrome.exe
taskkill /f /IM explorer.exe
taskkill /f /IM firefox.exe
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q “%userprofile%\Local Settings\Temporary Internet Files\*.*”
del /f /s /q “%userprofile%\Local Settings\Temp\*.*”
del /f /s /q “%userprofile%\recent\*.*”
powershell.exe -ExecutionPolicy Bypass -File "main.ps1"
timeout 10 /nobreak
DISM /Online /Cleanup-Image /AnalyzeComponentStore
DISM /Online /Cleanup-Image /StartComponentCleanup
@start explorer.exe
@echo Cleaning is finished!
Goto MenuEng

:CleaningR
@echo Идет очистка системных файлов, пожалуйста подождите!

taskkill /f /IM opera.exe
taskkill /f /IM discord.exe
taskkill /f /IM chrome.exe
taskkill /f /IM explorer.exe
taskkill /f /IM firefox.exe
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q “%userprofile%\Local Settings\Temporary Internet Files\*.*”
del /f /s /q “%userprofile%\Local Settings\Temp\*.*”
del /f /s /q “%userprofile%\recent\*.*”
powershell.exe -ExecutionPolicy Bypass -File "main.ps1"
timeout 10 /nobreak
DISM /Online /Cleanup-Image /AnalyzeComponentStore
DISM /Online /Cleanup-Image /StartComponentCleanup
@start explorer.exe
@echo Очистка завершена!
Goto MenuRus

:OptimizingE

copy SetACL.exe C:\Windows\System32
@echo Kill Foreground
@taskkill /F /IM "MicrosoftEdge.exe" 1>NUL 2>NUL
@taskkill /F /IM "explorer.exe" 1>NUL 2>NUL

@echo Disable metro boot menu
bcdedit /set {default} bootmenupolicy legacy 1>NUL 2>NUL

@echo Uninstall OneDrive
taskkill /F /IM "OneDrive.exe" 1>NUL 2>NUL
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall 1>NUL 2>NUL
rd "%UserProfile%\OneDrive" /Q /S 1>NUL 2>NUL
rd "%LocalAppData%\Microsoft\OneDrive" /Q /S 1>NUL 2>NUL
rd "%ProgramData%\Microsoft OneDrive" /Q /S 1>NUL 2>NUL
rd "C:\OneDriveTemp" /Q /S 1>NUL 2>NUL

@echo Add environmental variables
setx ProgramFiles "C:\Program Files" /m 1>NUL 2>NUL
setx ProgramFiles86 "C:\Program Files (x86)" /m 1>NUL 2>NUL
setx ProgramData "C:\ProgramData" /m 1>NUL 2>NUL

@echo Hide PerfLogs folder
attrib "C:\PerfLogs" +h 1>NUL 2>NUL

@echo Reveal Public Desktop folder
attrib "C:\Users\Public\Desktop" -h 1>NUL 2>NUL

@echo Set Hibernation type to Reduced
powercfg /h /type reduced 1>NUL 2>NUL

@echo Delete "Microsoft Edge" shortcut from Desktop
del /f /q "C:\Users\%USERNAME%\Desktop\Microsoft Edge.lnk" 1>NUL 2>NUL

@echo Delete "Your Phone" shortcut from Desktop
del /f /q "C:\Users\%USERNAME%\Desktop\Your Phone.lnk" 1>NUL 2>NUL

@echo Disable Services
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL

@echo Enable Developer mode
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowDevelopmentWithoutDevLicense" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowAllTrustedApps" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Change Folder options
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowStatusBar" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Slideshow during Lock Screen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Lock Screen" /v "SlideshowEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Enable Dark Mode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Remove "- Shortcut" text from shortcuts
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /v "ShortcutNameTemplate" /t REG_SZ /d "\"%%s.lnk\"" /f 1>NUL 2>NUL

@echo Enable Peek at desktop
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewDesktop" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Windows Defender SmartScreen Filter
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable first login animation
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableFirstLogonAnimation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable all Content Delivery Manager features
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable all suggested apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "22StokedOnIt.NotebookPro_ffs55s3hze5sr" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "2FE3CB00.PicsArt-PhotoStudio_crhqpqs3x1ygc" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "41038Axilesoft.ACGMediaPlayer_wxjjre7dryqb6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "5CB722CC.SeekersNotesMysteriesofDarkwood_ypk0bew5psyra" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "7458BE2C.WorldofTanksBlitz_x4tje2y229k00" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "828B5831.HiddenCityMysteryofShadows_ytsefhwckbdv6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "828B5831.TheSecretSociety-HiddenMystery_ytsefhwckbdv6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "89006A2E.AutodeskSketchBook_tf1gferkr813w" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "9E2F88E3.Twitter_wgeqdkkx372wm" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.AsphaltStreetStormRacing_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.DisneyMagicKingdoms_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.DragonManiaLegends_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.MarchofEmpires_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "AdobeSystemsIncorporated.PhotoshopElements2018_ynb6jyjzte8ga" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "CAF9E577.Plex_aam28m9va5cke" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "DolbyLaboratories.DolbyAccess_rz1tebttyb220" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Drawboard.DrawboardPDF_gqbn7fs4pywxm" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Expedia.ExpediaHotelsFlightsCarsActivities_0wbx8rnn4qk5c" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.317180B0BB486_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.Facebook_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.InstagramBeta_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Fitbit.FitbitCoach_6mqt6hf9g46tw" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "flaregamesGmbH.RoyalRevolt2_g0q0z3kw54rap" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "GAMELOFTSA.Asphalt8Airborne_0pp20fcewvvtj" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.BubbleWitch3Saga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.CandyCrushSaga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.CandyCrushSodaSaga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.AgeCastles_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingNews_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingSports_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingWeather_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "microsoft.microsoftskydrive_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MinecraftUWP_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MSPaint_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "NAVER.LINEwin8_8ptj331gd3tyt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Nordcurrent.CookingFever_m9bz608c1b9ra" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "SiliconBendersLLC.Sketchable_r2kxzpx527qgj" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "SpotifyAB.SpotifyMusic_zpdnekdrzrea0" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "ThumbmunkeysLtd.PhototasticCollage_nfy108tqq3p12" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "USATODAY.USATODAY_wy7mw3214mat8" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "WinZipComputing.WinZipUniversal_3ykzqggjzj4z0" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Network Location Wizard prompts
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" /f 1>NUL 2>NUL

@echo Disable Gamebar
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Game Mode
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable automatic updates
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Change Performance Options to Adjust for best appearence
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo File Explorer opens to This PC
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable Aero Shake
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable "Look for an app in the Store" dialogue
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable "You have new apps that can open this type of file" notification
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable Automatic Maintenance
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable "Windows protected your PC" dialogue
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable Malicious Software Removal Tool from installing
reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable Error Reporting
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Keep thumbnail cache upon Restart
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "Autorun" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "Autorun" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Increase System Restore point frequency
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Cortana
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Windows Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable JPEG wallpaper quality reducion
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d "100" /f 1>NUL 2>NUL

@echo Increase 15 file selection limit that hides context menu items
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "MultipleInvokePromptMinimum" /t REG_DWORD /d "999" /f 1>NUL 2>NUL

@echo Replace "Personalize" with "Appearance" in desktop context menu
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Personalize" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Personalize" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Personalize\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Personalize\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\DesktopBackground\Shell\Personalize" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance" /v "Icon" /t REG_SZ /d "display.dll,-1" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance" /v "MUIVerb" /t REG_SZ /d "Appearance" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance" /v "Position" /t REG_SZ /d "Bottom" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance" /v "Subcommands" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\01Background" /v "Icon" /t REG_SZ /d "imageres.dll,-110" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\01Background" /v "MUIVerb" /t REG_SZ /d "Background" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\01Background" /v "SettingsURI" /t REG_SZ /d "ms-settings:personalization-background" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\01Background\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\02Colors" /v "Icon" /t REG_SZ /d "themecpl.dll" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\02Colors" /v "MUIVerb" /t REG_SZ /d "Colors" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\02Colors" /v "SettingsURI" /t REG_SZ /d "ms-settings:personalization-colors" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\02Colors\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\03DesktopIcons" /v "Icon" /t REG_SZ /d "desk.cpl" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\03DesktopIcons" /v "MUIVerb" /t REG_SZ /d "Desktop Icons" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\03DesktopIcons\command" /v "" /t REG_SZ /d "rundll32 shell32.dll,Control_RunDLL desk.cpl,,0" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\04LockScreen" /v "Icon" /t REG_SZ /d "imageres.dll,285" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\04LockScreen" /v "MUIVerb" /t REG_SZ /d "Lock Screen" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\04LockScreen" /v "SettingsURI" /t REG_SZ /d "ms-settings:lockscreen" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\04LockScreen\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\05MousePointers" /v "Icon" /t REG_SZ /d "main.cpl" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\05MousePointers" /v "MUIVerb" /t REG_SZ /d "Mouse Pointers" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\05MousePointers\command" /v "" /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\06ScreenSaver" /v "Icon" /t REG_SZ /d "PhotoScreensaver.scr" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\06ScreenSaver" /v "MUIVerb" /t REG_SZ /d "Screen Saver" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\06ScreenSaver\command" /v "" /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,screensaver,@screensaver" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\07Sounds" /v "Icon" /t REG_SZ /d "mmsys.cpl" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\07Sounds" /v "MUIVerb" /t REG_SZ /d "Sounds" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\07Sounds\command" /v "" /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl ,2" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\08Taskbar" /v "Icon" /t REG_SZ /d "shell32.dll,-40" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\08Taskbar" /v "MUIVerb" /t REG_SZ /d "Taskbar" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\08Taskbar" /v "SettingsURI" /t REG_SZ /d "ms-settings:taskbar" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\08Taskbar\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL

@echo Replace "Display Settings" with "Settings" in desktop context menu
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Display" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Display" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Display\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Display\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\DesktopBackground\Shell\Display" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings" /v "MUIVerb" /t REG_SZ /d "Settings" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings" /v "Position" /t REG_SZ /d "Bottom" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings" /v "Subcommands" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\01Accounts" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\01Accounts" /v "MUIVerb" /t REG_SZ /d "Accounts" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\01Accounts" /v "SettingsURI" /t REG_SZ /d "ms-settings:yourinfo" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\01Accounts\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\02Apps" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\02Apps" /v "MUIVerb" /t REG_SZ /d "Apps" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\02Apps" /v "SettingsURI" /t REG_SZ /d "ms-settings:appsfeatures" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\02Apps\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\03Devices" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\03Devices" /v "MUIVerb" /t REG_SZ /d "Devices" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\03Devices" /v "SettingsURI" /t REG_SZ /d "ms-settings:bluetooth" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\03Devices\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\04Display" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\04Display" /v "MUIVerb" /t REG_SZ /d "Display" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\04Display" /v "SettingsURI" /t REG_SZ /d "ms-settings:display" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\04Display\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\05Ease" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\05Ease" /v "MUIVerb" /t REG_SZ /d "Ease of Access" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\05Ease" /v "SettingsURI" /t REG_SZ /d "ms-settings:easeofaccess-narrator" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\05Ease\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\06Gaming" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\06Gaming" /v "MUIVerb" /t REG_SZ /d "Gaming" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\06Gaming" /v "SettingsURI" /t REG_SZ /d "ms-settings:gaming-gamebar" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\06Gaming\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\07Network" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\07Network" /v "MUIVerb" /t REG_SZ /d "Network && Internet" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\07Network" /v "SettingsURI" /t REG_SZ /d "ms-settings:network" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\07Network\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\08Personalization" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\08Personalization" /v "MUIVerb" /t REG_SZ /d "Personalization" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\08Personalization" /v "SettingsURI" /t REG_SZ /d "ms-settings:themes" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\08Personalization\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\09Phone" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\09Phone" /v "MUIVerb" /t REG_SZ /d "Phone" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\09Phone" /v "SettingsURI" /t REG_SZ /d "ms-settings:mobile-devices" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\09Phone\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\10Privacy" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\10Privacy" /v "MUIVerb" /t REG_SZ /d "Privacy" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\10Privacy" /v "SettingsURI" /t REG_SZ /d "ms-settings:privacy" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\10Privacy\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\11Search" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\11Search" /v "MUIVerb" /t REG_SZ /d "Search" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\11Search" /v "SettingsURI" /t REG_SZ /d "ms-settings:cortana" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\11Search\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\12Time" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\12Time" /v "MUIVerb" /t REG_SZ /d "Time && Language" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\12Time" /v "SettingsURI" /t REG_SZ /d "ms-settings:dateandtime" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\12Time\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\13Update" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\13Update" /v "MUIVerb" /t REG_SZ /d "Update && Security" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\13Update" /v "SettingsURI" /t REG_SZ /d "ms-settings:windowsupdate" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\13Update\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL

@echo Add "Open Command Prompt here" to context menus
SetACL.exe -silent -on "HKCR\Directory\shell\cmd" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\shell\cmd" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\Directory\shell\cmd\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\shell\cmd\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\Directory\shell\cmd" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "" /t REG_SZ /d "Open Command Prompt here" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "Icon" /t REG_SZ /d "cmd.exe" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "NeverDefault" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "Position" /t REG_SZ /d "Top" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f 1>NUL 2>NUL
reg delete "HKCR\Directory\Background\shell\cmd" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "" /t REG_SZ /d "Open Command Prompt here" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "Icon" /t REG_SZ /d "cmd.exe" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "NeverDefault" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "Position" /t REG_SZ /d "Top" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "" /t REG_SZ /d "Open Command Prompt here" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "Icon" /t REG_SZ /d "cmd.exe" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "NeverDefault" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "Position" /t REG_SZ /d "Top" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "" /t REG_SZ /d "Open Command Prompt here" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "Icon" /t REG_SZ /d "cmd.exe" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "NeverDefault" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "Position" /t REG_SZ /d "Top" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f 1>NUL 2>NUL

@echo Remove "Open PowerShell window here" from Shift+Right-click context menus
SetACL.exe -silent -on "HKCR\Directory\shell\Powershell" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\shell\Powershell" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\Directory\shell\Powershell\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\shell\Powershell\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\Directory\shell\Powershell" /f 1>NUL 2>NUL
SetACL.exe -silent -on "HKCR\Directory\Background\shell\Powershell" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\Background\shell\Powershell" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\Directory\Background\shell\Powershell\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\Background\shell\Powershell\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\Directory\Background\shell\Powershell" /f 1>NUL 2>NUL

@echo Enable Windows Installer in Safe Mode
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /v "" /t REG_SZ /d "Service" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /v "" /t REG_SZ /d "Service" /f 1>NUL 2>NUL

@echo Increase 3 pinned contacts limit on taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "TaskbarCapacity" /t REG_DWORD /d "999" /f 1>NUL 2>NUL

@echo Disable online tips in Settings
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Set "Do this for all current items" checked by default
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "ConfirmationCheckBoxDoForAll" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Add ".bat" to "New" submenu of Desktop context menu
reg add "HKLM\Software\Classes\.bat\ShellNew" /v "NullFile" /t REG_SZ /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Classes\.bat\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\Windows\System32\acppage.dll,-6002" /f 1>NUL 2>NUL

@echo Add ".reg" to "New" submenu of Desktop context menu
reg add "HKLM\Software\Classes\.reg\ShellNew" /v "NullFile" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKLM\Software\Classes\.reg\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\WINDOWS\regedit.exe,-309" /f 1>NUL 2>NUL

@echo Disable wide context menu
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Remove Desktop from This PC
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f 1>NUL 2>NUL

@echo Remove Documents from This PC
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f 1>NUL 2>NUL

@echo Remove Downloads from This PC
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f 1>NUL 2>NUL

@echo Remove Music from This PC
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f 1>NUL 2>NUL

@echo Remove Pictures from This PC
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f 1>NUL 2>NUL

@echo Remove Videos from This PC
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f 1>NUL 2>NUL

@echo Remove 3D Objects from This PC
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f 1>NUL 2>NUL

@echo Disable search history in File Explorer
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Remove OneDrive from Navigation Pane
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Remove Network from Navigation Pane
reg add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Remove external drives from Navigation Pane
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f 1>NUL 2>NUL

@echo Disable suggested apps Windows Ink WorkSpace
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceAppSuggestionsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Classes\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}" /v "AllowSuggestedAppsInWindowsInkWorkspace" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Sharing of handwriting data
reg add "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable Sharing of handwriting error reports
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable Inventory Collector
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable Camera in login screen
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\AccessPage\Camera" /v "CameraEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Advertising ID
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Id" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Id" /f 1>NUL 2>NUL

@echo Disable transmission of typing information
reg add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Microsoft conducting experiments with this machine
reg add "HKLM\Software\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable advertisements via Bluetooth
reg add "HKLM\Software\Microsoft\PolicyManager\current\device\Bluetooth" /v "AllowAdvertising" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Windows Customer Experience Improvement Program
reg add "HKLM\Software\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable syncing of text messages to Microsoft
reg add "HKLM\Software\Policies\Microsoft\Windows\Messaging" /v "AllowMessageSync" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable application access to user account information
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f 1>NUL 2>NUL

@echo Disable tracking of application startups
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable application access of diagnostic information
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}" /v "Value" /t REG_SZ /d "Deny" /f 1>NUL 2>NUL

@echo Disable password reveal Button
reg add "HKLM\Software\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable user steps recorder
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable telemetry
reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable synchronization of all settings to Microsoft
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f 1>NUL 2>NUL

@echo Disable Input Personalization
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicyy" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable updates for Speech Recognition and Speech Synthesis
reg add "HKLM\Software\Microsoft\Speech_OneCore\Preferences" /v "ModelDownloadAllowed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Speech" /v "AllowSpeechModelUpdate" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable functionality to locate the system
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Disable peer-to-peer functionality in Windows Update
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable ads in File Explorer and OneDrive
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable feedback reminders
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Remove Search/Cortana from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Remove Task View button from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Remove People Button from taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Hide frequently used folders in "Quick access"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Hide recent files in "Quick access"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Timeline
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Enable clipboard history
reg add "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Set OEM logo
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Logo" /t REG_SZ /d "C:\Windows\Custom\logo.bmp" /f 1>NUL 2>NUL

@echo Disable Open File security warning
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t "REG_DWORD" /d "00000000" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t "REG_DWORD" /d "00000000" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Security" /v "DisableSecuritySettingsCheck" /t "REG_DWORD" /d "00000001" /f 1>NUL 2>NUL

@echo Remove "Edit with photos" from context menus
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ActivatableClassId" /t REG_SZ /d "App.AppX65n3t4j73ch7cremsjxn7q8bph1ma8jw.mca" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "PackageId" /t REG_SZ /d "Microsoft.Windows.Photos_2017.18062.12990.0_x64__8wekyb3d8bbwe" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ContractId" /t REG_SZ /d "Windows.File" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "DesiredInitialViewState" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "" /t REG_SZ /d "@{Microsoft.Windows.Photos_2017.18062.12990.0_x64__8wekyb3d8bbwe?ms-resource://Microsoft.Windows.Photos/Resources/EditWithPhotos}" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ProgrammaticAccessOnly" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit\command" /v "DelegateExecute" /t REG_SZ /d "{4ED3A719-CEA8-4BD9-910D-E252F997AFC2}" /f 1>NUL 2>NUL

@echo Remove "Edit with Paint 3D" from context menus
reg delete "HKLM\Software\Classes\SystemFileAssociations\.bmp\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpe\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.png\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.gif\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.tif\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.tiff\Shell\3D Edit" /f 1>NUL 2>NUL

@echo Remove "Include in library" from context menus
reg delete "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f 1>NUL 2>NUL

@echo Disable Microsoft Edge prelaunching
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowPrelaunch" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Disable Microsoft Edge tab preloading
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowTabPreloading" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Change active title bar color to black
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "AccentPalette" /t REG_BINARY /d "6B 6B 6B FF 59 59 59 FF 4C 4C 4C FF 3F 3F 3F FF 33 33 33 FF 26 26 26 FF 14 14 14 FF 88 17 98 00" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "StartColorMenu" /t REG_DWORD /d "4281545523" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "AccentColorMenu" /t REG_DWORD /d "4278190080" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "AccentColor" /t REG_DWORD /d "4278190080" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3288334336" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3288334336" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Change inactive title bar color to grey
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "AccentColorInactive" /t REG_DWORD /d "4280953386" /f 1>NUL 2>NUL

@echo Remove acrylic blur on sign-in screen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableAcrylicBackgroundOnLogon" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Apply Classic Shell settings
cd C:\Program Files\Classic Shell 1>NUL 2>NUL
ClassicStartMenu.exe -xml "C:\Windows\Custom\startmenu.xml" 1>NUL 2>NUL

@echo Delete startup shortcut
del /f /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\startup.bat" 1>NUL 2>NUL
@timeout 1 /nobreak

@echo Disabling HPET
bcdedit /deletevalue useplatformclock
bcdedit /set disabledynamictick yes

@echo Network Tweaks
netsh int tcp set heuristics disabled

@echo Power CFG
powercfg /setactive scheme_min >nul
powercfg /change -monitor-timeout-ac 0 >nul
powercfg /change -disk-timeout-ac 0 >nul
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 10 >nul

@echo Disabling driver signature verification
verifier /reset

@echo Disabling Firewall
netsh advfirewall set allprofiles state off >nul

@echo Starting registry editor
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SynAttackProtect" /t REG_SZ /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_SZ /d "0" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_SZ /d "1" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "Size" /t REG_SZ /d "3" /f
@Reg.exe add "HKCR\*\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
@Reg.exe add "HKCR\*\shell\TakeOwnership" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\*\shell\TakeOwnership" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\*\shell\TakeOwnership" /v "NeverDefault" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\Directory\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
@Reg.exe add "HKCR\Directory\shell\TakeOwnership" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\Directory\shell\TakeOwnership" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\Directory\shell\TakeOwnership" /v "NeverDefault" /t REG_SZ /d "" /f
REM ; Отключить Кортану
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
REM ; Отключить историю поиска
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "ShippedWithReserves" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "EnableWsd" /t REG_SZ /d "0" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "EnableDCA" /t REG_SZ /d "1" /f
REM ; Отключить автоматическое скрытие полос прокрутки
@Reg.exe add "HKCU\Control Panel\Accessibility" /v "DynamicScrollbars" /t REG_DWORD /d "0" /f
REM ; Ускорить проводник и завершение процессов
@Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
@Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "3000" /f
@Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "100" /f
@Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "3000" /f
@Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "3000" /f
REM ; Разрешить исправлять размытость DPI
@Reg.exe add "HKCU\Control Panel\Desktop" /v "EnablePerProcessSystemDPI" /t REG_DWORD /d "1" /f
REM ; Использование 100% качества картинки
@Reg.exe add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d "100" /f
REM ; Запретить веб-сайтам доступ к списку языков
@Reg.exe add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
REM ; Отключить предложение настроить Интернет
@Reg.exe add "HKCU\Software\Microsoft\Internet Connection Wizard" /v "Completed" /t REG_DWORD /d "1" /f
REM ; Запретить приложениям работать в фоновом режиме
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f
REM ; Ускорить автозагрузку программ
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d "0" /f
REM ; Запретить отслеживать запуски приложений
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f
REM ; Отключить индетификатор рекламы
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
REM ; Отключить советы и рекомендации от Microsoft
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
REM ; Получать обновления только от Microsoft
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownLoadMode" /t REG_DWORD /d "1" /f
REM ; Отключить автозапуск
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d "1" /f
REM ; Отключить GameDVR
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
REM ; Отключить GameDVR
@Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "fffffff" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_SZ /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_SZ /d "2" /f
REM ; Отключить встроенную проверку подлинности Windows
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "EnableNegotiate" /t REG_DWORD /d "0" /f
REM ; Отключить предупреждение о просмотре веб-страницы через безопасное соединение
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "WarnonZoneCrossing" /t REG_DWORD /d "0" /f
REM ; Отключить предупреждение "Информация переданная через Интернет..."
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1601" /t REG_DWORD /d "0" /f
REM ; Отключить сихронизацию
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f
REM ; Отключить сихронизацию
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f
REM ; Скрыть текст инструкций в ножницах
@Reg.exe add "HKCU\Software\Microsoft\Windows\TabletPC\Snipping Tool" /v "DisplaySnipInstructions" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\TabletPC\Snipping Tool" /v "IsScreenSketchBannerExpanded" /t REG_DWORD /d "0" /f
REM ; Отключить персонализацию рукописного ввода
@Reg.exe add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
REM ; Отключить формирование отзывов
@Reg.exe add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d "0" /f
REM ; Запретить приложеним использовать голосовую активацию
@Reg.exe add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationOnLockScreenEnabled" /t REG_DWORD /d "0" /f
REM ; Скрыть вкладку "Предыдущие версии"
@Reg.exe add "HKCU\Software\Policies\Microsoft\PreviousVersions" /v "DisableLocalPage" /t REG_DWORD /d "1" /f
REM ; Отключить возможность участия в программе по улучшению справки
@Reg.exe add "HKCU\Software\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Policies\Microsoft\Assistance\Client\1.0" /v "NoImplicitFeedback" /t REG_DWORD /d "1" /f
REM ; Отключить "Ознакомиться с другими результами поиска..."
@Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f
REM ; Показывать полностью имена длинных файлов в проводнике
@Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "0" /f
REM ;  Отключить автоматическое обучение
@Reg.exe add "HKCU\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f
REM ; Отключить автозапуск диктора
@Reg.exe add "HKCU\Control Panel\Accessibility\SlateLaunch" /v "LaunchAT" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Control Panel\Accessibility\SlateLaunch" /v "ATapp" /t REG_SZ /d "" /f
REM ; Отключить залипание SHIFT
@Reg.exe add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
REM ; Включить звук переключения CAPS
@Reg.exe add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "63" /f
REM ; Включить "NumLock"
@Reg.exe add "HKCU\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Page" /t REG_SZ /d "https://google.com/" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d "https://google.com/" /f
REM ; Отключить мастер первого запуска
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10RunOncePerInstallCompleted" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10TourNoShow" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10TourShown" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10TourShownTime" /t REG_BINARY /d "00" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10RunOnceCompletionTime" /t REG_BINARY /d "00" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10RecommendedSettingsNo" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10RunOnceLastShown_TIMESTAMP" /t REG_BINARY /d "00" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d "1" /f
REM ; Предотвратить повторное использование окна Internet Explorer
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "AllowWindowReuse" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d "1" /f
REM ; Отключить использование рекомендуемых сайтов
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "0" /f
REM ; Открывать всплывающие окна в новой вкладке
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "PopupsUseNewWindow" /t REG_DWORD /d "2" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "NewTabPageShow" /t REG_DWORD /d "2" /f
REM ; Не предупреждать об одновременном закрытии вкладок
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "WarnOnClose" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "ShowTabsWelcome" /t REG_DWORD /d "0" /f
REM ; Всегда переключаться на новую вкладку при ее создании
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "OpenInForeground" /t REG_DWORD /d "1" /f
REM ;Открывать ранее открытые вкладки IE
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\ContinuousBrowsing" /v "Enabled" /t REG_DWORD /d "1" /f
REM ; Запретить доступ к диагностическим данным
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к календарю
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к сотовой связи
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к сообщениям
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к контактам
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к эл. почте
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить программный снимок экрана
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить запрашивать отключение рамки экрана
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к месторасположению
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Разрешить доступ к микрофону
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f
REM ; Запретить приложениям совершать звонки
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к журналу вызовов
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Разрешить доступ к радиомодулям
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Allow" /f
REM ; Запретить доступ к учетной записи
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Разрешить доступ к задачам
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Allow" /f
REM ; Разрешить доступ к уведомлениям
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Allow" /f
REM ; Разрешить доступ к вебкамере
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /t REG_SZ /d "Allow" /f
REM ; =============================== LTSB 1607 ================================
REM ; Разрешить доступ к камере
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Разрешить доступ к микрофону
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Разрешить доступ к уведомлениям
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
REM ; Запретить доступ к контактам
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить доступ к календарю
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить доступ к журналу вызовов
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить доступ к эл. почте
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Разрешить доступ к задачам
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить доступ к сообщениям
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Разрешить доступ к радиомодулям
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить синхронизацию с беспроводными устройствами
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Автоматическое принятие соглашения WMP
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "GroupPrivacyAcceptance" /t REG_DWORD /d "1" /f
REM ; Принять лицензионное соглашение
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AcceptedPrivacyStatement" /t REG_DWORD /d "1" /f
REM ; AddVideosFromPicturesLibrary
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AddVideosFromPicturesLibrary" /t REG_DWORD /d "0" /f
REM ; Отключить автоматическое добавление музыки в библиотеку
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddMusicToLibrary" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddVideoToLibrary" /t REG_DWORD /d "0" /f
REM ; Не удалять файлы с компьютера при удалении из библиотеки
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DeleteRemovesFromComputer" /t REG_DWORD /d "0" /f
REM ; Запретить автоматическую проверку лицензий
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableLicenseRefresh" /t REG_DWORD /d "1" /f
REM ; Отключить мастер первого запуска
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "FirstRun" /t REG_DWORD /d "0" /f
REM ; Не сохранять оценки в файлах мультимедиа
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "FlushRatingsToFiles" /t REG_DWORD /d "0" /f
REM ; Не обновлять содержимое библиотеки при первом запуске
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "LibraryHasBeenRun" /t REG_DWORD /d "1" /f
REM ; Не показывать сведения о мультимедиа из Интернета и не обновлять файлы
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "MetadataRetrieval" /t REG_DWORD /d "0" /f
REM ; Отключить загрузку лицензий на использование файлов мультимедиа
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentAcquisition" /t REG_DWORD /d "0" /f
REM ; Не устанавливать автоматически часы на устройсвтах
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentDRMConfiguration" /t REG_DWORD /d "0" /f
REM ; Не сохранять историю открытых файлов
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRU" /t REG_DWORD /d "1" /f
REM ; Не отправлять данные об использовании проигрывателя в Microsoft
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f
REM ; Отключить идентификацию Windows Media Player на интернет-сайтах
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SendUserGUID" /t REG_BINARY /d "00" /f
REM ; Отключить обновление Windows Media Player
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AskMeAgain" /t REG_SZ /d "No" /f
REM ; Не использовать Windows Media Player в online справочниках
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "StartInMediaGuide" /t REG_DWORD /d "0" /f
REM ; Отключить "Проигрыватель по размеру видео при запуске"
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SnapToVideoV11" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
@Reg.exe delete "HKLM\SOFTWARE\Classes\.bmp\ShellNew" /f
@Reg.exe delete "HKLM\SOFTWARE\Classes\.contact\ShellNew" /f
@Reg.exe delete "HKLM\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\ModernSharing" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\.bat\ShellNew" /v "Data" /t REG_SZ /d "@echo off" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\.reg\ShellNew" /v "Data" /t REG_SZ /d "Windows Registry Editor Version 5.00" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\CABFolder\Shell\RunAs" /ve /t REG_SZ /d "@%%SystemRoot%%\System32\msimsg.dll,-36" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\CABFolder\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\CABFolder\Shell\RunAs" /v "Extended" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\*\shell\edit" /v "Extended" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\*\shell\edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\NOTEPAD.EXE %%1" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\Msi.Package\shell\Extract" /ve /t REG_SZ /d "@%%SystemRoot%%\system32\shell32.dll,-37514" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\Msi.Package\shell\Extract" /v "Extended" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\.appx" /ve /t REG_SZ /d "appxfile" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\.appxbundle" /ve /t REG_SZ /d "appxbundlefile" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxfile\Shell\RunAs" /ve /t REG_SZ /d "@%%SystemRoot%%\System32\msimsg.dll,-36" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxfile\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxbundlefile\Shell\RunAs" /ve /t REG_SZ /d "@%%SystemRoot%%\System32\msimsg.dll,-36" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxbundlefile\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxfile\DefaultIcon" /ve /t REG_SZ /d "imageres.dll,-175" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxbundlefile\DefaultIcon" /ve /t REG_SZ /d "imageres.dll,-175" /f
REM ; Отключить дистанционное отслеживание приложений
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
REM ; Запретить показ уведомлений Майкрософт с предложением отправить отзыв
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f
REM ; Отключить кортану
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f
REM ; Отключить синхронизацию приложенй
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "EnableBackupForWin8Apps" /t REG_DWORD /d "0" /f
REM ;Отключить сбор данных InPrivate
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Safety\PrivacIE" /v "DisableLogging" /t REG_DWORD /d "1" /f
REM ; Отключить сбор и хранение текста и рукописных данных
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
REM ; Отключить отправку образцов рукописного ввода
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f
REM ; Не передавать отчеты об ошибках распознавания рукописного ввода
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "Disabled" /t REG_DWORD /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "DisableAutomaticTelemetryKeywordReporting" /t REG_DWORD /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "TelemetryServiceDisabled" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\TestHooks" /v "DisableAsimovUpload" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\PerfTrack" /v "Disabled" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AppModel" /v "Start" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "" /f
@Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f
REM ; Удалить из панели навигации "Съёмные диски"
@Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f
REM ; Удалить из панели навигации "Съёмные диски"
REM ; Отключить рекомендуемые приложения
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
REM ; Запретить эксперименты на этом компьтере
@Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f
REM ; Отключить получение инсайдерских сборок Windows
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableConfigFlighting" /t REG_DWORD /d "0" /f
REM ; Скрыть "Программа предварительной оценки"
@Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "HideInsiderPage" /t REG_DWORD /d "1" /f
REM ; Отключить программу по улучшению качества программного обеспечения Windows
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
REM ; Разрешить установку неопубликованых приложений
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowAllTrustedApps" /t REG_DWORD /d "1" /f
REM ; Разрешить приложения из любых источников
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AicEnabled" /t REG_SZ /d "Anywhere" /f
REM ; Прозрачность панели задач
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLEDTaskbarTransparency" /t REG_DWORD /d "1" /f
REM ; Запретить приложениям с других устройств открывать приложения на этом устройстве
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /v "UserAuthPolicy" /t REG_DWORD /d "0" /f
REM ; Отключить автообновление плитко-приложений
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d "2" /f
REM ; Отключить загрузку обновлений с других компьютеров
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode_BackCompat" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f
REM ; Отключить загрузку обновлений с других компьютеров
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadModeProvider" /t REG_DWORD /d "8" /f
REM ; Отключить загрузку улучшеных значков устройств
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
REM ; Разрешить локальные сценарии и удалённые подписанные сценарии
@Reg.exe add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "RemoteSigned" /f
REM ; Разрешить локальные сценарии и удалённые подписанные сценарии
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "RemoteSigned" /f
REM ;Файл подкачки оптимиз.
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "c:\pagefile.sys 1024 2048" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ExistingPageFiles" /t REG_MULTI_SZ /d "\??\C:\pagefile.sys" /f
REM ; Отключить автообновление карт
@Reg.exe add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d "0" /f
REM ; Prefetcher, Superfetch: 2 – ускорение только загрузки системы, 3 – ускорение загрузки системы и запуска приложений
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "2" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "2" /f
REM ; Разрешить гостевой вход (для доступа к расшаренным папкам)
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d "1" /f
REM ; Не расширять динамические VHD до максимума
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /t REG_DWORD /d "4" /f
REM ; Стандартная служба сборщика центра диагностики Microsoft
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f
REM ; Служба функциональных возможностей для подключенных пользователей и телеметрии
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
REM ; Служба помощника по совместимости программ
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f
REM ; Служба демонстрации магазина
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\RetailDemo" /v "Start" /t REG_DWORD /d "4" /f
REM ; Служба Medic центра обновления Windows
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableVirtualization" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\WSearch" /v "Start" /t REG_DWORD /d "4" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\SysMain" /v "Start" /t REG_DWORD /d "4" /f


del /f C:\Windows\System32\SetACL.exe
@start explorer.exe

@echo Done
Goto MenuEng

:OptimizingR

copy SetACL.exe C:\Windows\System32
@echo Отключение ненужных процессов
@taskkill /F /IM "MicrosoftEdge.exe" 1>NUL 2>NUL
@taskkill /F /IM "explorer.exe" 1>NUL 2>NUL

bcdedit /set {default} bootmenupolicy legacy 1>NUL 2>NUL

@echo Удаление OneDrive
taskkill /F /IM "OneDrive.exe" 1>NUL 2>NUL
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall 1>NUL 2>NUL
rd "%UserProfile%\OneDrive" /Q /S 1>NUL 2>NUL
rd "%LocalAppData%\Microsoft\OneDrive" /Q /S 1>NUL 2>NUL
rd "%ProgramData%\Microsoft OneDrive" /Q /S 1>NUL 2>NUL
rd "C:\OneDriveTemp" /Q /S 1>NUL 2>NUL

@echo Добавление переменных среды
setx ProgramFiles "C:\Program Files" /m 1>NUL 2>NUL
setx ProgramFiles86 "C:\Program Files (x86)" /m 1>NUL 2>NUL
setx ProgramData "C:\ProgramData" /m 1>NUL 2>NUL

@echo Скрыть папку PerfLogs
attrib "C:\PerfLogs" +h 1>NUL 2>NUL

@echo Показать общую папку рабочего стола
attrib "C:\Users\Public\Desktop" -h 1>NUL 2>NUL
powercfg /h /type reduced 1>NUL 2>NUL
del /f /q "C:\Users\%USERNAME%\Desktop\Microsoft Edge.lnk" 1>NUL 2>NUL
del /f /q "C:\Users\%USERNAME%\Desktop\Your Phone.lnk" 1>NUL 2>NUL

@echo Отключение сервисов
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL

@echo Включение режима разработчика
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowDevelopmentWithoutDevLicense" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowAllTrustedApps" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowStatusBar" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Lock Screen" /v "SlideshowEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Включение тёмного режима
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /v "ShortcutNameTemplate" /t REG_SZ /d "\"%%s.lnk\"" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewDesktop" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableFirstLogonAnimation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "22StokedOnIt.NotebookPro_ffs55s3hze5sr" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "2FE3CB00.PicsArt-PhotoStudio_crhqpqs3x1ygc" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "41038Axilesoft.ACGMediaPlayer_wxjjre7dryqb6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "5CB722CC.SeekersNotesMysteriesofDarkwood_ypk0bew5psyra" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "7458BE2C.WorldofTanksBlitz_x4tje2y229k00" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "828B5831.HiddenCityMysteryofShadows_ytsefhwckbdv6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "828B5831.TheSecretSociety-HiddenMystery_ytsefhwckbdv6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "89006A2E.AutodeskSketchBook_tf1gferkr813w" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "9E2F88E3.Twitter_wgeqdkkx372wm" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.AsphaltStreetStormRacing_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.DisneyMagicKingdoms_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.DragonManiaLegends_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.MarchofEmpires_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "AdobeSystemsIncorporated.PhotoshopElements2018_ynb6jyjzte8ga" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "CAF9E577.Plex_aam28m9va5cke" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "DolbyLaboratories.DolbyAccess_rz1tebttyb220" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Drawboard.DrawboardPDF_gqbn7fs4pywxm" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Expedia.ExpediaHotelsFlightsCarsActivities_0wbx8rnn4qk5c" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.317180B0BB486_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.Facebook_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.InstagramBeta_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Fitbit.FitbitCoach_6mqt6hf9g46tw" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "flaregamesGmbH.RoyalRevolt2_g0q0z3kw54rap" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "GAMELOFTSA.Asphalt8Airborne_0pp20fcewvvtj" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.BubbleWitch3Saga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.CandyCrushSaga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.CandyCrushSodaSaga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.AgeCastles_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingNews_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingSports_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingWeather_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "microsoft.microsoftskydrive_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MinecraftUWP_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MSPaint_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "NAVER.LINEwin8_8ptj331gd3tyt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Nordcurrent.CookingFever_m9bz608c1b9ra" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "SiliconBendersLLC.Sketchable_r2kxzpx527qgj" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "SpotifyAB.SpotifyMusic_zpdnekdrzrea0" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "ThumbmunkeysLtd.PhototasticCollage_nfy108tqq3p12" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "USATODAY.USATODAY_wy7mw3214mat8" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "WinZipComputing.WinZipUniversal_3ykzqggjzj4z0" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" /f 1>NUL 2>NUL
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение Game Mode
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение автоматических обновлений
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Отключение уведомления "Windows защитила ваш компьютер"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "Autorun" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "Autorun" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение кортаны
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Windows Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Отключение снижения качества обоев JPEG
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d "100" /f 1>NUL 2>NUL

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "MultipleInvokePromptMinimum" /t REG_DWORD /d "999" /f 1>NUL 2>NUL
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Personalize" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Personalize" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Personalize\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Personalize\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\DesktopBackground\Shell\Personalize" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance" /v "Icon" /t REG_SZ /d "display.dll,-1" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance" /v "MUIVerb" /t REG_SZ /d "Appearance" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance" /v "Position" /t REG_SZ /d "Bottom" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance" /v "Subcommands" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\01Background" /v "Icon" /t REG_SZ /d "imageres.dll,-110" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\01Background" /v "MUIVerb" /t REG_SZ /d "Background" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\01Background" /v "SettingsURI" /t REG_SZ /d "ms-settings:personalization-background" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\01Background\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\02Colors" /v "Icon" /t REG_SZ /d "themecpl.dll" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\02Colors" /v "MUIVerb" /t REG_SZ /d "Colors" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\02Colors" /v "SettingsURI" /t REG_SZ /d "ms-settings:personalization-colors" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\02Colors\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\03DesktopIcons" /v "Icon" /t REG_SZ /d "desk.cpl" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\03DesktopIcons" /v "MUIVerb" /t REG_SZ /d "Desktop Icons" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\03DesktopIcons\command" /v "" /t REG_SZ /d "rundll32 shell32.dll,Control_RunDLL desk.cpl,,0" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\04LockScreen" /v "Icon" /t REG_SZ /d "imageres.dll,285" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\04LockScreen" /v "MUIVerb" /t REG_SZ /d "Lock Screen" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\04LockScreen" /v "SettingsURI" /t REG_SZ /d "ms-settings:lockscreen" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\04LockScreen\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\05MousePointers" /v "Icon" /t REG_SZ /d "main.cpl" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\05MousePointers" /v "MUIVerb" /t REG_SZ /d "Mouse Pointers" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\05MousePointers\command" /v "" /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\06ScreenSaver" /v "Icon" /t REG_SZ /d "PhotoScreensaver.scr" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\06ScreenSaver" /v "MUIVerb" /t REG_SZ /d "Screen Saver" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\06ScreenSaver\command" /v "" /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,screensaver,@screensaver" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\07Sounds" /v "Icon" /t REG_SZ /d "mmsys.cpl" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\07Sounds" /v "MUIVerb" /t REG_SZ /d "Sounds" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\07Sounds\command" /v "" /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl ,2" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\08Taskbar" /v "Icon" /t REG_SZ /d "shell32.dll,-40" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\08Taskbar" /v "MUIVerb" /t REG_SZ /d "Taskbar" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\08Taskbar" /v "SettingsURI" /t REG_SZ /d "ms-settings:taskbar" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\01Appearance\Shell\08Taskbar\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL

@echo Заменение "Настройки дисплея" на "Настройки" в контекстном меню рабочего стола
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Display" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Display" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Display\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\DesktopBackground\Shell\Display\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\DesktopBackground\Shell\Display" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings" /v "MUIVerb" /t REG_SZ /d "Settings" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings" /v "Position" /t REG_SZ /d "Bottom" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings" /v "Subcommands" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\01Accounts" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\01Accounts" /v "MUIVerb" /t REG_SZ /d "Accounts" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\01Accounts" /v "SettingsURI" /t REG_SZ /d "ms-settings:yourinfo" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\01Accounts\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\02Apps" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\02Apps" /v "MUIVerb" /t REG_SZ /d "Apps" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\02Apps" /v "SettingsURI" /t REG_SZ /d "ms-settings:appsfeatures" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\02Apps\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\03Devices" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\03Devices" /v "MUIVerb" /t REG_SZ /d "Devices" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\03Devices" /v "SettingsURI" /t REG_SZ /d "ms-settings:bluetooth" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\03Devices\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\04Display" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\04Display" /v "MUIVerb" /t REG_SZ /d "Display" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\04Display" /v "SettingsURI" /t REG_SZ /d "ms-settings:display" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\04Display\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\05Ease" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\05Ease" /v "MUIVerb" /t REG_SZ /d "Ease of Access" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\05Ease" /v "SettingsURI" /t REG_SZ /d "ms-settings:easeofaccess-narrator" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\05Ease\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\06Gaming" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\06Gaming" /v "MUIVerb" /t REG_SZ /d "Gaming" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\06Gaming" /v "SettingsURI" /t REG_SZ /d "ms-settings:gaming-gamebar" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\06Gaming\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\07Network" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\07Network" /v "MUIVerb" /t REG_SZ /d "Network && Internet" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\07Network" /v "SettingsURI" /t REG_SZ /d "ms-settings:network" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\07Network\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\08Personalization" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\08Personalization" /v "MUIVerb" /t REG_SZ /d "Personalization" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\08Personalization" /v "SettingsURI" /t REG_SZ /d "ms-settings:themes" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\08Personalization\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\09Phone" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\09Phone" /v "MUIVerb" /t REG_SZ /d "Phone" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\09Phone" /v "SettingsURI" /t REG_SZ /d "ms-settings:mobile-devices" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\09Phone\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\10Privacy" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\10Privacy" /v "MUIVerb" /t REG_SZ /d "Privacy" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\10Privacy" /v "SettingsURI" /t REG_SZ /d "ms-settings:privacy" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\10Privacy\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\11Search" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\11Search" /v "MUIVerb" /t REG_SZ /d "Search" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\11Search" /v "SettingsURI" /t REG_SZ /d "ms-settings:cortana" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\11Search\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\12Time" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\12Time" /v "MUIVerb" /t REG_SZ /d "Time && Language" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\12Time" /v "SettingsURI" /t REG_SZ /d "ms-settings:dateandtime" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\12Time\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\13Update" /v "Icon" /t REG_SZ /d "SystemSettingsBroker.exe" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\13Update" /v "MUIVerb" /t REG_SZ /d "Update && Security" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\13Update" /v "SettingsURI" /t REG_SZ /d "ms-settings:windowsupdate" /f 1>NUL 2>NUL
reg add "HKCR\DesktopBackground\Shell\02Settings\shell\13Update\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f 1>NUL 2>NUL
SetACL.exe -silent -on "HKCR\Directory\shell\cmd" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\shell\cmd" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\Directory\shell\cmd\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\shell\cmd\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\Directory\shell\cmd" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "" /t REG_SZ /d "Open Command Prompt here" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "Icon" /t REG_SZ /d "cmd.exe" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "NeverDefault" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas" /v "Position" /t REG_SZ /d "Top" /f 1>NUL 2>NUL
reg add "HKCR\Directory\shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f 1>NUL 2>NUL
reg delete "HKCR\Directory\Background\shell\cmd" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "" /t REG_SZ /d "Open Command Prompt here" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "Icon" /t REG_SZ /d "cmd.exe" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "NeverDefault" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas" /v "Position" /t REG_SZ /d "Top" /f 1>NUL 2>NUL
reg add "HKCR\Directory\Background\shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "" /t REG_SZ /d "Open Command Prompt here" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "Icon" /t REG_SZ /d "cmd.exe" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "NeverDefault" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas" /v "Position" /t REG_SZ /d "Top" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\Shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "" /t REG_SZ /d "Open Command Prompt here" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "Icon" /t REG_SZ /d "cmd.exe" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "NeverDefault" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas" /v "Position" /t REG_SZ /d "Top" /f 1>NUL 2>NUL
reg add "HKCR\LibraryFolder\background\shell\runas\command" /v "" /t REG_SZ /d "cmd.exe /s /k pushd \"%%V\"" /f 1>NUL 2>NUL

@echo Удаление "Открыть окно PowerShell здесь" из контекстного меню Shift+Щелчок правой кнопкой мыши
SetACL.exe -silent -on "HKCR\Directory\shell\Powershell" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\shell\Powershell" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\Directory\shell\Powershell\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\shell\Powershell\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\Directory\shell\Powershell" /f 1>NUL 2>NUL
SetACL.exe -silent -on "HKCR\Directory\Background\shell\Powershell" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\Background\shell\Powershell" -ot reg -actn ace -ace "n:Administrators;p:full"
SetACL.exe -silent -on "HKCR\Directory\Background\shell\Powershell\command" -ot reg -actn setowner -ownr "n:Administrators"
SetACL.exe -silent -on "HKCR\Directory\Background\shell\Powershell\command" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKCR\Directory\Background\shell\Powershell" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /v "" /t REG_SZ /d "Service" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /v "" /t REG_SZ /d "Service" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "TaskbarCapacity" /t REG_DWORD /d "999" /f 1>NUL 2>NUL

@echo Отключение онлайн-советов в настройках
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Установление флажка "Сделать это для всех текущих элементов" по умолчанию
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "ConfirmationCheckBoxDoForAll" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Classes\.bat\ShellNew" /v "NullFile" /t REG_SZ /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Classes\.bat\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\Windows\System32\acppage.dll,-6002" /f 1>NUL 2>NUL
reg add "HKLM\Software\Classes\.reg\ShellNew" /v "NullFile" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKLM\Software\Classes\.reg\ShellNew" /v "ItemName" /t REG_EXPAND_SZ /d "@C:\WINDOWS\regedit.exe,-309" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f 1>NUL 2>NUL
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
@echo Удаление OneDrive
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f 1>NUL 2>NUL
@echo Отключение рекомендуемых приложений Windows
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceAppSuggestionsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Classes\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}" /v "AllowSuggestedAppsInWindowsInkWorkspace" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение совместного использования данных рукописного ввода
reg add "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Отключение общего доступа к отчетам об ошибках рукописного ввода
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Отключение Сборщика инвентаря
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Отключение камеры на экране входа в систему
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\AccessPage\Camera" /v "CameraEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение идентификатора рекламы
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Id" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Id" /f 1>NUL 2>NUL

@echo Отключение передачи вводимой информации
reg add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение Microsoft, проводящую эксперименты с этой машиной
reg add "HKLM\Software\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение рекламы через Bluetooth
reg add "HKLM\Software\Microsoft\PolicyManager\current\device\Bluetooth" /v "AllowAdvertising" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение Программы улучшения качества обслуживания клиентов Windows
reg add "HKLM\Software\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение синхронизации текстовых сообщений с Microsoft
reg add "HKLM\Software\Policies\Microsoft\Windows\Messaging" /v "AllowMessageSync" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение доступа приложений к информации учетной записи пользователя
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f 1>NUL 2>NUL

@echo Отключение отслеживания запусков приложений
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение доступа приложений к диагностической информации
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2297E4E2-5DBE-466D-A12B-0F8286F0D9CA}" /v "Value" /t REG_SZ /d "Deny" /f 1>NUL 2>NUL

@echo Отключение кнопки раскрытия пароля
reg add "HKLM\Software\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Отключение записи шагов пользователя
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Отключение телеметрии
reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение синхронизации всех параметров с Microsoft
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f 1>NUL 2>NUL

@echo Отключение персонализации ввода
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicyy" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение обновлений для распознавания и синтеза речи
reg add "HKLM\Software\Microsoft\Speech_OneCore\Preferences" /v "ModelDownloadAllowed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Speech" /v "AllowSpeechModelUpdate" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение функции поиска системы
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Отключение одноранговой функциональности в Центре обновления Windows
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение рекламы в проводнике и OneDrive
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключение напоминания об обратной связи
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Удаление Поиска/Кортаны с панели задач
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Удаление кнопки просмотра задач с панели задач
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Удаление кнопки "Люди" с панели задач
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Спрятать последние используемые папки из "Быстрого доступа"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Спрятать последние файлы из "Быстрого доступа"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключить тайм-лайн
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Включение историю буфера обмена
reg add "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Установление логотипа OEM
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Logo" /t REG_SZ /d "C:\Windows\Custom\logo.bmp" /f 1>NUL 2>NUL

@echo Отключить предупреждение о безопасности открытых файлов
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t "REG_DWORD" /d "00000000" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t "REG_DWORD" /d "00000000" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Security" /v "DisableSecuritySettingsCheck" /t "REG_DWORD" /d "00000001" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ActivatableClassId" /t REG_SZ /d "App.AppX65n3t4j73ch7cremsjxn7q8bph1ma8jw.mca" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "PackageId" /t REG_SZ /d "Microsoft.Windows.Photos_2017.18062.12990.0_x64__8wekyb3d8bbwe" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ContractId" /t REG_SZ /d "Windows.File" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "DesiredInitialViewState" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "" /t REG_SZ /d "@{Microsoft.Windows.Photos_2017.18062.12990.0_x64__8wekyb3d8bbwe?ms-resource://Microsoft.Windows.Photos/Resources/EditWithPhotos}" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ProgrammaticAccessOnly" /t REG_SZ /d "" /f 1>NUL 2>NUL
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit\command" /v "DelegateExecute" /t REG_SZ /d "{4ED3A719-CEA8-4BD9-910D-E252F997AFC2}" /f 1>NUL 2>NUL

@echo Удаление "Редактировать с помощью Paint 3D" из контекстного меню
reg delete "HKLM\Software\Classes\SystemFileAssociations\.bmp\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpe\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.png\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.gif\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.tif\Shell\3D Edit" /f 1>NUL 2>NUL
reg delete "HKLM\Software\Classes\SystemFileAssociations\.tiff\Shell\3D Edit" /f 1>NUL 2>NUL

@echo Удаление "Включить в библиотеку" из контекстного меню
reg delete "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f 1>NUL 2>NUL

@echo Отключить предварительный запуск Microsoft Edge
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowPrelaunch" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Отключить предварительную загрузку вкладки Microsoft Edge
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowTabPreloading" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

@echo Изменение цвета активной строки заголовка на черный
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "AccentPalette" /t REG_BINARY /d "6B 6B 6B FF 59 59 59 FF 4C 4C 4C FF 3F 3F 3F FF 33 33 33 FF 26 26 26 FF 14 14 14 FF 88 17 98 00" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "StartColorMenu" /t REG_DWORD /d "4281545523" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" /v "AccentColorMenu" /t REG_DWORD /d "4278190080" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "AccentColor" /t REG_DWORD /d "4278190080" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationColor" /t REG_DWORD /d "3288334336" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationAfterglow" /t REG_DWORD /d "3288334336" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorPrevalence" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Изменение цвета неактивной строки заголовка на серый
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "AccentColorInactive" /t REG_DWORD /d "4280953386" /f 1>NUL 2>NUL

@echo Удаление размытия на экране входа в систему
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableAcrylicBackgroundOnLogon" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

@echo Применение классических настроек оболочки
cd C:\Program Files\Classic Shell 1>NUL 2>NUL
ClassicStartMenu.exe -xml "C:\Windows\Custom\startmenu.xml" 1>NUL 2>NUL

@echo Удаление ярлыка запуска
del /f /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\startup.bat" 1>NUL 2>NUL
@timeout 1 /nobreak

@echo Отключение HPET
bcdedit /deletevalue useplatformclock
bcdedit /set disabledynamictick yes

@echo Network Tweaks
netsh int tcp set heuristics disabled

@echo Настройка электропитания
powercfg /setactive scheme_min >nul
powercfg /change -monitor-timeout-ac 0 >nul
powercfg /change -disk-timeout-ac 0 >nul
powercfg /setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 10 >nul

@echo Отключение проверки подписи драйверов
verifier /reset

@echo Отключение фаерволла
netsh advfirewall set allprofiles state off >nul

@echo Настройка реестра
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SynAttackProtect" /t REG_SZ /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_SZ /d "0" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_SZ /d "1" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "Size" /t REG_SZ /d "3" /f
@Reg.exe add "HKCR\*\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
@Reg.exe add "HKCR\*\shell\TakeOwnership" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\*\shell\TakeOwnership" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\*\shell\TakeOwnership" /v "NeverDefault" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\Directory\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
@Reg.exe add "HKCR\Directory\shell\TakeOwnership" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\Directory\shell\TakeOwnership" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
@Reg.exe add "HKCR\Directory\shell\TakeOwnership" /v "NeverDefault" /t REG_SZ /d "" /f
REM ; Отключить Кортану
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
REM ; Отключить историю поиска
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /v "ShippedWithReserves" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "EnableWsd" /t REG_SZ /d "0" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "EnableDCA" /t REG_SZ /d "1" /f
REM ; Отключить автоматическое скрытие полос прокрутки
@Reg.exe add "HKCU\Control Panel\Accessibility" /v "DynamicScrollbars" /t REG_DWORD /d "0" /f
REM ; Ускорить проводник и завершение процессов
@Reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
@Reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "3000" /f
@Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "100" /f
@Reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "3000" /f
@Reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "3000" /f
REM ; Разрешить исправлять размытость DPI
@Reg.exe add "HKCU\Control Panel\Desktop" /v "EnablePerProcessSystemDPI" /t REG_DWORD /d "1" /f
REM ; Использование 100% качества картинки
@Reg.exe add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d "100" /f
REM ; Запретить веб-сайтам доступ к списку языков
@Reg.exe add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d "1" /f
REM ; Отключить предложение настроить Интернет
@Reg.exe add "HKCU\Software\Microsoft\Internet Connection Wizard" /v "Completed" /t REG_DWORD /d "1" /f
REM ; Запретить приложениям работать в фоновом режиме
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f
REM ; Ускорить автозагрузку программ
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d "0" /f
REM ; Запретить отслеживать запуски приложений
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f
REM ; Отключить индетификатор рекламы
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
REM ; Отключить советы и рекомендации от Microsoft
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
REM ; Получать обновления только от Microsoft
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownLoadMode" /t REG_DWORD /d "1" /f
REM ; Отключить автозапуск
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d "1" /f
REM ; Отключить GameDVR
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f
REM ; Отключить GameDVR
@Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "fffffff" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_SZ /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_SZ /d "2" /f
REM ; Отключить встроенную проверку подлинности Windows
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "EnableNegotiate" /t REG_DWORD /d "0" /f
REM ; Отключить предупреждение о просмотре веб-страницы через безопасное соединение
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "WarnonZoneCrossing" /t REG_DWORD /d "0" /f
REM ; Отключить предупреждение "Информация переданная через Интернет..."
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1601" /t REG_DWORD /d "0" /f
REM ; Отключить сихронизацию
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f
REM ; Отключить сихронизацию
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f
REM ; Скрыть текст инструкций в ножницах
@Reg.exe add "HKCU\Software\Microsoft\Windows\TabletPC\Snipping Tool" /v "DisplaySnipInstructions" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\TabletPC\Snipping Tool" /v "IsScreenSketchBannerExpanded" /t REG_DWORD /d "0" /f
REM ; Отключить персонализацию рукописного ввода
@Reg.exe add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f
REM ; Отключить формирование отзывов
@Reg.exe add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d "0" /f
REM ; Запретить приложеним использовать голосовую активацию
@Reg.exe add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationEnabled" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v "AgentActivationOnLockScreenEnabled" /t REG_DWORD /d "0" /f
REM ; Скрыть вкладку "Предыдущие версии"
@Reg.exe add "HKCU\Software\Policies\Microsoft\PreviousVersions" /v "DisableLocalPage" /t REG_DWORD /d "1" /f
REM ; Отключить возможность участия в программе по улучшению справки
@Reg.exe add "HKCU\Software\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Policies\Microsoft\Assistance\Client\1.0" /v "NoImplicitFeedback" /t REG_DWORD /d "1" /f
REM ; Отключить "Ознакомиться с другими результами поиска..."
@Reg.exe add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f
REM ; Показывать полностью имена длинных файлов в проводнике
@Reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /t REG_SZ /d "0" /f
REM ;  Отключить автоматическое обучение
@Reg.exe add "HKCU\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f
REM ; Отключить автозапуск диктора
@Reg.exe add "HKCU\Control Panel\Accessibility\SlateLaunch" /v "LaunchAT" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Control Panel\Accessibility\SlateLaunch" /v "ATapp" /t REG_SZ /d "" /f
REM ; Отключить залипание SHIFT
@Reg.exe add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
REM ; Включить звук переключения CAPS
@Reg.exe add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "63" /f
REM ; Включить "NumLock"
@Reg.exe add "HKCU\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Page" /t REG_SZ /d "https://google.com/" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d "https://google.com/" /f
REM ; Отключить мастер первого запуска
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10RunOncePerInstallCompleted" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10TourNoShow" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10TourShown" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10TourShownTime" /t REG_BINARY /d "00" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10RunOnceCompletionTime" /t REG_BINARY /d "00" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10RecommendedSettingsNo" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "IE10RunOnceLastShown_TIMESTAMP" /t REG_BINARY /d "00" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceComplete" /t REG_DWORD /d "1" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "RunOnceHasShown" /t REG_DWORD /d "1" /f
REM ; Предотвратить повторное использование окна Internet Explorer
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "AllowWindowReuse" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "DisableFirstRunCustomize" /t REG_DWORD /d "1" /f
REM ; Отключить использование рекомендуемых сайтов
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\Suggested Sites" /v "Enabled" /t REG_DWORD /d "0" /f
REM ; Открывать всплывающие окна в новой вкладке
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "PopupsUseNewWindow" /t REG_DWORD /d "2" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "NewTabPageShow" /t REG_DWORD /d "2" /f
REM ; Не предупреждать об одновременном закрытии вкладок
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "WarnOnClose" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "ShowTabsWelcome" /t REG_DWORD /d "0" /f
REM ; Всегда переключаться на новую вкладку при ее создании
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v "OpenInForeground" /t REG_DWORD /d "1" /f
REM ;Открывать ранее открытые вкладки IE
@Reg.exe add "HKCU\Software\Microsoft\Internet Explorer\ContinuousBrowsing" /v "Enabled" /t REG_DWORD /d "1" /f
REM ; Запретить доступ к диагностическим данным
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к календарю
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к сотовой связи
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к сообщениям
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к контактам
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к эл. почте
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить программный снимок экрана
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить запрашивать отключение рамки экрана
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к месторасположению
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Разрешить доступ к микрофону
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f
REM ; Запретить приложениям совершать звонки
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Запретить доступ к журналу вызовов
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Разрешить доступ к радиомодулям
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Allow" /f
REM ; Запретить доступ к учетной записи
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f
REM ; Разрешить доступ к задачам
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Allow" /f
REM ; Разрешить доступ к уведомлениям
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Allow" /f
REM ; Разрешить доступ к вебкамере
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /t REG_SZ /d "Allow" /f
REM ; =============================== LTSB 1607 ================================
REM ; Разрешить доступ к камере
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Разрешить доступ к микрофону
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Разрешить доступ к уведомлениям
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{52079E78-A92B-413F-B213-E8FE35712E72}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_SZ /d "00000000" /f
REM ; Запретить доступ к контактам
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить доступ к календарю
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить доступ к журналу вызовов
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить доступ к эл. почте
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Разрешить доступ к задачам
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить доступ к сообщениям
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Разрешить доступ к радиомодулям
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Allow" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Запретить синхронизацию с беспроводными устройствами
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Deny" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Type" /t REG_SZ /d "InterfaceClass" /f
@Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "InitialAppValue" /t REG_SZ /d "Unspecified" /f
REM ; Автоматическое принятие соглашения WMP
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "GroupPrivacyAcceptance" /t REG_DWORD /d "1" /f
REM ; Принять лицензионное соглашение
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AcceptedPrivacyStatement" /t REG_DWORD /d "1" /f
REM ; AddVideosFromPicturesLibrary
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AddVideosFromPicturesLibrary" /t REG_DWORD /d "0" /f
REM ; Отключить автоматическое добавление музыки в библиотеку
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddMusicToLibrary" /t REG_DWORD /d "0" /f
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddVideoToLibrary" /t REG_DWORD /d "0" /f
REM ; Не удалять файлы с компьютера при удалении из библиотеки
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DeleteRemovesFromComputer" /t REG_DWORD /d "0" /f
REM ; Запретить автоматическую проверку лицензий
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableLicenseRefresh" /t REG_DWORD /d "1" /f
REM ; Отключить мастер первого запуска
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "FirstRun" /t REG_DWORD /d "0" /f
REM ; Не сохранять оценки в файлах мультимедиа
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "FlushRatingsToFiles" /t REG_DWORD /d "0" /f
REM ; Не обновлять содержимое библиотеки при первом запуске
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "LibraryHasBeenRun" /t REG_DWORD /d "1" /f
REM ; Не показывать сведения о мультимедиа из Интернета и не обновлять файлы
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "MetadataRetrieval" /t REG_DWORD /d "0" /f
REM ; Отключить загрузку лицензий на использование файлов мультимедиа
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentAcquisition" /t REG_DWORD /d "0" /f
REM ; Не устанавливать автоматически часы на устройсвтах
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentDRMConfiguration" /t REG_DWORD /d "0" /f
REM ; Не сохранять историю открытых файлов
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRU" /t REG_DWORD /d "1" /f
REM ; Не отправлять данные об использовании проигрывателя в Microsoft
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f
REM ; Отключить идентификацию Windows Media Player на интернет-сайтах
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SendUserGUID" /t REG_BINARY /d "00" /f
REM ; Отключить обновление Windows Media Player
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AskMeAgain" /t REG_SZ /d "No" /f
REM ; Не использовать Windows Media Player в online справочниках
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "StartInMediaGuide" /t REG_DWORD /d "0" /f
REM ; Отключить "Проигрыватель по размеру видео при запуске"
@Reg.exe add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SnapToVideoV11" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f
@Reg.exe delete "HKLM\SOFTWARE\Classes\.bmp\ShellNew" /f
@Reg.exe delete "HKLM\SOFTWARE\Classes\.contact\ShellNew" /f
@Reg.exe delete "HKLM\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\ModernSharing" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\.bat\ShellNew" /v "Data" /t REG_SZ /d "@echo off" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\.reg\ShellNew" /v "Data" /t REG_SZ /d "Windows Registry Editor Version 5.00" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\CABFolder\Shell\RunAs" /ve /t REG_SZ /d "@%%SystemRoot%%\System32\msimsg.dll,-36" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\CABFolder\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\CABFolder\Shell\RunAs" /v "Extended" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\*\shell\edit" /v "Extended" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\*\shell\edit\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\NOTEPAD.EXE %%1" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\Msi.Package\shell\Extract" /ve /t REG_SZ /d "@%%SystemRoot%%\system32\shell32.dll,-37514" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\Msi.Package\shell\Extract" /v "Extended" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\.appx" /ve /t REG_SZ /d "appxfile" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\.appxbundle" /ve /t REG_SZ /d "appxbundlefile" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxfile\Shell\RunAs" /ve /t REG_SZ /d "@%%SystemRoot%%\System32\msimsg.dll,-36" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxfile\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxbundlefile\Shell\RunAs" /ve /t REG_SZ /d "@%%SystemRoot%%\System32\msimsg.dll,-36" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxbundlefile\Shell\RunAs" /v "HasLUAShield" /t REG_SZ /d "" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxfile\DefaultIcon" /ve /t REG_SZ /d "imageres.dll,-175" /f
@Reg.exe add "HKLM\SOFTWARE\Classes\appxbundlefile\DefaultIcon" /ve /t REG_SZ /d "imageres.dll,-175" /f
REM ; Отключить дистанционное отслеживание приложений
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v "ThisPCPolicy" /t REG_SZ /d "Hide" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
REM ; Запретить показ уведомлений Майкрософт с предложением отправить отзыв
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f
REM ; Отключить кортану
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f
REM ; Отключить синхронизацию приложенй
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "EnableBackupForWin8Apps" /t REG_DWORD /d "0" /f
REM ;Отключить сбор данных InPrivate
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Safety\PrivacIE" /v "DisableLogging" /t REG_DWORD /d "1" /f
REM ; Отключить сбор и хранение текста и рукописных данных
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f
REM ; Отключить отправку образцов рукописного ввода
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f
REM ; Не передавать отчеты об ошибках распознавания рукописного ввода
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "Disabled" /t REG_DWORD /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "DisableAutomaticTelemetryKeywordReporting" /t REG_DWORD /d "1" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "TelemetryServiceDisabled" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\TestHooks" /v "DisableAsimovUpload" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\PerfTrack" /v "Disabled" /t REG_DWORD /d "1" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AppModel" /v "Start" /t REG_DWORD /d "0" /f
REM ; Отключить телеметрию и сбор данных
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "" /f
@Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f
REM ; Удалить из панели навигации "Съёмные диски"
@Reg.exe delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f
REM ; Удалить из панели навигации "Съёмные диски"
REM ; Отключить рекомендуемые приложения
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
REM ; Запретить эксперименты на этом компьтере
@Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f
REM ; Отключить получение инсайдерских сборок Windows
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableConfigFlighting" /t REG_DWORD /d "0" /f
REM ; Скрыть "Программа предварительной оценки"
@Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "HideInsiderPage" /t REG_DWORD /d "1" /f
REM ; Отключить программу по улучшению качества программного обеспечения Windows
@Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
REM ; Разрешить установку неопубликованых приложений
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowAllTrustedApps" /t REG_DWORD /d "1" /f
REM ; Разрешить приложения из любых источников
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "AicEnabled" /t REG_SZ /d "Anywhere" /f
REM ; Прозрачность панели задач
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "UseOLEDTaskbarTransparency" /t REG_DWORD /d "1" /f
REM ; Запретить приложениям с других устройств открывать приложения на этом устройстве
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /v "UserAuthPolicy" /t REG_DWORD /d "0" /f
REM ; Отключить автообновление плитко-приложений
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d "2" /f
REM ; Отключить загрузку обновлений с других компьютеров
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode_BackCompat" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f
REM ; Отключить загрузку обновлений с других компьютеров
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadModeProvider" /t REG_DWORD /d "8" /f
REM ; Отключить загрузку улучшеных значков устройств
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f
REM ; Разрешить локальные сценарии и удалённые подписанные сценарии
@Reg.exe add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "RemoteSigned" /f
REM ; Разрешить локальные сценарии и удалённые подписанные сценарии
@Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "RemoteSigned" /f
REM ;Файл подкачки оптимиз.
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagingFiles" /t REG_MULTI_SZ /d "c:\pagefile.sys 1024 2048" /f
@Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ExistingPageFiles" /t REG_MULTI_SZ /d "\??\C:\pagefile.sys" /f
REM ; Отключить автообновление карт
@Reg.exe add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d "0" /f
REM ; Prefetcher, Superfetch: 2 – ускорение только загрузки системы, 3 – ускорение загрузки системы и запуска приложений
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "2" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "2" /f
REM ; Разрешить гостевой вход (для доступа к расшаренным папкам)
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\LanmanWorkstation\Parameters" /v "AllowInsecureGuestAuth" /t REG_DWORD /d "1" /f
REM ; Не расширять динамические VHD до максимума
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\FsDepends\Parameters" /v "VirtualDiskExpandOnMount" /t REG_DWORD /d "4" /f
REM ; Стандартная служба сборщика центра диагностики Microsoft
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d "4" /f
REM ; Служба функциональных возможностей для подключенных пользователей и телеметрии
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
REM ; Служба помощника по совместимости программ
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\PcaSvc" /v "Start" /t REG_DWORD /d "4" /f
REM ; Служба демонстрации магазина
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\RetailDemo" /v "Start" /t REG_DWORD /d "4" /f
REM ; Служба Medic центра обновления Windows
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableVirtualization" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\WSearch" /v "Start" /t REG_DWORD /d "4" /f
@Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\SysMain" /v "Start" /t REG_DWORD /d "4" /f
del /f C:\Windows\System32\SetACL.exe
@start explorer.exe

@echo Завершено
Goto MenuRus
