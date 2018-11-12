::
:: NAME
::
::     execute - source code execution script for Microsoft Windows
::
:: SYNOPSIS
::
::     execute SOURCE
::
:: DESCRIPTION
::
::     This script chooses the proper toolchain to (optionally) compile and then
::     execute a C/C++, PHP, JavaScript, TypeScript, Python, Bash, Docker or the
::     docker-compose YML source code.
::
::     Use "execute SOURCE" to execute the desired source files, where SOURCE is
::     the wild card mask of the desired files.
::
:: COPYRIGHT
::
::     Copyright 2018 Quasis - The MIT Licence
::

@echo off
@setLocal enableDelayedExpansion

@set DenoHome=%ProgramFiles%\Deno
@set DockerHome=%ProgramFiles%\Docker
@set LLVMHome=%ProgramFiles%\LLVM
@set NodeHome=%ProgramFiles%\Node
@set PHPHome=%ProgramFiles%\PHP
@set PythonHome=%ProgramFiles%\Python
@set WSLHome=%WINDIR%\System32

:execute

    setLocal
    set source=%~1

    if "%source%" equ "" (
        echo No source file specified && exit /b 1
    )

    for %%f in (%source%) do if exist "%%f" (

        if "%%~xf" == ".cmd"                 (call "%%f")

        if "%%~xf" == ".h"                   (call :c   "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".c"                   (call :c   "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".hh"                  (call :cpp "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".cc"                  (call :cpp "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".hpp"                 (call :cpp "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".cpp"                 (call :cpp "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".hxx"                 (call :cpp "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".cxx"                 (call :cpp "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".h++"                 (call :cpp "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".c++"                 (call :cpp "%%f" "%TEMP%\%%~nf")
        if "%%~xf" == ".js"                  (call :js  "%%f")
        if "%%~xf" == ".ts"                  (call :js  "%%f")
        if "%%~xf" == ".php"                 (call :php "%%f")
        if "%%~xf" == ".py"                  (call :py  "%%f")
        if "%%~xf" == ".rs"                  (call :rs  "%%f" "%TEMP%\%%~nf")
        if "%%~nxf" == "Cargo.toml"          (call :cargo "%%f" "%TEMP%")
        if "%%~xf" == ".sh"                  (call :sh  "%%f" "./%%~nxf")
        if "%%~xf" == ".mk"                  (call :makefile "%%f")
        if "%%~xf" == ".makefile"            (call :makefile "%%f")
        if "%%~xnf" == "Makefile"            (call :makefile "%%f")
        if "%%~xf" == ".dockerfile"          (call :dockerfile "%%f")
        if "%%~nxf" == "Dockerfile"          (call :dockerfile "%%f")
        if "%%~nxf" == "docker-compose.yaml" (call :dockercompose "%%f")
        if "%%~nxf" == "docker-compose.yml"  (call :dockercompose "%%f")
        if "%%~nxf" == "compose.yaml"        (call :dockercompose "%%f")
        if "%%~nxf" == "compose.yml"         (call :dockercompose "%%f")
        if "%%~nxf" == "stack.yaml"          (call :dockercompose "%%f")
        if "%%~nxf" == "stack.yml"           (call :dockercompose "%%f")
    )

    endLocal
    goto :eof

:c

    set "source=%~1"
    set "target=%~2"
    set /p header=< "!source!"

    if "!header:~0,3!" == "/*^!" (
        "%WSLHome%\wsl.exe" -u root sh -c "!header:~3!"
    ) else if exist "%LLVMHome%\bin\clang.exe" (
        "%LLVMHome%\bin\clang.exe" -Wall -Wextra -Wpedantic -O3 -s -m64 -static --target=x86_64-pc-windows-msvc "!source!" -o "!target!.exe" && "!target!.exe"
    ) else if exist "%WSLHome%\wsl.exe" (
        "%WSLHome%\wsl.exe" -u root sh -c "clang -Wall -Wextra -Wpedantic -O3 -s -m64 -static '$(wslpath -au !source:\=/!)' -o '$(wslpath -au !target:\=/!)' && ls -l '$(wslpath -au !target:\=/!)' && exec '$(wslpath -au !target:\=/!)'"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:cpp

    set "source=%~1"
    set "target=%~2"
    set /p header=< "!source!"

    if "!header:~0,3!" == "/*^!" (
        "%WSLHome%\wsl.exe" -u root sh -c "!header:~3!"
    ) else if exist "%LLVMHome%\bin\clang++.exe" (
        "%LLVMHome%\bin\clang++.exe" -xc++ -std=c++2b -Wall -Wextra -Wpedantic -O3 -s -m64 -static --target=x86_64-pc-windows-msvc "!source!" -o "!target!.exe" && "!target!.exe"
    ) else if exist "%WSLHome%\wsl.exe" (
        "%WSLHome%\wsl.exe" -u root sh -c "clang++ -xc++ -std=c++2b -Wall -Wextra -Wpedantic -O3 -s -m64 '$(wslpath -au !source:\=/!)' -o '$(wslpath -au !target:\=/!)' && ls -l '$(wslpath -au !target:\=/!)' && exec '$(wslpath -au !target:\=/!)'"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:js

    set "source=%~1"

    if exist "%DenoHome%\deno.exe" (
        set NO_COLOR=1 && "%DenoHome%\deno.exe" run --allow-all "!source!"
    ) else if exist "%NodeHome%\node.exe" (
        "%NodeHome%\node.exe" "!source!"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:php

    set "source=%~1"

    if exist "%PHPHome%\php.exe" (
        "%PHPHome%\php.exe" "!source!"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:py

    set "source=%~1"

    if exist "%PythonHome%\python.exe" (
        "%PythonHome%\python.exe" -B "!source!"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:rs

    set "source=%~1"
    set "target=%~2"
    set /p header=< "!source!"

    if "!header:~0,3!" == "/*^!" (
        "%WSLHome%\wsl.exe" -u root sh -c "!header:~3!"
    ) else if exist "%WSLHome%\wsl.exe" (
        "%WSLHome%\wsl.exe" -u root sh -c "rustc -Ccodegen-units=1 -Copt-level=3 -Cstrip=symbols -Cprefer-dynamic=yes '$(wslpath -au !source:\=/!)' -o '$(wslpath -au !target:\=/!)' && ls -l '$(wslpath -au !target:\=/!)' && exec '$(wslpath -au !target:\=/!)'"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:cargo

    set "source=%~1"
    set "target=%~2"

    if exist "%WSLHome%\wsl.exe" (
        "%WSLHome%\wsl.exe" -u root sh -c "cargo run --release --manifest-path '$(wslpath -au !source:\=/!)' --target-dir '$(wslpath -au !target:\=/!)'"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:sh

    set "source=%~1"

    if exist "%WSLHome%\wsl.exe" (
        "%WSLHome%\wsl.exe" -u root "$(wslpath -au !source:\=/!)"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:makefile

    set "source=%~1"

    if exist "%WSLHome%\wsl.exe" (
        "%WSLHome%\wsl.exe" -u root sh -c "make -f $(wslpath -au !source:\=/!)"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:dockerfile

    set "source=%~1"

    if exist "%DockerHome%\docker.exe" (
        "%DockerHome%\docker.exe" rm --force auto && "%DockerHome%\docker.exe" buildx build --network host --file="!source!" --tag auto:latest . && "%DockerHome%\docker.exe" run --rm --network host --name=auto auto:latest
    ) else if exist "%WSLHome%\wsl.exe" (
        "%WSLHome%\wsl.exe" -u root sh -c "docker rm --force auto && docker buildx build --network host --file='$(wslpath -au !source:\=/!)' --tag auto:latest . && docker run --rm --network host --user $USER -v $(pwd):/mnt/cwd --name=auto auto:latest"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:dockercompose

    set "source=%~1"

    if exist "%DockerHome%\docker.exe" (
        "%DockerHome%\docker.exe" compose --file "!source!" up --build --force-recreate --renew-anon-volumes --remove-orphans
    ) else if exist "%WSLHome%\wsl.exe" (
        "%WSLHome%\wsl.exe" -u root sh -c "DOCKER_BUILDKIT=1 docker compose --file '$(wslpath -au !source:\=/!)' up --build --force-recreate --renew-anon-volumes --remove-orphans"
    ) else (
        echo Failed to locate execution chain for "!source!" && exit /b 1
    )

    goto :eof

:eof
