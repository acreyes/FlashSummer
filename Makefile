.PHONY: all image

all: image

image:
	docker build . -t flashcenter/flash4-deps-dev:latest
