#!/bin/bash
# See: http://blog.yug1224.com/2014/02/05/centos-git/
sudo yum install -y zlib-devel perl-devel gettext gcc curl-devel
wget https://git-core.googlecode.com/files/git-1.8.5.5.tar.gz
tar zxvf git-1.8.5.5.tar.gz
cd git-1.8.5.5
./configure
make
sudo make install
