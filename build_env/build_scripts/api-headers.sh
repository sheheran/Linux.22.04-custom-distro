echo "api-headers"
sleep 1

cd $LFS/sources
tar -xf linux-6.13.4.tar.xz
cd linux-6.13.4

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr


cd $LFS/sources
rm -rf linux-6.13.4