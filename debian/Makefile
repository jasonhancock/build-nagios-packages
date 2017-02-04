pkg = nagios-plugins-hancock
version_base = 0.0.1

ifndef BUILD_NUMBER
version = $(version_base)-manualbuild
else
version = $(version_base)-$(BUILD_NUMBER)
endif

all: clean
	@sed -i "/^Version:/c\Version: $(version)" $(pkg)/DEBIAN/control
	@find $(pkg) -name DEBIAN -prune -o -type f -exec md5sum {} \; > $(pkg)/DEBIAN/md5sums
	@dpkg-deb -b $(pkg) $(pkg)-$(version).deb
clean:
	@rm -rf $(pkg)/usr/lib/nagios/plugins
	@rm -f $(pkg)/DEBIAN/md5sums
	@rm -f $(pkg)-$(version).deb
