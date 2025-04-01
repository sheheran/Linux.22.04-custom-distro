To check if the host build system has all needed installed packages to build the Ssystem - version-check.sh

ERROR: Cannot find gawk (Gawk)

ERROR: Cannot find texi2any (Texinfo)

ERROR: awk  is NOT GNU

ERROR: sh   is NOT Bash - sh (shell) command on the system is not linked to bash. It might be linked to another shell implimentation such as dash.
To check "ls -l /bin/sh" example output if link to dash /bin/sh -> dash
TO change "sudo dpkg-reconfigure dash". When prompted, choose "No" to make sh point to bash.

2.6 - Setting The $LFS Variable


3.1 - Getting required packages


4.2 - Creating the base directories needed for the base environment

4.3 - Adding LFS User
4.4 - Setting Up the Environment

Purpose of this Script in an LFS Build System 
1. Creates an isolated user (minmin) for the build process to prevent breaking the host system.
Login as user will crearte unwanted problems, if mistakes happend
