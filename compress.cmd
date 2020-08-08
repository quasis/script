::
:: NAME
::
::     compress - media compression script for Microsoft Windows
::
:: SYNOPSIS
::
::     compress [source] [target]
::
:: DESCRIPTION
::
::     This script uses ImageMagic and FFmpeg to batch compress image, audio and
::     video files.   The compression is achieved by proper configuration of the
::     encoding algorithms (up to x10) for images,  and by choice of codecs with
::     better compression ratio (up to x3) for audio and video files.
::
::     Virtual Hard Disks (VHD / VHDX) are compressed using the builtin diskpart
::     utility.
::
:: OPTIONS
::
::     source
::         Specifies the name/mask of the source files (default value is "*.*").
::
::     target
::         Specifies the target (or output) directory (default value is %TEMP%).
::
:: ENVIRONMENT
::
::     The script will function if the following environment variables are set:
::
::     MAGICK_HOME
::         Variable holding the path to the installation folder of ImageMagick.
::
:: LICENSE
::
::     Copyright 2018 Quasis (info@quasis.io) - The MIT Licence
::

@echo off
@setLocal EnableDelayedExpansion

if not exist "%MAGICK_HOME%" (

    for /d %%f in (^

        "%ProgramFiles%\ImageMagick",^
        "%ProgramFiles(x86)%\ImageMagick",^

        ) do if exist "%%~f" (
            set MAGICK_HOME=%%~f
        )
    )

    if not exist "%MAGICK_HOME%" (
        echo Failed to locate ImageMagick directory.
        goto :eof
    )
)

if "%~1" neq "" (set SOURCE=%~1) else (set SOURCE=*)
if "%~2" neq "" (set TARGET=%~2) else (set TARGET=%TEMP%)
if not exist "%TARGET%" mkdir "%TARGET%"

for %%f in ("%SOURCE%") do if exist "%%f" (

    if "%%~xf" == ".png"  (call :png "%%f" "%TARGET%\%%~nf")
    if "%%~xf" == ".jpg"  (call :jpg "%%f" "%TARGET%\%%~nf")
    if "%%~xf" == ".webp" (call :jpg "%%f" "%TARGET%\%%~nf")
    if "%%~xf" == ".mp3"  (call :mp3 "%%f" "%TARGET%\%%~nf")
    if "%%~xf" == ".mp4"  (call :mp4 "%%f" "%TARGET%\%%~nf")
    if "%%~xf" == ".mpg"  (call :mpg "%%f" "%TARGET%\%%~nf")
    if "%%~xf" == ".avi"  (call :avi "%%f" "%TARGET%\%%~nf")
    if "%%~xf" == ".3gp"  (call :3gp "%%f" "%TARGET%\%%~nf")
    if "%%~xf" == ".vhd"  (call :vhd "%%f")
    if "%%~xf" == ".vhdx" (call :vhd "%%f")
)

for /D %%d in ("%SOURCE%") do if exist "%%d" (
    call "%0" "%%d\*" "%TARGET%\%%~nd"
)


@goto :eof


:png

    echo | set /p="Compressing %~1 -> %~2.png... "
    "%MAGICK_HOME%\convert.exe" "%~1" -strip -auto-level -resize "4096>x4096>" -type palette -interlace none -define png:exclude-chunk=all -define png:compression-filter=5 -define png:compression-strategy=0 -define png:compression-level=9 "%~2.png" > nul
    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:jpg

    echo | set /p="Compressing %~1 -> %~2.jpg... "
    "%MAGICK_HOME%\convert.exe" "%~1" -strip -auto-level -resize "4096>x4096>" -sampling-factor 4:2:0 -quality 85 -interlace Plane -colorspace RGB -define jpeg:dct-method=float "%~2.jpg" > nul
    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:webp

    echo | set /p="Compressing %~1 -> %~2.jpg... "
    "%MAGICK_HOME%\convert.exe" "%~1" -strip -auto-level -resize "4096>x4096>" -sampling-factor 4:2:0 -quality 85 -interlace Plane -colorspace RGB -define jpeg:dct-method=float "%~2.jpg" > nul
    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:mp3

    echo | set /p="Compressing %~1 -> %~2.mp3... "
    "%MAGICK_HOME%\ffmpeg.exe" -i "%~1" -acodec mp3 -y "%~2.mp3" > nul 2>&1
    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:mp4

    echo | set /p="Compressing %~1 -> %~2.mp4... "
    "%MAGICK_HOME%\ffmpeg.exe" -i "%~1" -acodec mp3 -vcodec h264 -y "%~2.mp4" > nul 2>&1
    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:mpg

    echo | set /p="Compressing %~1 -> %~2.mp4... "
    "%MAGICK_HOME%\ffmpeg.exe" -i "%~1" -acodec mp3 -vcodec h264 -y "%~2.mp4" > nul 2>&1
    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:avi

    echo | set /p="Compressing %~1 -> %~2.mp4... "
    "%MAGICK_HOME%\ffmpeg.exe" -i "%~1" -acodec mp3 -vcodec h264 -y "%~2.mp4" > nul 2>&1
    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:3gp

    echo | set /p="Compressing %~1 -> %~2.mp4... "
    "%MAGICK_HOME%\ffmpeg.exe" -i "%~1" -acodec mp3 -vcodec h264 -y "%~2.mp4" > nul 2>&1
    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:vhd

    echo | set /p="Compressing %~1... "

   (echo select vdisk file="%~1"
    echo attach vdisk readonly
    echo compact vdisk
    echo detach vdisk
    echo exit
    ) | diskpart > nul 2>&1

    if errorlevel 0 (echo ok) else (echo error)
    goto :eof

:eof
