VERSION=latest
NAME=ndn-box-sp
#REGISTRY=

all: build
build:
	docker build --no-cache=true -t $(NAME) .
	#docker tag $(NAME) $(REGISTRY)/$(NAME):$(VERSION)
update:
	docker build -t $(NAME) .
	#docker tag $(NAME) $(REGISTRY)/$(NAME):$(VERSION)
push:
	docker push $(REGISTRY)/$(NAME):$(VERSION)
run: update
	docker run -ti --rm -p 8001:80 -v ${CURDIR}/data/simplesamlphp-1.14.11:/var/simplesamlphp $(NAME)
