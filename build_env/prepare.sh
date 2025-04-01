#Distribution Root and LFS variables
echo "Dist Root: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"
# export DIST_ROOT=/home/minindu/Documents/Linux.22.04-custom-distro
# export LFS=$DIST_ROOT/build_env/build_root
#ls -ls $LFS/
mkdir $LFS/sources


# Download missing packages
for f in $(cat "$DIST_ROOT/build_env/build_env_list"); do
    bn=$(basename "$f")

    echo "Checking: $bn"

    # Check if the file exists before downloading
    if [ ! -f "$LFS/sources/$bn" ]; then
        echo "Downloading: $f"
        wget "$f" -O "$LFS/sources/$bn"
    else
        echo "Already exists: $bn, skipping download."
    fi
done

# Verify if packages are installed
# for f in $(cat "$DIST_ROOT/build_env/build_env_list"); do
#     bn=$(basename "$f")
#     echo "Checking package: $bn"
#     apt list "$bn"
# done

# Creating essential base directories for the build system
mkdir -pv "$LFS/etc"
mkdir -pv "$LFS/var"
mkdir -pv "$LFS/usr/bin" "$LFS/usr/lib" "$LFS/usr/sbin"

for i in bin lib sbin; do
  ln -sv usr/$i "$LFS/$i"
done

# Check if the machine is x64 or x86
case $(uname -m) in
  x86_64) mkdir -pv "$LFS/lib64" ;;
esac

# Creating a user to build with 
if ! test $(id -u minmin) ; then # Only if user doesn't exist run to create the user
    groupadd minmin
    useradd -s /bin/bash -g minmin -m -k /dev/null minmin
    passwd minmin
    # Change the ownership of the different directories
    chown -v minmin "$LFS/etc" "$LFS/var"
    chown -v minmin "$LFS/usr/bin" "$LFS/usr/lib" "$LFS/usr/sbin"

    # Selecting between x64 and x86
    case $(uname -m) in
    x86_64) chown -v minmin "$LFS/lib64" ;;
    esac
    # home for the user
    dbhome=$(eval echo ~minmin)
    
    # cat and Redirect to the given file, until the input EOF is found
    cat > "$dbhome/.bash_profile" << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

    # Creating the bash.rc file
    cat > "$dbhome/.bashrc" << EOF
set +h
umask 022
LFS=$LFS
export DIST_ROOT=$DIST_ROOT
EOF

    cat >> "$dbhome/.bashrc" << "EOF"
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
export MAKEFLAGS="-j$(nproc)"
EOF

fi
