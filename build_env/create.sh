#Distribution Root and LFS variables
echo "Dist Root: ${DIST_ROOT:?}"
echo "LFS: ${LFS:?}"

# if not user minmin build environment dose not run
# chmod 777 ./create.sh
if ! test $(whoami) == 'minmin" ; then
	echo "Must run as minmin!"
	exit -i
fi

echo "Creating a build environment......"
