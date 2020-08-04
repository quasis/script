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
::     execute a C/C++, JavaScript, TypeScript and Python source code.
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
::     PYTHON_PATH
::         Variable that defines additional directories for the packages search.
::
:: LICENSE
::
::     Copyright 2018 Quasis (info@quasis.io) - The MIT Licence
::

@echo off
@setLocal enabledelayedexpansion

if not exist "%LLVM_HOME%" (set LLVM_HOME=%ProgramFiles%\LLVM\bin)
if not exist "%DENO_HOME%" (set DENO_HOME=%ProgramFiles%\Deno)
if not exist "%PYTHON_HOME%" (set PYTHON_HOME=%ProgramFiles%\Python)

if "%1" neq "" (set SOURCE=%1) else (set SOURCE=%CD%\*.*)

for %%f in (%SOURCE%) do if exist "%%f" (

    if "%%~xf" == ".c"    (call :c   "%%f" "%TEMP%\%%~nf.exe")
    if "%%~xf" == ".cc"   (call :cpp "%%f" "%TEMP%\%%~nf.exe")
    if "%%~xf" == ".cpp"  (call :cpp "%%f" "%TEMP%\%%~nf.exe")
    if "%%~xf" == ".cxx"  (call :cpp "%%f" "%TEMP%\%%~nf.exe")
    if "%%~xf" == ".js"   (call :js  "%%f")
    if "%%~xf" == ".ts"   (call :ts  "%%f")
    if "%%~xf" == ".py"   (call :py  "%%f")
)

@goto :eof

:c

    if exist "%~2" del "%~2"

    if exist "%LLVM_HOME%\clang.exe" (
        "%LLVM_HOME%\clang.exe" -O3 -m64 -static -Wall -Wextra -Wpedantic --target=x86_64-pc-windows-msvc "%~1" -o "%~2"
    )

    if exist "%~2" "%~2"
    goto :eof

:cpp

    if exist "%~2" del "%~2"

    if exist "%LLVM_HOME%\clang++.exe" (
        "%LLVM_HOME%\clang++.exe" -O3 -std=c++2a -m64 -static -Wall -Wextra -Wpedantic --target=x86_64-pc-windows-msvc "%~1" -o "%~2"
    )

    if exist "%~2" "%~2"
    goto :eof

:js

    if exist "%DENO_HOME%\deno.exe" (
        "%DENO_HOME%\deno.exe" run --allow-all "%~1"
    )

    goto :eof

:ts

    if exist "%DENO_HOME%\deno.exe" (
        "%DENO_HOME%\deno.exe" run --allow-all "%~1"
    )

    goto :eof

:py

    if exist "%PYTHON_HOME%\python.exe" (

        if "%PYTHON_PATH%" neq "" (
            set PYTHONPATH=%PYTHONPATH%;%PYTHON_PATH%
        )

        "%PYTHON_HOME%\python.exe" -B "%~1"
    )

    goto :eof

:eof
