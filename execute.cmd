::
:: NAME
::
::     execute - source code execution script for Microsoft Windows
::
:: SYNOPSIS
::
::     execute [source]
::
:: DESCRIPTION
::
::     This script chooses the proper toolchain to (optionally) compile and then
::     execute a C/C++, JavaScript and Python source code.
::
:: OPTIONS
::
::     source
::         Specifies the name/mask of the source files (default value is "*.*").
::
:: ENVIRONMENT
::
::     The script will function if the following environment variables are set:
::
::     LLVM_HOME
::         Variable that defines the path to the bin directory of LLVM.
::
::     DENO_HOME
::         Variable that defines the path to the directory of Deno executable.
::
::     PYTHON_HOME
::         Variable that defines the path to the directory of Python executable.
::
:: LICENSE
::
::     Copyright 2018 Quasis (info@quasis.io) - The MIT Licence
::

@echo off
@setLocal enabledelayedexpansion

if "%1" neq "" (set SOURCE=%1) else (set SOURCE=%CD%\*.*)

for %%f in (%SOURCE%) do if exist "%%f" (

    if "%%~xf" == ".cc"   (call :cc "%%f" "%TEMP%\%%~nf.exe")
    if "%%~xf" == ".cpp"  (call :cc "%%f" "%TEMP%\%%~nf.exe")
    if "%%~xf" == ".cxx"  (call :cc "%%f" "%TEMP%\%%~nf.exe")
    if "%%~xf" == ".js"   (call :js "%%f")
    if "%%~xf" == ".py"   (call :py "%%f")
)

@goto :eof

:cc

    if exist "%~2" del "%~2"

    if exist "%LLVM_HOME%" (
        "%LLVM_HOME%\clang++.exe" -O3 -std=c++2a -m64 -static -Wall -Wextra -Wpedantic --target=x86_64-pc-windows-msvc "%~1" -o "%~2"
    )

    if exist "%~2" "%~2"
    goto :eof

:js

    if exist "%DENO_HOME%" (
        "%DENO_HOME%\deno.exe" run --allow-all "%~1"
    )

    goto :eof

:py

    if exist "%PYTHON_HOME%" (
        "%PYTHON_HOME%\python.exe" -B "%~1"
    )

    goto :eof

:eof
