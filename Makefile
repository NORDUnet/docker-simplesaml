VERSION=latest
NAME=ndn-box-sp
#REGISTRY=

all: build push
build:
	docker build --no-cache=true -t $(NAME) .
	#docker tag $(NAME) $(REGISTRY)/$(NAME):$(VERSION)
update:
	docker build -t $(NAME) .
	#docker tag $(NAME) $(REGISTRY)/$(NAME):$(VERSION)
push:
	docker push $(REGISTRY)/$(NAME):$(VERSION)
run: update
	docker run -ti --rm -p 8001:80 -v ${CURDIR}/data/simplesamlphp-1.13.2:/var/simplesamlphp $(NAME)
#dev:
#	docker run -ti --rm -p 9292:9292 -e RAILS_ENV="development" -v ${CURDIR}:/app $(NAME)
