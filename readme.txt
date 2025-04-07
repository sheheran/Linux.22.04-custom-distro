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


Permission for User Profile

When creating a user profile "minmin" and at the same-time "minmin" group is added. 
The Home>minmin is added to the home of the default user so the read/write and execute permissions should be granted

To add user group 
sudo chown -R minindu:minmin /minindu-minmin/
ls -al /minindu-minmin/Linux.22.04-custom-distro/build_env/
sudo chown -R minindu:minmin /home/

To add Read/Write and Execute permission
chmod 750 minindu-minmin
chmod 700 minindu-minmin
sudo chmod -R g+rw /home/
sudo chmod -R g+rw /minindu-minmin/Linux.22.04-custom-distro/build_env/build_root


-R: Apply recursively to all files and directories

drwxr-xr-x 2 minindu minmin 4096 Apr  6 10:39 .
Owner (minindu): rwx
Group (minmin): r-x
Others: r-x

Category	Digit		Binary		Permissions		Meaning
Owner		7			111			rwx				Read, write, and execute
Group		7			111			rwx				Read, write, and execute
Others		0			000			---				No permissions

sudo usermod -aG minindu minmin
This added the user minmin to the supplementary group minindu.

sudo chown minindu:minmin /minindu-minmin/home
Changes the owner to minindu
Changes the group to minmin

sudo usermod -aG minindu minmin
Adds user minmin to group minindu
	- minmin now becomes a member of the group minindu.
	- It does NOT change file ownership or primary group of minmin.
	- It adds group-based access rights to minmin for any files/directories owned by group minindu and permitted to that group.
	(but only if group permissions allow it.)

usermod -aG minindu minmin	Adds user minmin to group minindu
chmod -R g+rwX	Grants group members the needed access