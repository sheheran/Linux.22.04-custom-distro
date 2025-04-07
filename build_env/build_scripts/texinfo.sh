echo "texinfo-7.2"
sleep 1

cd $LFS/sources
tar -xf texinfo-7.2.tar.xz
cd texinfo-7.2

./configure --prefix=/usr

make
make install DESTDIR=$LFS


cd $LFS/sources
rm -rf texinfo-7.2