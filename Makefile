
BASE_NAME = "kmpm/fritzbuild"

TOPTARGETS := all build clean
SUBDIRS := base components


usage:
	@echo "read the Makefile"


.PHONY: $(TOPTARGETS) $(SUBDIRS)
$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS): 
	$(MAKE) -C $@ $(MAKECMDGOALS)


all: build

build:
	docker build -t $(BASE_NAME):latest -f Dockerfile .



clean:
	rm -f *.built