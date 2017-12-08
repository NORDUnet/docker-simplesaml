#!/bin/sh


if [ -d /opt/simplesamlphp-overwrites ]; then
  cp -TR /opt/simplesamlphp-overwrites/ /opt/simplesamlphp-${SIMPLE_SAML_VERSION}/
fi

# Fix permissions on folders
chown -R www-data:www-data /opt/simplesamlphp-${SIMPLE_SAML_VERSION}/log
chown -R www-data:www-data /opt/simplesamlphp-${SIMPLE_SAML_VERSION}/metadata

docker-php-entrypoint apache2-foreground
