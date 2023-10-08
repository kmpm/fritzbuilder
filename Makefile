
BASE_NAME = "kmpm/fritzbuild"


TOPTARGETS := all build clean
SUBDIRS := components


usage:
	@echo "read the Makefile"


.PHONY: $(TOPTARGETS) $(SUBDIRS)
$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS): 
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: all
all: build

build: base.built


base.built: Dockerfile.base
	@echo "Building base image"
	docker build -t $(BASE_NAME)-base -f Dockerfile.base .
	touch base.built



clean:
	rm -f *.built