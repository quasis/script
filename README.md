# Script

Repository of batch scripts for optimization of Microsoft Windows 7/8/10 and compression of media files.


## Scripts

The repository contains four scripts: enhance, cleanup, compress and execute.


### enhance.cmd

The script enhances the Windows baseline by disabling (or in extreme cases removing) the feature creep, stopping telemetry collection services, and limiting access to potentially exploitable services & programs.

The script can be executed with one of the following command line options:

- `enhance policies` - defines a set of group policies to prevent security and privacy breaches
- `enhance settings` - defines a set of user settings for better usability and privacy protection
- `enhance services` - disables telemetry and bloatware services
- `enhance features` - disables useless and obsolete Windows features
- `enhance programs` - disables or removes preinstalled bloatware applications
- `enhance schedule` - disables scheduled tasks that collect statistical and telemetry data
- `enhance firewall` - cuts off excessive and insecure network communications
- `enhance all` - executes all the options above one after another (the default)

Note, that `enhance firewall` will block most of the inbound and outbound traffic, including the web browser. You can either create a firewall rule for the web browser manually after execution of the script, or define a subset of the following environment variables prior to execution of the script:

- `CLIENT_HTTP` - defines the path to the executable file of the default HTTP Client (such as Firefox)
- `CLIENT_MAIL` - defines the path to the executable file of the default Mail Client (such as Outlook)
- `CLIENT_SSH` - defines the path to the executable file of the default SSH Client (such as Putty)
- `CLIENT_SCP` - defines the path to the executable file of the default SCP Client (such as WinSCP)
- `CLIENT_VCS` - defines the path to the executable file of the default VCS Client (such as Git)


### cleanup.cmd

The script cleans the Windows registry and the hard disk from temporary files, caches, browsing history, logs, and general trash files not necessary for the proper functioning of Windows.

The script can be executed with one of the following command line options:

- `cleanup harddisk` - cleans the disk from caches, browsing history, temporary, log and trash files
- `cleanup registry` - cleans the explorer folder view settings
- `cleanup all` - executes all the options above one after another (the default)


### compress.cmd

The script uses ImageMagic and FFmpeg to batch compress image, audio and video files. The compression is achieved by proper configuration of the compression algorithms (up to x10) for image files, and by choice of codecs with better compression ratio (up to x3) for audio and video files.

Use `compress [source] [target]` to compress the desired media files, where `source` is the wild card mask of the desired files (defaults to `*.*`) and `target` is the output directory (defaults to `%TEMP%`).

The following environment variables have to be set prior to execution of the script:

- `MAGICK_HOME` - should hold the path to the bin directory of [ImageMagick](https://imagemagick.org/script/download.php)


### execute.cmd

The script chooses the proper toolchain to (optionally) compile and then execute a C/C++, PHP, JavaScript, TypeScript, Python, Bash, Docker or docker-compose source code.

Use `execute [source]` to execute the desired source files, where `source` is the wild card mask of the desired files (defaults to `*.*`).

The following environment variables have to be set prior to execution of the script:

- `LLVM_HOME` - should hold the path to the bin directory of [LLVM](https://releases.llvm.org/download.html)
- `PHP_HOME` - should hold the path to the directory of [PHP](https://windows.php.net/download/)
- `DENO_HOME` - should hold the path to the directory of [Deno](https://github.com/denoland/deno/releases) executable
- `PYTHON_HOME` - should hold the path to the directory of [Python](https://www.python.org/downloads/windows) executable

To execute Bash scripts and docker files WSL 2 (Windows Subsystem for Linux 2) with Docker has to be installed on the local machine.

## Contributing

Feature requests, bug reports and success stories are most welcome.


## License

Copyright 2018 Quasis (info@quasis.io) - The MIT License
