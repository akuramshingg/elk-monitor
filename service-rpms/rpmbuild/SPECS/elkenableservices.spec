# Don't try fancy stuff like debuginfo, which is useless on binary-only
# packages. Don't strip binary too
# Be sure buildpolicy set to do nothing
%define        __spec_install_post %{nil}
%define          debug_package %{nil}
%define        __os_install_post %{_dbpath}/brp-compress

Summary: Helper package to enable ELK-monitor services on grid nodes
Name: elkenableservices
Version: 1.0
Release: 1
License: Apache
Group: Development/Tools
SOURCE0 : %{name}-%{version}.tar.gz
URL: http://www.gridgain.com/

BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description
%{summary}

%prep
%setup -q

%build
# Empty section.

%install
rm -rf %{buildroot}
mkdir -p  %{buildroot}

# in builddir
cp -a * %{buildroot}


%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
#%config(noreplace) %{_sysconfdir}/%{name}/%{name}.conf
%{_bindir}/*

%post
chmod 0777 /etc/filebeat
chmod 0666 /etc/filebeat/*
systemctl enable filebeat

%preun
systemctl disable filebeat

%changelog
* Sat Oct 30 2017  Max Shonichev <mshonichev@gridgain.com> 1.0-1
- Starts and enables autostart of ELK Filebeat service
