# docker-simplesaml
A docker image for running SimpleSAMLphp using php 7.1

## Running

```
docker build --no-cache=true -t ndn-box-sp
docker run -ti --rm -v ${CURDIR}/data/simplesamlphp-1.14.11:/var/simplesamlphp ndn-box-sp
```

## Environemnt

- You can set `SP_BASENAME` to what fits your deployment.

## docker-compose

The current setup is made to be run behind an nginx (thus there are no ssl configuration of the apache).

You need to create the following structure:
```
data/
├── certs
└── simplesamlphp-1.14.11
```
