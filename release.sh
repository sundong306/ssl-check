#!/bin/bash

name=ssl-check
version=$(bash $name -v | awk '{print $2}')
release=packages
[ ! -d $release ] && mkdir -p $release
_date=$(date +"%s")

case $1 in 
	-h|--help|help|?)
		echo "Usage: $(basename $0) [ubuntu|centos]"
		;;
	centos)
	        sed -i "s/Version.*/Version:\t$version/" build/CentOS/$name.spec
		[ -d /root/rpmbuild ] && mv /root/rpmbuild /root/rpmbuild_bak_$_date
		mkdir -p /root/rpmbuild/{SOURCES,SPECS}
		cp build/CentOS/$name.spec /root/rpmbuild/SPECS
	       	cp $name /root/rpmbuild/SOURCES
		cd /root/rpmbuild/SPECS/
		rpmbuild -bb $name.spec
		cd -
		cp /root/rpmbuild/RPMS/*/*.rpm $release
		rm -rf /root/rpmbuild
		[ -d /root/rpmbuild_bak_$_date ] && mv /root/rpmbuild_bak_$_date /root/rpmbuild
		;;
	ubuntu)
	        sed "s/Version.*/Version:\t$version/" build/Ubuntu/control
		[ -d /root/debbuild ] && mv /root/debbuild /root/debbuild_bak_$_date
		mkdir -p /root/debbuild/{DEBIAN,/usr/local/bin}
		cp build/Ubuntu/control /root/debbuild/DEBIAN
		cp $name /root/debbuild/usr/local/bin
	        dpkg -b /root/debbuild $release/$name-$version-ubuntu.x86_64.deb
		rm -rf /root/debbuild
		[ -d /root/debbuild_bak_$_date ] && mv /root/debbuild_bak_$_date /root/debbuild
		;;
	*)
		$0 centos
		$0 ubuntu
esac
