
BASE_NAME = "kmpm/fritzbuild"


TOPTARGETS := all build clean
SUBDIRS := components


usage:
	@echo "read the Makefile"


.PHONY: $(TOPTARGETS) $(SUBDIRS)
$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS): base.built
        $(MAKE) -C $@ $(MAKECMDGOALS)

build: base.built

base.built:
	@echo "Building base image"
	docker build -t $(BASE_IMAGE) ./base
	touch base.built

# ngspice: base.built
# 	docker build -t $(BASE_NAME)-ngspice -f components/Dockerfile.ngspice ./components


# libgit2: base.built
# 	docker build -t $(BASE_NAME)-libgit2 -f components/Dockerfile.libgit2 ./components

clean:
	rm -f *.built