::
:: NAME
::
::     cleanup - disk and registry cleaning script for Microsoft Windows 7/8/10
::
:: SYNOPSIS
::
::     cleanup [harddisk|registry|all]
::
:: DESCRIPTION
::
::     Instances of Microsoft Windows accumulate excess of cruft over time. That
::     cruft wastes the precious disk space and slows down the operating system.
::     This script cleans the Windows registry and the disk from temporary files,
::     caches, browsing history, logs, and general trash files not necessary for
::     the proper functioning of Windows.
::
:: OPTIONS
::
::     harddisk
::         Cleans cache, browsing history, log files, temporary files and trash.
::
::     registry
::         Cleans the Windows registry from recent files & folder view settings.
::
::     all
::         Executes the script with all the options listed above (the default).
::
:: LICENSE
::
::     Copyright 2018 Quasis (info@quasis.io) - The MIT Licence
::

@echo off
@setLocal EnableDelayedExpansion

net session > nul 2>&1 & if not errorlevel 0 (
    echo Please run the script as Administrator.
) else (
    if "%1" == "" (call :all) else (call :%1)
)

@goto :eof


:harddisk


    :: Harddisk\C:\Windows

    echo | set /p="Cleaning %SystemRoot%\System32\winevt\Logs\*.*... "
    for /f "tokens=*" %%l in ('wevtutil el') do (wevtutil cl "%%l")
    if errorlevel 0 (echo ok) else (echo error)

    for /d %%f in (^

        "%SystemRoot%\Downloaded Program Files",^
        "%SystemRoot%\Logs\CBS",^
        "%SystemRoot%\Offline Web Pages"
        "%SystemRoot%\Panther",^
        "%SystemRoot%\Prefetch",^
        "%SystemRoot%\SoftwareDistribution\Download",^
        "%SystemRoot%\Temp",^

    ) do if exist "%%~f" (

        echo | set /p="Deleting %%~f\*.*... "
        pushd "%%~f" && (rd /s /q "%%~f" 2>nul & popd)
        if errorlevel 0 (echo ok) else (echo error)
    )


    :: Harddisk\C:\ProgramData

    for /d %%f in (^

        "%AllUsersProfile%\Dell\UpdatePackage\Log",^
        "%AllUsersProfile%\Microsoft\Windows Defender\Scans\History\Results\*",^
        "%AllUsersProfile%\Microsoft\WLSetup\Logs",^
        "%AllUsersProfile%\Package Cache",^
        "%AllUsersProfile%\Intel\ShaderCache",^

    ) do if exist "%%~f" (

        echo | set /p="Deleting %%~f\*.*... "
        pushd "%%~f" && (rd /s /q "%%~f" 2>nul & popd)
        if errorlevel 0 (echo ok) else (echo error)
    )


    :: Harddisk\C:\Users

    for /d %%u in (%SystemDrive%\Users\*) do (

        for /d %%f in (^

            "%%u\.*",^
            "%%u\AppData\Local\CrashDumps",^
            "%%u\AppData\Local\deno",^
            "%%u\AppData\Local\Microsoft\CLR_v4.0\UsageLogs",^
            "%%u\AppData\Local\Microsoft\CLR_v4.0_32\UsageLogs",^
            "%%u\AppData\Local\Microsoft\Feeds Cache",^
            "%%u\AppData\Local\Microsoft\Internet Explorer\Recovery\*",^
            "%%u\AppData\Local\Microsoft\Terminal Server Client\Cache",^
            "%%u\AppData\Local\Microsoft\Windows\AppCache",^
            "%%u\AppData\Local\Microsoft\Windows\Explorer",^
            "%%u\AppData\Local\Microsoft\Windows\History",^
            "%%u\AppData\Local\Microsoft\Windows\INetCache",^
            "%%u\AppData\Local\Microsoft\Windows\INetCookies",^
            "%%u\AppData\Local\Microsoft\Windows\Temporary Internet Files",^
            "%%u\AppData\Local\Microsoft\Windows\WebCache",^
            "%%u\AppData\Local\Microsoft\WLSetup\Logs",^
            "%%u\AppData\Local\pip",^
            "%%u\AppData\Local\Temp",^
            "%%u\AppData\Local\TortoiseGit",^
            "%%u\AppData\LocalLow\Intel\ShaderCache",^
            "%%u\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content",^
            "%%u\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData",^
            "%%u\AppData\LocalLow\Microsoft\Internet Explorer\DOMStore",^
            "%%u\AppData\LocalLow\Microsoft\Windows\AppCache",^
            "%%u\AppData\Roaming\Downloaded Installations",^
            "%%u\AppData\Roaming\Microsoft Visual Studio\logs",^
            "%%u\AppData\Roaming\Microsoft\Office\Recent",^
            "%%u\AppData\Roaming\Microsoft\Windows\Cookies",^
            "%%u\AppData\Roaming\Microsoft\Windows\Recent",^
            "%%u\AppData\Roaming\Opera Software\Opera Stable\Crash Reports",^

        ) do if exist "%%~f" (

            echo | set /p="Deleting %%~f\*.*... "
            pushd "%%~f" && (rd /s /q "%%~f" 2>nul & popd)
            if errorlevel 0 (echo ok) else (echo error)
        )
    )


    :: Harddisk\*:\$

    for /f %%d in ('wmic logicaldisk where "FileSystem='NTFS'" get name') do if exist "%%d\" (

        for /d %%f in ("%%d\$Extend\$UsnJrnl:$J:$DATA") do (

            echo | set /p="Deleting %%~f\*.*... "
            fsutil usn deletejournal /d %%d > nul
            if errorlevel 0 (echo ok) else (echo error)
        )

        for /d %%f in ("%%d\$RECYCLE.BIN") do if exist "%%~f" (

            echo | set /p="Deleting %%~f\*.*... "
            pushd "%%~f" && (rd /s /q "%%~f" 2>nul & popd)
            if errorlevel 0 (echo ok) else (echo error)
        )
    )


    :: Harddisk\Cleanmgr

    for %%i in (^
        "Active Setup Temp Folders",^
        "BranchCache",^
        "Content Indexer Cleaner",^
        "D3D Shader Cache",^
        "Delivery Optimization Files",^
        "Device Driver Packages",^
        "Diagnostic Data Viewer database files",^
        "DirectX Shader Cache",^
        "Downloaded Program Files",^
        "DownloadsFolder",^
        "GameNewsFiles",^
        "GameStatisticsFiles",^
        "GameUpdateFiles",^
        "Internet Cache Files",^
        "Language Pack",^
        "Language Resource Files",^
        "Memory Dump Files",^
        "Offline Pages Files",^
        "Old ChkDsk Files",^
        "Previous Installations",^
        "Recycle Bin",^
        "RetailDemo Offline Content",^
        "Service Pack Cleanup",^
        "Setup Log Files",^
        "System error memory dump files",^
        "System error minidump files",^
        "Temporary Files",^
        "Temporary Setup Files",^
        "Temporary Sync Files",^
        "Thumbnail Cache",^
        "Update Cleanup",^
        "Upgrade Discarded Files",^
        "User file versions",^
        "Windows Defender",^
        "Windows ESD installation files",^
        "Windows Error Reporting Archive Files",^
        "Windows Error Reporting Files",^
        "Windows Error Reporting Queue Files",^
        "Windows Error Reporting System Archive Files",^
        "Windows Error Reporting System Queue Files",^
        "Windows Upgrade Log Files",^
        "Windows error reports and feedback diagnostics",^
    ) do (

        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\%%~i" /t REG_DWORD /v StateFlags0100 /d 2 /f > nul
    )


    echo | set /p="Starting %SystemRoot%\system32\cleanmgr.exe... "
    cleanmgr.exe /sagerun:100 > nul
    if errorlevel 0 (echo ok) else (echo error)

    goto :eof


:registry


    for %%i in (^

        "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU",^
        "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags",^
        "HKCU\SOFTWARE\Classes\Wow6432Node\Local Settings\Software\Microsoft\Windows\Shell\BagMRU",^
        "HKCU\SOFTWARE\Classes\Wow6432Node\Local Settings\Software\Microsoft\Windows\Shell\Bags",^
        "HKCU\SOFTWARE\Microsoft\Windows\Shell\BagMRU",^
        "HKCU\SOFTWARE\Microsoft\Windows\Shell\Bags",^
        "HKCU\SOFTWARE\Microsoft\Windows\ShellNoRoam\BagMRU",^
        "HKCU\SOFTWARE\Microsoft\Windows\ShellNoRoam\Bags",^
        "HKCU\Software\Microsoft\Office\16.0\Word\Reading Locations",^

    ) do reg query "%%~i" > nul 2>&1 && if errorlevel 0 (

        echo | set /p="Deleting %%~i\*.*... "
        reg delete "%%~i" /f > nul & reg add "%%~i" > nul
        if errorlevel 0 (echo ok) else (echo error)
    )


    goto :eof


:all

    call :harddisk
    call :registry
    goto :eof

:eof
