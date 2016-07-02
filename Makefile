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

all: container runcontainer
	true

container:
	docker build --no-cache -t $(container) .

runcontainer:
	docker run -e "BUILD_NUMBER=$(BUILD_NUMBER)" -v $(WORKSPACE):/mnt/build $(container)

package: clean
	@(mkdir $(topdir) && cd $(topdir) && mkdir SOURCES SRPMS BUILD RPMS SPECS tmp)
	cp $(pkg).spec $(topdir)/SPECS/
	rpmbuild -bb --define "_topdir $(topdir)" --define "_tmppath $(topdir)/tmp" --define "version $(version)" $(topdir)/SPECS/$(pkg).spec
	cp $(topdir)/*RPMS/*/*.*rpm .
	rm -rf $(topdir)

clean:
	@rm -f *.rpm
	@rm -rf $(topdir) || true
