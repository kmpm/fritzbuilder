
BASE_NAME = "kmpm/fritzbuild"

TOPTARGETS := all build clean
SUBDIRS := base components


usage:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all         - build all images"
	@echo "  build       - build all images"
	@echo "  base        - build the base image"
	@echo "  components  - build the components image"	


.PHONY: $(TOPTARGETS) $(SUBDIRS)
$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS): 
	$(MAKE) -C $@ $(MAKECMDGOALS)


all: build

build:
	docker build -t $(BASE_NAME):latest -f Dockerfile .

dump:
	docker cp $(docker create --name tc --rm kmpm/fritzbuild:latest):/home/bob/ngspice-40 ./dump/

clean:
	rm -f *.built