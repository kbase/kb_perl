# Makefile for KBase specific JRE image
#
# Author: Steve Chan sychan@lbl.gov
#

NAME := "kbase/kb_perl"

all: docker_image

docker_image:
	IMAGE_NAME=$(NAME) hooks/build

push_image:
	IMAGE_NAME=$(NAME) ./push2dockerhub.sh
