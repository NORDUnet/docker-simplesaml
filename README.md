# docker-simplesaml
A docker image for running SimpleSAMLphp using php 8.3

## Running

```
docker build --no-cache=true -t ndn-box-sp
docker run -ti --rm -v $(pwd)/data/simplesamlphp-overwrites:/opt/simplesamlphp-overwrites ndn-box-sp
```

## Environemnt

- You can set `SP_BASENAME` to what fits your deployment.

## docker-compose

The current setup is made to be run behind an nginx (thus there are no ssl configuration of the apache).

You need to create the following structure:
```
data/
├── certs
└── simplesamlphp-overwrites
    ├── cert
    ├── config
    ├── metadata
    └── vendor
```

## Upgrading

1. Change version number in `Dockerfile`
2. Add `simplesamlphp-${SHIP_VERSION_NUMBER}.tar.gz.sha256` (shasum two spaces filename)
3. Check differences in config.php to see if anything needs updating
4. Fix ADFS scoping problem in `vendor/simplesamlphp/saml2/src/SAML2/AuthnRequest.php`
  - Search for `$root->appendChild($scoping);`
  - Move `$root->appendChild($scoping);` to the last part of the `if (count($this->IDPList) >0) {` statement just after `$scoping->appendChild($idplist);`.
  - Add file to your `shibboleth-overwrites`

Try it out by pointing `box-idp.nordu.net` to localhost.
Then go to https://box-idp.nordu.net/simplesaml/admin click "Metarefresh" to fetch idp metadata.
The admin password is defined in `config/config.php`.
Run the hourly link to refresh metadata.
Then try to login to box.

If something fails you can use https://box-idp.nordu.net/simplesaml/module.php/admin/test default-sp to troubleshoot.
