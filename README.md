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


### cleanup.cmd

The script cleans the Windows registry and the hard disk from temporary files, caches, browsing history, logs, and general trash files not necessary for the proper functioning of Windows.

The script can be executed with one of the following command line options:

- `cleanup harddisk` - cleans the disk from caches, browsing history, temporary, log and trash files
- `cleanup registry` - cleans the explorer folder view settings
- `cleanup all` - executes all the options above one after another (the default)


### compress.cmd

The script uses ImageMagic and FFmpeg to batch compress image, audio and video files. The compression is achieved by proper configuration of the compression algorithms (up to x10) for image files, and by choice of codecs with better compression ratio (up to x3) for audio and video files.

Use `compress [SOURCE] [TARGET]` to compress the desired media files, where `SOURCE` is the wild card mask of the desired files (defaults to `*.*`) and `TARGET` is the output directory (defaults to `%TEMP%`).


### execute.cmd

The script chooses the proper toolchain to (optionally) compile and then execute a C/C++, Rust, PHP, JavaScript, TypeScript, Python, Bash, Makefile, Docker or docker-compose source code.

Use `execute SOURCE` to execute the desired source files, where `SOURCE` is the wild card mask of the desired files.


## Contributing

Feature requests, bug reports and success stories are most welcome.


## Copyright

Copyright 2018 Quasis - The MIT License
