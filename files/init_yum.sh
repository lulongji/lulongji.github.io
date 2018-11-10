#!/bin/bash

yum clean all
yum -y install

yum -y install nc gcc  gcc-c++ autoconf automake make unzip git git-core libtool pkgconfig tcpdump lrzsz which
yum -y install mysql-devel mysql-libs unixODBC-devel dos2unix gdb patch php
yum -y install libcurl libcurl-devel  curl-devel openssl-devel openssl libssl-devel
yum -y install libtermcap-devel  ncurses-devel flex bison libxml2-devel libxml2 pcre-devel bzip2
yum -y install pcre python python-devel python libevent libevent-devel memcached memcached-devel libmemcached
yum -y install libunistring libunistring-devel  ncurses-devel libjpeg-devel libtiff-devel libogg libogg-devel libvorbis libvorbis-devel
yum -y install expat-devel libzrtpcpp-devel zlib zlib-devel alsa-lib-deve perl-libs gdbm-devel libdb-devel uuid-devel  



yum -y install net-tools
yum -y install lrzsz
yum -y install wget
yum -y install vim*
yum install -y bzip2
yum install gnome-vfs2


yum -y update glibc
yum -y update glibc-common
yum -y update glibc-devel
yum -y update glibc-headers
yum -y update nscd
yum -y update gnutls
yum -y update kernel-tools
yum -y update kernel-tools-libs
yum -y update python-perf
yum -y update nettle
yum -y update kernel
yum -y update kernel-devel
yum -y update kernel-headers
yum -y update bind-libs-lite
yum -y update bind-license

