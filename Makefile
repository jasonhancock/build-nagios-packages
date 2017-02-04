pkg = nagios-plugins-hancock
version_base = 1.0

WORKSPACE = $(shell pwd)

ifndef BUILD_NUMBER
version = 0.99.0
else
version = $(version_base).$(BUILD_NUMBER)
endif

container = builder-nagios-plugins-hancock

topdir = /tmp/$(pkg)-$(version)

all: containers runcontainers
	true

containers:
	docker build --no-cache -t $(container)-deb debian/
	docker build --no-cache -t $(container)-rpm redhat/

runcontainers:
	docker run -e "BUILD_NUMBER=$(BUILD_NUMBER)" -v $(WORKSPACE):/mnt/build $(container)-deb
	docker run -e "BUILD_NUMBER=$(BUILD_NUMBER)" -v $(WORKSPACE):/mnt/build $(container)-rpm

rpm: clean-rpm
	@(mkdir $(topdir) && cd $(topdir) && mkdir SOURCES SRPMS BUILD RPMS SPECS tmp)
	cp redhat/$(pkg).spec $(topdir)/SPECS/
	rpmbuild -bb --define "_topdir $(topdir)" --define "_tmppath $(topdir)/tmp" --define "version $(version)" $(topdir)/SPECS/$(pkg).spec
	cp $(topdir)/*RPMS/*/*.*rpm .
	rm -rf $(topdir)

deb: clean-deb
	@sed -i "/^Version:/c\Version: $(version)" debian/$(pkg)/DEBIAN/control
	@(cd debian && ./install.sh)
	@(cd debian && find $(pkg) -name DEBIAN -prune -o -type f -exec md5sum {} \; > $(pkg)/DEBIAN/md5sums)
	@dpkg-deb -b debian/$(pkg) $(pkg)-$(version).deb

clean-rpm:
	@rm -f *.rpm
	@rm -rf $(topdir) || true

clean-deb:
	@rm -f *.deb

clean:
	@rm -f *.rpm
	@rm -f *.deb
	$(MAKE) -C debian clean
