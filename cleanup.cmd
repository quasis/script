::
:: NAME
::
::     cleanup - disk and registry cleaning script for Microsoft Windows 7/8/10
::
:: SYNOPSIS
::
::     cleanup harddisk|registry|all
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
::         TBD
::
::     all
::         Executes the script with all the options listed above.
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
    call :%1
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
            "%%u\AppData\Local\Temp",^
            "%%u\AppData\Local\TortoiseGit",^
            "%%u\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content",^
            "%%u\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData",^
            "%%u\AppData\LocalLow\Microsoft\Internet Explorer\DOMStore",^
            "%%u\AppData\LocalLow\Microsoft\Windows\AppCache",^
            "%%u\AppData\Roaming\Downloaded Installations",^
            "%%u\AppData\Roaming\Microsoft Visual Studio\logs",^
            "%%u\AppData\Roaming\Microsoft\Office\Recent",^
            "%%u\AppData\Roaming\Microsoft\Windows\Cookies",^
            "%%u\AppData\Roaming\Microsoft\Windows\Recent",^
            "%%u\AppData\Roaming\Visual Studio Setup",^

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
        "Downloaded Program Files",^
        "GameNewsFiles",^
        "GameStatisticsFiles",^
        "GameUpdateFiles",^
        "Internet Cache Files",^
        "Memory Dump Files",^
        "Offline Pages Files",^
        "Old ChkDsk Files",^
        "Previous Installations",^
        "Recycle Bin",^
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
        "Windows Error Reporting Archive Files",^
        "Windows Error Reporting Queue Files",^
        "Windows Error Reporting System Archive Files",^
        "Windows Error Reporting System Queue Files",^
        "Windows ESD installation files",^
        "Windows Upgrade Log Files",^

    ) do (

        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\%%~i" /t REG_DWORD /v StateFlags0100 /d 2 /f > nul
    )


    echo | set /p="Starting %SystemRoot%\system32\cleanmgr.exe... "
    cleanmgr.exe /sagerun:100 > nul
    if errorlevel 0 (echo ok) else (echo error)

    goto :eof


:registry


    goto :eof


:all

    call :harddisk
    call :registry
    goto :eof

:eof
