# Script

Collection of batch scripts for optimization of Microsoft Windows and media files.


## Scripts

The collection includes three scripts: enhance, cleanup and compress.


### enhance.cmd

The script enhances the Windows baseline by disabling (or in extreme cases removing) the feature creep, stopping telemetry collection services, and limiting access to the potentially exploitable services & programs.

To enhance Windows group policies run:

    enhance policies

To enhance settings of the current user run:

    enhance settings

To disable telemetry and bloatware services run:

    enhance services

To disable useless and obsolete Windows features run:

    enhance features

To remove preinstalled bloatware applications run:

    enhance programs

To disable tasks that collect statistics and telemetry run:

    enhance schedule

To cut off excessive and insecure network communications run:

    enhance firewall

To run everything at once run:

    enhance all

Note, that "enhance firewall" will block most of the inbound and outbound traffic, including your web browser. You can either create a manual firewall rule for the Web browser after the script execution, or define a subset of the following environment variables prior to execution of the script:

- CLIENT_HTTP - should hold the path to the exe file of the default HTTP Client (such as Firefox)
- CLIENT_MAIL - should hold the path to the exe file of the default Mail Client (such as Outlook)
- CLIENT_SSH - should hold the path to the exe file of the default SSH Client (such as Putty)
- CLIENT_SCP - should hold the path to the exe file of the default SCP Client (such as WinSCP)
- CLIENT_VCS - should hold the path to the exe file of the default VCS Client (such as Git)


### cleanup.cmd

The script cleans the Windows registry and the hard disk from temporary files, caches, browsing history, logs, and general trash files not necessary for the proper functioning of Windows.

To clean the hard disk from cruft run:

    cleanup harddisk

To clean the registry from cruft run:

    cleanup registry

To clean both the hard disk and the registry run:

    cleanup all


### compress.cmd

The script uses ImageMagic and FFmpeg to batch compress image, audio and video files. The compression is achieved by proper configuration of the compression algorithms (up to x10) for image files, and by choice of codecs with better compression ratio (up to x3) for audio and video files.

The script requires the following environment variables to be set:

- MAGICK_HOME - should hold the path to the bin directory of [ImageMagic](https://imagemagick.org/script/download.php)
- FFMPEG_HOME - should hold the path to the bin directory of [FFmpeg](https://ffmpeg.zeranoe.com/builds/)

To compress the desired media files run the following command:

    compress [source] [target]

where [source] is the wildcard mask of the desired files (defaults to \*.\*) and [target] is the output directory (defaults to %TEMP%).


## Contributing

Feature requests, bug reports and success stories are most welcome.

## License

Copyright 2018 Quasis (info@quasis.io) - The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.