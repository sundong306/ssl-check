Name:		ssl-check
Version:	v1.0.0
Release:	centos%{?dist}
Summary:	检查 SSL 证书颁发时间、到期时间

Group:		Network
License:	GPL
Vendor:		ZHUANGZHUANG
Packager:	ZHUANGZHUANG <mail@zhuangzhuang.ml>
URL:		https://zhuangzhuang.io

SOURCE0:	%{name}
Provides:	%{name}
Requires:	curl coreutils util-linux systemd 
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

%install
mkdir -p %{buildroot}/usr/local/bin/
cp -a %{SOURCE0} %{buildroot}/usr/local/bin/

%clean
rm -rf %{buildroot} %{_builddir}

%files
%defattr(-,root,root,-)
/usr/local/bin/%{name}

%description
检查 SSL 证书颁发时间、到期时间
