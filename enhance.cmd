::
:: NAME
::
::     enhance - debloating and optimization script for Microsoft Windows 7/8/10
::
:: SYNOPSIS
::
::     enhance [policies|settings|services|features|programs|schedule|firewall|all]
::
:: DESCRIPTION
::
::     Instances of Microsoft Windows are notorious for software bloat,  privacy
::     invasive features and bad security.  This script enhances the baseline of
::     such an instances by disabling (or in extreme cases removing) the feature
::     creep, stopping telemetry collection services, and limiting access to the
::     potentially exploitable services & programs.
::
:: OPTIONS
::
::     policies
::         Configures the HKLM registry section for maximum security & privacy.
::
::     settings
::         Configures the HKCU registry section for maximum security & privacy.
::
::     services
::         Disables bloatware, privacy-invasive and insecure Windows services.
::
::     features
::         Disables bloatware, privacy-invasive and obsolete Windows features.
::
::     programs
::         Disables bloatware, privacy-invasive and insecure Windows programs.
::
::     schedule
::         Disables scheduled tasks responsible for collection of telemetry.
::
::     firewall
::         Defines Firewall rules that cut off insecure network communication.
::
::     all
::         Executes the script with all the options listed above (the default).
::
:: KNOWN ISSUES
::
::     wuauserv is not recognized by firewall in Win10 - https://bit.ly/2QyRszl
::
:: COPYRIGHT
::
::     Copyright 2018 Quasis - The MIT Licence
::

@echo off
@setLocal enableDelayedExpansion

:enhance

    if "%1" == "" (
        goto :all
    )

    call :%1
    goto :eof


:policies

    :: Control\CrashControl

    echo | set /p="Setting CurrentControlSet\Control\CrashControl\EnableLogFile=0... "
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "EnableLogFile" /t REG_DWORD /d 0 /f > nul && echo ok

    :: Control\Remote Assistance

    echo | set /p="Setting CurrentControlSet\Control\Remote Assistance\fAllowToGetHelp=0... "
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting CurrentControlSet\Control\Remote Assistance\fAllowFullControl=0... "
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d 0 /f > nul && echo ok

    :: Policies\Microsoft\Assistance

    echo | set /p="Setting Policies\Microsoft\Assistance\Client\1.0\NoActiveHelp=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\InputPersonalization

    echo | set /p="Setting Policies\Microsoft\InputPersonalization\AllowInputPersonalization=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\InputPersonalization\RestrictImplicitInkCollection=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\InputPersonalization\RestrictImplicitTextCollection=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Biometrics

    echo | set /p="Setting Policies\Microsoft\Biometrics\Enabled=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\FVE

    echo | set /p="Setting Policies\Microsoft\FVE\EncryptionMethod=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v EncryptionMethod /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\FVE\EncryptionMethodNoDiffuser=4... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v EncryptionMethodNoDiffuser /t REG_DWORD /d 4 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\FVE\EncryptionMethodWithXtsOs=7... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v EncryptionMethodWithXtsOs /t REG_DWORD /d 7 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\FVE\EncryptionMethodWithXtsFdv=7... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v EncryptionMethodWithXtsFdv /t REG_DWORD /d 7 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\FVE\EncryptionMethodWithXtsRdv=7... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v EncryptionMethodWithXtsRdv /t REG_DWORD /d 7 /f > nul && echo ok


    :: Policies\Microsoft\MRT

    echo | set /p="Setting Policies\Microsoft\MRT\DontOfferThroughWUAU=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\MRT\DontReportInfectionInformation=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\SQMClient

    echo | set /p="Setting Policies\Microsoft\SQMClient\CEIPEnable=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\VSCommon

    echo | set /p="Setting Microsoft\VSCommon\15.0\SQM\OptIn=0... "
    reg add "HKLM\SOFTWARE\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f > nul && reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\VSCommon\15.0\SQM" /v "OptIn" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\Windows Defender

    echo | set /p="Setting Policies\Microsoft\Windows Defender\Real-Time Protection\DisableOnAccessProtection=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows Defender\Real-Time Protection\DisableRealtimeMonitoring=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows Defender\Real-Time Protection\DisableScanOnRealtimeEnable=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows Defender\Spynet\SpyNetReporting=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpyNetReporting" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows Defender\Spynet\SubmitSamplesConsent=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f > nul && echo ok


    :: Policies\Microsoft\Windows Defender Security Center

    echo | set /p="Setting Policies\Microsoft\Windows Defender Security Center\Systray\HideSystray=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\WindowsMediaPlayer

    echo | set /p="Setting Policies\Microsoft\WindowsMediaPlayer\DisableAutoUpdate=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "DisableAutoUpdate" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\WindowsMediaPlayer\PreventLibrarySharing=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "PreventLibrarySharing" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\AdvertisingInfo

    echo | set /p="Setting Policies\Microsoft\Windows\AdvertisingInfo\DisabledByGroupPolicy=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\AppCompat

    echo | set /p="Setting Policies\Microsoft\Windows\AppCompat\AITEnable=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppCompat\DisableInventory=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppCompat\DisablePCA=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppCompat\DisableUAR=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\AppPrivacy

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessAccountInfo=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessAccountInfo" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessCallHistory=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessCalendar=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessContacts=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessEmail=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessEmail" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessGazeInput=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessGazeInput" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessMessaging=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessRadios=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessLocation=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessMotion=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMotion" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessNotifications=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessPhone=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessTasks=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTasks" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsActivateWithVoice=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsActivateWithVoice" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsAccessTrustedDevices=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTrustedDevices" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsGetDiagnosticInfo=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsGetDiagnosticInfo" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsRunInBackground=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\AppPrivacy\LetAppsSyncWithDevices... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsSyncWithDevices" /t REG_DWORD /d 2 /f > nul && echo ok


    :: Policies\Microsoft\Windows\BITS

    echo | set /p="Setting Policies\Microsoft\Windows\BITS\EnablePeercaching=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\BITS" /v "EnablePeercaching" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\Windows\CloudContent

    echo | set /p="Setting Policies\Microsoft\Windows\CloudContent\DisableSoftLanding=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\CloudContent\DisableWindowsConsumerFeatures=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\DataCollection

    echo | set /p="Setting Policies\Microsoft\Windows\DataCollection\AllowTelemetry=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\DataCollection\DoNotShowFeedbackNotifications=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\DeliveryOptimization

    echo | set /p="Setting Policies\Microsoft\Windows\DeliveryOptimization\DODownloadMode=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\Windows\Explorer

    echo | set /p="Setting Policies\Microsoft\Windows\Explorer\NoNewAppAlert=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Explorer\SmartScreenEnabled=Off... "
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d Off /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Policies\Explorer\NoAutorun=1... "
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoAutorun" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Policies\Explorer\NoDriveTypeAutoRun=255... "
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f > nul && echo ok


    :: Policies\Microsoft\Windows\FileHistory

    echo | set /p="Setting Policies\Microsoft\Windows\FileHistory\Disabled=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /v "Disabled" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\GameDVR

    echo | set /p="Setting Policies\Microsoft\Windows\GameDVR\AllowGameDVR=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\Windows\HandwritingErrorReports

    echo | set /p="Setting Policies\Microsoft\Windows\HandwritingErrorReports\PreventHandwritingErrorReports=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\LocationAndSensors

    echo | set /p="Setting Policies\Microsoft\Windows\LocationAndSensors\DisableLocation=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\LocationAndSensors\DisableLocationScripting=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\LocationAndSensors\DisableWindowsLocationProvider=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\LocationAndSensors\DisableSensors=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\OneDrive

    echo | set /p="Setting Policies\Microsoft\Windows\OneDrive\DisableFileSync=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\OneDrive\DisableFileSyncNGSC=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\OneDrive\DisableMeteredNetworkFileSync=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\OneDrive\DisableLibrariesDefaultSaveToOneDrive=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\Personalization

    echo | set /p="Setting Policies\Microsoft\Windows\Personalization\NoLockScreen=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\Personalization\NoLockScreenCamera=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\PreviewBuilds

    echo | set /p="Setting Policies\Microsoft\Windows\PreviewBuilds\AllowBuildPreview=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\PreviewBuilds\EnableConfigFlighting=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableConfigFlighting" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\PreviewBuilds\EnableExperimentation=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableExperimentation" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\Windows\PushNotifications

    echo | set /p="Setting Policies\Microsoft\Windows\CurrentVersion\PushNotifications\NoCloudApplicationNotification=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoCloudApplicationNotification" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\SettingSync

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableApplicationSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableAppSyncSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableCredentialsSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableDesktopThemeSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisablePersonalizationSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableStartLayoutSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableWebBrowserSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableWindowsSettingSync=2... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t REG_DWORD /d 2 /f > nul && reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\SettingSync\DisableSyncOnPaidNetwork=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\SmartGlass

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\SmartGlass\UserAuthPolicy=0... "
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /v "UserAuthPolicy" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\Windows\Software Protection Platform

    echo | set /p="Setting Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform\NoGenTicket=1... "
    reg add "HKLM\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v NoGenTicket /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\System

    echo | set /p="Setting Policies\Microsoft\Windows\System\EnableSmartScreen=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\NoConnectedUser=3... "
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "NoConnectedUser" /t REG_DWORD /d 3 /f > nul && echo ok


    :: Policies\Microsoft\Windows\TabletPC

    echo | set /p="Setting Policies\Microsoft\Windows\TabletPC\PreventHandwritingDataSharing=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\TextInput

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\TextInput\AllowLinguisticDataCollection=0... "
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v "AllowLinguisticDataCollection" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Policies\Microsoft\Windows\Windows Error Reporting

    echo | set /p="Setting Policies\Microsoft\Windows\Windows Error Reporting\Disabled=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\Windows\Windows Search

    echo | set /p="Setting Policies\Microsoft\Windows\Windows Search\AllowCortana=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\Windows Search\AllowCloudSearch=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\Windows Search\AllowSearchToUseLocation=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\Windows Search\ConnectedSearchPrivacy=3... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\Windows Search\ConnectedSearchUseWeb=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\Windows Search\ConnectedSearchUseWebOverMeteredConnections=0... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Policies\Microsoft\Windows\Windows Search\DisableWebSearch=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\WMDRM

    echo | set /p="Setting Policies\Microsoft\WMDRM\DisableOnline=1... "
    reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Policies\Microsoft\WcmSvc\wifinetworkmanager

    echo | set /p="Setting Microsoft\WcmSvc\wifinetworkmanager\config\AutoConnectAllowedOEM=0... "
    reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d 0 /f > nul && echo ok


    goto :eof


:settings


    :: Settings\Classes

    echo | set /p="Setting Classes\.bmp=PhotoViewer.FileAssoc.Tiff"
    reg add "HKCU\SOFTWARE\Classes\.bmp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul && echo ok

    echo | set /p="Setting Classes\.gif=PhotoViewer.FileAssoc.Tiff"
    reg add "HKCU\SOFTWARE\Classes\.gif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul && echo ok

    echo | set /p="Setting Classes\.ico=PhotoViewer.FileAssoc.Tiff"
    reg add "HKCU\SOFTWARE\Classes\.ico" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul && echo ok

    echo | set /p="Setting Classes\.jpeg=PhotoViewer.FileAssoc.Tiff"
    reg add "HKCU\SOFTWARE\Classes\.jpeg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul && echo ok

    echo | set /p="Setting Classes\.jpg=PhotoViewer.FileAssoc.Tiff"
    reg add "HKCU\SOFTWARE\Classes\.jpg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul && echo ok

    echo | set /p="Setting Classes\.png=PhotoViewer.FileAssoc.Tiff"
    reg add "HKCU\SOFTWARE\Classes\.png" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul && echo ok

    echo | set /p="Setting Classes\.tiff=PhotoViewer.FileAssoc.Tiff"
    reg add "HKCU\SOFTWARE\Classes\.tiff" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul && echo ok

    echo | set /p="Setting Classes\.webp=PhotoViewer.FileAssoc.Tiff"
    reg add "HKCU\SOFTWARE\Classes\.webp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul && echo ok


    :: Settings\International\UserProfile

    echo | set /p="Setting International\User Profile\HttpAcceptLanguageOptOut=1... "
    reg add "HKCU\CONTROL PANEL\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Settings\Microsoft\Assistance

    echo | set /p="Setting Microsoft\Assistance\Client\1.0\NoExplicitFeedback=1... "
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d 1 /f > nul && echo ok


    :: Settings\Microsoft\MediaPlayer

    echo | set /p="Setting Microsoft\MediaPlayer\Preferences\UsageTracking=0... "
    reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Settings\Microsoft\Office

    echo | set /p="Setting Microsoft\Office\16.0\osm\enablelogging=0... "
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "enablelogging" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Office\16.0\osm\enableupload=0... "
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "enableupload" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Settings\Microsoft\Windows\Explorer

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden=1... "
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt=0... "
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Explorer\Advanced\LaunchTo=1... "
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden=0... "
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Explorer\Advanced\Start_TrackProgs=0... "
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Explorer\ShowFrequent=0... "
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f > nul && echo ok

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Explorer\ShowRecent=0... "
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f > nul && echo ok


    :: Settings\Microsoft\Windows\Search

    echo | set /p="Setting Microsoft\Windows\CurrentVersion\Search\SearchboxTaskbarMode=0... "
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f > nul && echo ok


    goto :eof


:services


    for %%i in (^
        CDPSvc,^
        CDPUserSvc,^
        DcpSvc,^
        DiagTrack,^
        DoSvc,^
        LicenseManager,^
        MapsBroker,^
        MessagingService,^
        NcbService,^
        OneSyncSvc,^
        PcaSvc,^
        PhoneSvc,^
        PimIndexMaintenanceSvc,^
        RemoteRegistry,^
        RetailDemo,^
        SensorDataService,^
        SensorService,^
        SensrSvc,^
        TrkWks,^
        UnistoreSvc,^
        UserDataSvc,^
        WMPNetworkSvc,^
        WSearch,^
        WalletService,^
        WbioSrvc,^
        WerSvc,^
        XblAuthManager,^
        XblGameSave,^
        XboxNetApiSvc,^
        cphs,^
        cplspcon,^
        diagnosticshub.standardcollector.service,^
        dmwappushservice,^
        dmwappushsvc,^
        edgeupdate,^
        edgeupdateem,^
        esifsvc,^
        igfxCUIService2.0.0.0,^
        lfsvc,^
        shpamsvc,^
        wercplsupport,^
        wisvc,^
        wlidsvc,^
        xboxgip,^
    ) do (

        sc query %%i > nul && if errorlevel 0 (

            echo | set /p="Stopping Services\%%i... "
            reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%i" /v "Start" /t REG_DWORD /d 4 /f > nul && (sc stop %%i > nul & sc config %%i start= disabled > nul) && echo ok
        )
    )


    :: Services\LanmanServer

    echo | set /p="Setting Services\LanmanServer\Parameters\AutoShareWks=0... "
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f > nul && echo ok


    goto :eof


:features


    for %%i in (^
        "Internet-Explorer-Optional-amd64"^
        "Printing-XPSServices-Features"^
        "SMB1Protocol"^
        "WorkFolders-Client"^
        "Xps-Foundation-Xps-Viewer"^
    ) do (

        dism /online /get-featureinfo /featurename:%%i > nul & if errorlevel 0 (

            echo | set /p="Removing Features\%%~i... "
            dism /online /Disable-Feature /FeatureName:%%i /quiet /norestart && echo ok
        )
    )


    :: Features\Hibernation

    echo | set /p="Removing Features\Hibernation..."
    powercfg /hibernate off > nul && echo ok


    goto :eof


:programs

    for %%i in (^
        "Microsoft.549981C3F5F10"^
        "Microsoft.BingWeather"^
        "Microsoft.GetHelp"^
        "Microsoft.Getstarted"^
        "Microsoft.MSPaint"^
        "Microsoft.Microsoft3DViewer"^
        "Microsoft.MicrosoftOfficeHub"^
        "Microsoft.MicrosoftSolitaireCollection"^
        "Microsoft.MicrosoftStickyNotes"^
        "Microsoft.MixedReality.Portal"^
        "Microsoft.Office.OneNote"^
        "Microsoft.People"^
        "Microsoft.ScreenSketch"^
        "Microsoft.SkypeApp"^
        "Microsoft.StorePurchaseApp"^
        "Microsoft.Wallet"^
        "Microsoft.Windows.Photos"^
        "Microsoft.WindowsAlarms"^
        "Microsoft.WindowsCamera"^
        "Microsoft.WindowsFeedbackHub"^
        "Microsoft.WindowsMaps"^
        "Microsoft.WindowsSoundRecorder"^
        "Microsoft.WindowsStore"^
        "Microsoft.Xbox.TCUI"^
        "Microsoft.XboxApp"^
        "Microsoft.XboxGameOverlay"^
        "Microsoft.XboxGamingOverlay"^
        "Microsoft.XboxIdentityProvider"^
        "Microsoft.XboxSpeechToTextOverlay"^
        "Microsoft.YourPhone"^
        "Microsoft.ZuneMusic"^
        "Microsoft.ZuneVideo"^
        "STMicroelectronicsMEMS.DellFreeFallDataProtection"^
    ) do (

        echo | set /p="Removing Programs\%%~i... "
        powershell -command "Get-AppxPackage -Name %%i | Remove-AppxPackage" && powershell -command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like %%i | Remove-AppxProvisionedPackage -Online" > nul && echo ok
    )

    goto :eof


:schedule


    for %%i in (^
        "Microsoft\Office\Office 15 Subscription Heartbeat"^
        "Microsoft\Office\OfficeTelemetryAgentFallBack2016"^
        "Microsoft\Office\OfficeTelemetryAgentLogOn2016"^
        "Microsoft\Windows\AppID\SmartScreenSpecific"^
        "Microsoft\Windows\Application Experience\AitAgent"^
        "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"^
        "Microsoft\Windows\Application Experience\ProgramDataUpdater"^
        "Microsoft\Windows\Application Experience\StartupAppTask"^
        "Microsoft\Windows\Autochk\Proxy"^
        "Microsoft\Windows\Clip\License Validation"^
        "Microsoft\Windows\CloudExperienceHost\CreateObjectTask"^
        "Microsoft\Windows\Customer Experience Improvement Program\BthSQM"^
        "Microsoft\Windows\Customer Experience Improvement Program\Consolidator"^
        "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"^
        "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"^
        "Microsoft\Windows\Device Information\Device"^
        "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"^
        "Microsoft\Windows\Feedback\Siuf\DmClient"^
        "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"^
        "Microsoft\Windows\License Manager\TempSignedLicenseExchange"^
        "Microsoft\Windows\Location\Notifications"^
        "Microsoft\Windows\Location\WindowsActionDialog"^
        "Microsoft\Windows\Maintenance\WinSAT"^
        "Microsoft\Windows\Maps\MapsToastTask"^
        "Microsoft\Windows\Maps\MapsUpdateTask"^
        "Microsoft\Windows\Media Center\ActivateWindowsSearch"^
        "Microsoft\Windows\Media Center\ConfigureInternetTimeService"^
        "Microsoft\Windows\Media Center\DispatchRecoveryTasks"^
        "Microsoft\Windows\Media Center\ehDRMInit"^
        "Microsoft\Windows\Media Center\InstallPlayReady"^
        "Microsoft\Windows\Media Center\mcupdate"^
        "Microsoft\Windows\Media Center\MediaCenterRecoveryTask"^
        "Microsoft\Windows\Media Center\ObjectStoreRecoveryTask"^
        "Microsoft\Windows\Media Center\OCURActivate"^
        "Microsoft\Windows\Media Center\OCURDiscovery"^
        "Microsoft\Windows\Media Center\PBDADiscovery"^
        "Microsoft\Windows\Media Center\PBDADiscoveryW1"^
        "Microsoft\Windows\Media Center\PBDADiscoveryW2"^
        "Microsoft\Windows\Media Center\PvrRecoveryTask"^
        "Microsoft\Windows\Media Center\PvrScheduleTask"^
        "Microsoft\Windows\Media Center\RegisterSearch"^
        "Microsoft\Windows\Media Center\ReindexSearchRoot"^
        "Microsoft\Windows\Media Center\SqlLiteRecoveryTask"^
        "Microsoft\Windows\Media Center\UpdateRecordPath"^
        "Microsoft\Windows\PI\Sqm-Tasks"^
        "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"^
        "Microsoft\Windows\RetailDemo\CleanupOfflineContent"^
        "Microsoft\Windows\SettingSync\BackupTask"^
        "Microsoft\Windows\SettingSync\NetworkStateChangeTask"^
        "Microsoft\Windows\Shell\FamilySafetyMonitor"^
        "Microsoft\Windows\Shell\FamilySafetyMonitorToastTask"^
        "Microsoft\Windows\Shell\FamilySafetyRefresh"^
        "Microsoft\Windows\Shell\FamilySafetyRefreshTask"^
        "Microsoft\Windows\Speech\SpeechModelDownloadTask"^
        "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"^
        "Microsoft\Windows\Windows Error Reporting\QueueReporting"^
        "Microsoft\Windows\WindowsUpdate\Automatic App Update"^
        "Microsoft\Windows\WindowsUpdate\sih"^
        "Microsoft\Windows\WindowsUpdate\sihboot"^
        "Microsoft\Windows\WS\License Validation"^
        "Microsoft\Windows\WS\WSTask"^
        "Microsoft\XblGameSave\XblGameSaveTask"^
        "Microsoft\XblGameSave\XblGameSaveTaskLogon"^
    ) do (

        schtasks /query /tn %%i > nul 2>&1 && if errorlevel 0 (

            echo | set /p="Stopping %WinDir%\System32\Tasks\%%~i... "
            schtasks /change /tn %%i /disable > nul && echo ok
        )
    )


    goto :eof


:firewall


    echo | set /p="Reseting Firewall\Rulesets... "
    netsh advfirewall reset > nul && echo ok

    echo | set /p="Blocking Firewall\Profiles... "
    netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound > nul && echo ok

    echo | set /p="Blocking Firewall\Rulesets... "
    netsh advfirewall firewall set rule name=all new enable=no > nul && echo ok


    :: Firewall\Core Networking

    for %%r in (^

        "Core Networking - Destination Unreachable Fragmentation Needed (ICMPv4-In)",^
        "Core Networking - DNS (UDP-Out)",^
        "Core Networking - Dynamic Host Configuration Protocol (DHCP-In)",^
        "Core Networking - Dynamic Host Configuration Protocol (DHCP-Out)",^

    ) do (

        echo | set /p="Allowing Firewall\%%~r... "
        netsh advfirewall firewall set rule name=%%r new enable=yes > nul && echo ok
    )


    :: Firewall\Network Discovery

    for %%r in (^

        "Network Discovery (SSDP-In)",^
        "Network Discovery (SSDP-Out)",^
        "Network Discovery (UPnP-In)",^
        "Network Discovery (UPnP-Out)",^
        "Network Discovery (UPnPHost-Out)",^
        "Network Discovery (WSD-In)",^
        "Network Discovery (WSD-Out)",^
        "Network Discovery (Pub-WSD-In)",^
        "Network Discovery (Pub WSD-Out)",^
        "Network Discovery (WSD Events-In)",^
        "Network Discovery (WSD Events-Out)",^
        "Network Discovery (WSD EventsSecure-In)",^
        "Network Discovery (WSD EventsSecure-Out)",^
        "Network Discovery (LLMNR-UDP-In)",^
        "Network Discovery (LLMNR-UDP-Out)",^
        "Network Discovery (NB-Name-In)",^
        "Network Discovery (NB-Name-Out)",^
        "Network Discovery (NB-Datagram-In)",^
        "Network Discovery (NB-Datagram-Out)",^

    ) do (

        echo | set /p="Allowing Firewall\%%~r... "
        netsh advfirewall firewall set rule name=%%r profile=private new enable=yes > nul && echo ok
    )


    :: Firewall\Custom Rules

    echo | set /p="Allowing Firewall\Custom Rules - Windows Time... "
    netsh advfirewall firewall add rule name="Custom Rules - Windows Time" dir=Out protocol=udp program="%SystemRoot%\system32\svchost.exe" remoteip=Any localport=Any remoteport=123 service=W32Time profile=private action=allow > nul && echo ok

    echo | set /p="Allowing Firewall\Custom Rules - Windows Update... "
    netsh advfirewall firewall add rule name="Custom Rules - Windows Update" dir=Out protocol=tcp program="%SystemRoot%\system32\svchost.exe" remoteip=Any localport=Any remoteport=80,443 service=wuauserv profile=private action=allow > nul && echo ok

    echo | set /p="Allowing Firewall\Custom Rules - Remote Desktop... "
    netsh advfirewall firewall add rule name="Custom Rules - Remote Desktop" dir=Out protocol=tcp program="%SystemRoot%\system32\mstsc.exe" remoteip=Any localport=Any remoteport=Any action=allow > nul && echo ok

    for /d %%f in (^

        "%WinDir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe",^

        ) do if exist "%%~f" (

            echo | set /p="Blocking Firewall\Custom Rules - %%~nf... "
            netsh advfirewall firewall add rule name="Custom Rules - %%~nf" dir=Out protocol=Any program="%%~f" remoteip=Any action=block > nul && echo ok
        )
    )

    for /d %%f in (^

        "%ProgramFiles%\Firefox\firefox.exe",^
        "%ProgramFiles%\Mozilla Firefox\firefox.exe",^
        "%ProgramFiles%\Opera\opera.exe",^
        "%ProgramFiles%\Google\Chrome\Application\chrome.exe",^
        "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe",^
        "%LocalAppData%\Google\Chrome\Application\chrome.exe",^

        ) do if exist "%%~f" (

            echo | set /p="Allowing Firewall\Custom Rules - %%~nf... "
            netsh advfirewall firewall add rule name="Custom Rules - %%~nf" dir=Out protocol=tcp program="%%~f" remoteip=Any localport=Any remoteport=Any action=allow > nul && echo ok
        )
    )

    for /d %%f in (^

        "%ProgramFiles%\Microsoft Office\Office12\OUTLOOK.EXE",^
        "%ProgramFiles(x86)%\Microsoft Office\Office12\OUTLOOK.EXE",^
        "%ProgramFiles%\Microsoft Office\Office16\OUTLOOK.EXE",^
        "%ProgramFiles(x86)%\Microsoft Office\Office16\OUTLOOK.EXE",^

        ) do if exist "%%~f" (

            echo | set /p="Allowing Firewall\Custom Rules - %%~nf... "
            netsh advfirewall firewall add rule name="Custom Rules - %%~nf" dir=Out protocol=tcp program="%%~f" remoteip=Any localport=Any remoteport=Any action=allow > nul && echo ok
        )
    )

    for /d %%f in (^

        "%ProgramFiles%\PuTTY\putty.exe",^
        "%ProgramFiles(x86)%\PuTTY\putty.exe",^

        ) do if exist "%%~f" (

            echo | set /p="Allowing Firewall\Custom Rules - %%~nf... "
            netsh advfirewall firewall add rule name="Custom Rules - %%~nf" dir=Out protocol=tcp program="%%~f" remoteip=Any localport=Any remoteport=22 action=allow > nul && echo ok
        )
    )

    for /d %%f in (^

        "%ProgramFiles%\WinSCP\WinSCP.exe",^
        "%ProgramFiles(x86)%\WinSCP\WinSCP.exe",^

        ) do if exist "%%~f" (

            echo | set /p="Allowing Firewall\Custom Rules - %%~nf... "
            netsh advfirewall firewall add rule name="Custom Rules - %%~nf" dir=Out protocol=tcp program="%%~f" remoteip=Any localport=Any remoteport=22 action=allow > nul && echo ok
        )
    )

    for /d %%f in (^

        "%ProgramFiles(x86)%\Microsoft Visual SourceSafe\ssexp.exe"^,
        "%ProgramFiles%\Git\mingw64\libexec\git-core\git-remote-https.exe",^
        "%ProgramFiles(x86)%\Git\mingw64\libexec\git-core\git-remote-https.exe",^

        ) do if exist "%%~f" (

            echo | set /p="Allowing Firewall\Custom Rules - %%~nf... "
            netsh advfirewall firewall add rule name="Custom Rules - %%~nf" dir=Out protocol=tcp program="%%~f" remoteip=Any localport=Any remoteport=Any action=allow > nul && echo ok
        )
    )

    goto :eof


:all

    call :policies
    call :settings
    call :services
    call :features
    call :programs
    call :schedule
    call :firewall
    goto :eof

:eof
