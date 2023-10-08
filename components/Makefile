
BASE_NAME = "kmpm/fritzbuild"

# make one docker image for each Dockerfile.* in components
DOCKERFILES := $(wildcard Dockerfile.*)
IMAGES := $(patsubst Dockerfile.%,%.built,$(DOCKERFILES))

.PHONY: all build clean

all: build

components: build

build: $(IMAGES)
	@echo "images=$(IMAGES)"

# $(IMAGES): %: %.built
# 	docker build -t $(BASE_NAME):$* -f Dockerfile.$* .

%.built: Dockerfile.%
	docker build -t $(BASE_NAME)-$*:latest -f Dockerfile.$* .
	touch $@

clean:
	rm -f *.built
