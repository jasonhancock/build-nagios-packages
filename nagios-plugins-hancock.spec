Summary:        Nagios monitoriing tools from Jason Hancock
Name:           nagios-plugins-hancock
Version:        %{version}
Release:        1%{?dist}
License:        MIT
Group:          Applications/System
URL:            http://geek.jasonhancock.com
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
#BuildRequires: zlib-devel

%description
Nagios monitoring tools from Jason Hancock

%package pnp4nagios
Summary: pnp4nagios configs for Nagios monitoring tools from Jason Hancock
Group: Applications/System

%description pnp4nagios
Nagios monitoriing tools from Jason Hancock

%prep

%build

rm -rf *

wget -q -O nagios-memory.tar.gz https://github.com/jasonhancock/nagios-memory/archive/master.tar.gz
mkdir nagios-memory
tar --strip-components=1 -xvzf nagios-memory.tar.gz  -C nagios-memory

wget -q -O nagios-cpu.tar.gz https://github.com/jasonhancock/nagios-cpu/archive/master.tar.gz
mkdir nagios-cpu
tar --strip-components=1 -xvzf nagios-cpu.tar.gz  -C nagios-cpu

%install
rm -rf $RPM_BUILD_ROOT

PLUGIN_DIR=$RPM_BUILD_ROOT/usr/lib64/nagios/plugins
PNP_TEMPLATES_DIR=$RPM_BUILD_ROOT/usr/share/nagios/html/pnp4nagios/templates
PNP_CHECK_DIR=$RPM_BUILD_ROOT/etc/pnp4nagios/check_commands

mkdir -p $PLUGIN_DIR
mkdir -p $PNP_TEMPLATES_DIR
mkdir -p $PNP_CHECK_DIR

install -m 0755 */plugins/* $PLUGIN_DIR/
install -m 0644 */pnp4nagios/templates/* $PNP_TEMPLATES_DIR/
install -m 0644 */pnp4nagios/check_commands/* $PNP_CHECK_DIR/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
/usr/lib64/nagios/plugins/*

%files pnp4nagios
/etc/pnp4nagios/check_commands/*
/usr/share/nagios/html/pnp4nagios/templates/*
