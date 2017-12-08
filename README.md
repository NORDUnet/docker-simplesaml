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
└── simplesamlphp-1.xx.x
```

## Upgrading

1. Download and extract the new version simplesamlphp.
  - Check differences in config.php to see if anything needs to be changed 
2. `rm -r config metadta cert`
3. Copy over the three folders from old setup
4. Enable cron module `touch modules/cron/enable`
5. Enable metarefresh module `touch modules/metarefresh/enable`
6. Make `log` and `metadata` owned by `www-data` (not necessary on mac runs)
7. Fix ADFS scoping problem in `vendor/simplesamlphp/saml2/src/SAML2/AuthnRequest.php`
  - Search for `$root->appendChild($scoping);`
  - Move `$root->appendChild($scoping);` to the last part of the `if (count($this->IDPList) >0) {` statement just after `$scoping->appendChild($idplist);`.

Try it out by pointing `box-idp.nordu.net` to localhost.
Then go to https://box-idp.nordu.net/simplesaml/module.php/core/frontpage_config.php click "Cron module information page".
The admin password can be found in `config/config.php`.
Run the hourly link to refresh metadata.
Then try to login to box.

If something fails you can use https://box-idp.nordu.net/simplesaml/module.php/core/authenticate.php default-sp to troubleshoot.

## TODO

- Make a proper docker image that does not have the code outside the docker image.
