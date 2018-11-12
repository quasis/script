::
:: NAME
::
::     compress - media compression script
::
:: SYNOPSIS
::
::     compress [SOURCE] [TARGET]
::
:: DESCRIPTION
::
::     This script uses ImageMagic and FFmpeg to batch compress image, audio and
::     video files.   The compression is achieved by proper configuration of the
::     encoding algorithms (up to x10) for images,  and by choice of codecs with
::     better compression ratio (up to x3) for audio and video files.
::
::     Use compress [SOURCE] [TARGET] to compress the desired media files, where
::     SOURCE is the wild card mask of the desired files (defaults to `*.*`) and
::     TARGET is the output directory (defaults to `%TEMP%`).
::
:: COPYRIGHT
::
::     Copyright 2018 Quasis - The MIT Licence
::

@echo off
@setLocal enableDelayedExpansion
@set MagickHome=%ProgramFiles%\ImageMagick

:compress

    if not exist "%MagickHome%" (
        echo ImageMagick is not found in "%MagickHome%" && exit /b 1
    )

    setLocal

    set script=%~0
    set source=%~1
    set target=%~2

    if "%source%" equ "" (
        set source=*
    )

    if "%target%" equ "" (
        set target=%TEMP%
    )

    if not exist "%target%" (
        mkdir "%target%"
    )

    for %%f in ("%source%") do (

        if "%%~xf" == ".jpg"  (call :webp "%%f" "%target%\%%~nf")
        if "%%~xf" == ".png"  (call :webp "%%f" "%target%\%%~nf")
        if "%%~xf" == ".webp" (call :webp "%%f" "%target%\%%~nf")
        if "%%~xf" == ".mp3"  (call :mp3 "%%f" "%target%\%%~nf")
        if "%%~xf" == ".3gp"  (call :mp4 "%%f" "%target%\%%~nf")
        if "%%~xf" == ".avi"  (call :mp4 "%%f" "%target%\%%~nf")
        if "%%~xf" == ".mp4"  (call :mp4 "%%f" "%target%\%%~nf")
        if "%%~xf" == ".mpg"  (call :mp4 "%%f" "%target%\%%~nf")
        if "%%~xf" == ".vob"  (call :mp4 "%%f" "%target%\%%~nf")
    )

    for /D %%d in ("%source%") do (
        call "%script%" "%%d\*" "%target%\%%~nd"
    )

    endLocal
    goto :eof

:jpg

    echo | set /p="Compressing %~1 -> %~2.jpg... "
    "%MagickHome%\magick.exe" "%~1" -quiet -strip -auto-level -resize "4096>x4096>" -sampling-factor 4:2:0 -quality 75 -interlace Plane -colorspace sRGB -define jpeg:dct-method=float "%~2.jpg" && echo ok
    goto :eof

:png

    echo | set /p="Compressing %~1 -> %~2.png... "
    "%MagickHome%\magick.exe" "%~1" -quiet -strip -auto-level -resize "4096>x4096>" -type palette -interlace none -define png:exclude-chunk=all -define png:compression-filter=5 -define png:compression-strategy=0 -define png:compression-level=9 "%~2.png" && echo ok
    goto :eof

:webp

    echo | set /p="Compressing %~1 -> %~2.webp... "
    "%MagickHome%\magick.exe" "%~1" -quiet -strip -auto-level -resize "4096>x4096>" -define webp:method=6 "%~2.webp" && echo ok
    goto :eof

:mp3

    echo | set /p="Compressing %~1 -> %~2.mp3... "
    "%MagickHome%\ffmpeg.exe" -nostats -loglevel error -i "%~1" -preset slow -acodec mp3 -y "%~2.mp3" && echo ok
    goto :eof

:mp4

    echo | set /p="Compressing %~1 -> %~2.mp4... "
    "%MagickHome%\ffmpeg.exe" -nostats -loglevel error -i "%~1" -acodec aac -vcodec h264 -preset slow -y "%~2.mp4" && echo ok
    goto :eof

:eof
