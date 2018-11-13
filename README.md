# Script

Repository of batch scripts for optimization of Microsoft Windows 7/8/10 and compression of media files.


## Scripts

The repository contains three scripts: enhance, cleanup and compress.


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
- `enhance all` - executes all the options above one after another

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
- `cleanup registry` - TBD
- `cleanup all` - executes all the options above one after another


### compress.cmd

The script uses ImageMagic and FFmpeg to batch compress image, audio and video files. The compression is achieved by proper configuration of the compression algorithms (up to x10) for image files, and by choice of codecs with better compression ratio (up to x3) for audio and video files.

Use `compress [source] [target]` to compress the desired media files, where `source` is the wild card mask of the desired files (defaults to `*.*`) and `target` is the output directory (defaults to `%TEMP%`).

The following environment variables have to be set prior to execution of the script:

- `MAGICK_HOME` - should hold the path to the bin directory of [ImageMagick](https://imagemagick.org/script/download.php)
- `FFMPEG_HOME` - should hold the path to the bin directory of [FFmpeg](https://ffmpeg.zeranoe.com/builds/)


## Contributing

Feature requests, bug reports and success stories are most welcome.


## License

Copyright 2018 Quasis (info@quasis.io) - The MIT License
