FROM php:7.4-apache
LABEL maintainer="Markus Krogh <markus@nordu.net>"
RUN mkdir -p /var/simplesamlphp/www
COPY apache/php-limit.ini /usr/local/etc/php/conf.d/
COPY apache/box-sp.conf /etc/apache2/sites-available/
RUN a2ensite box-sp && a2dissite 000-default
ENV SP_BASENAME "https://box-idp.nordu.net"
ENV SIMPLE_SAML_VERSION 1.18.7
WORKDIR /opt
ADD simplesamlphp-${SIMPLE_SAML_VERSION}.tar.gz.sha256 .
RUN curl -L -o simplesamlphp-${SIMPLE_SAML_VERSION}.tar.gz https://github.com/simplesamlphp/simplesamlphp/releases/download/v${SIMPLE_SAML_VERSION}/simplesamlphp-${SIMPLE_SAML_VERSION}.tar.gz && \
    sha256sum -c simplesamlphp-${SIMPLE_SAML_VERSION}.tar.gz.sha256 && \
    tar xf simplesamlphp-${SIMPLE_SAML_VERSION}.tar.gz && \
    ln -s $(pwd)/simplesamlphp-${SIMPLE_SAML_VERSION} $(pwd)/simplesamlphp && \
    rm -r simplesamlphp-${SIMPLE_SAML_VERSION}.tar.gz
WORKDIR /opt/simplesamlphp-${SIMPLE_SAML_VERSION}
RUN rm -r metadata && \
    mkdir metadata && \
    touch modules/cron/enable modules/metarefresh/enable
ADD simplesaml-entrypoint.sh /opt
ENTRYPOINT ["/opt/simplesaml-entrypoint.sh"]
