From ubuntu:15.04
MAINTAINER Chris Wininger <cwininger@airspringsoftware.com>

#install software
RUN apt-get update
RUN apt-get -y install simplesamlphp openssl

# add php modules
RUN php5enmod mcrypt

# update apache config
ADD ./docker-source/sites-available/saml.idp.local.conf /etc/apache2/sites-available/saml.idp.local.conf 

# add our default configs
ADD ./docker-source/etc/simplesamlphp/attributemap/name2oidAirspring.php /etc/simplesamlphp/attributemap/name2oidAirspring.php
ADD ./docker-source/etc/simplesamlphp/metadata/saml20-idp-hosted.php /etc/simplesamlphp/metadata/saml20-idp-hosted.php
ADD ./docker-source/etc/simplesamlphp/metadata/saml20-sp-remote.php /etc/simplesamlphp/metadata/saml20-sp-remote.php
ADD ./docker-source/etc/simplesamlphp/authsources.php /etc/simplesamlphp/authsources.php
ADD ./docker-source/etc/simplesamlphp/config.php /etc/simplesamlphp/config.php

# add helper scripts
ADD ./docker-source/scripts/stripCert.sh /stripCert.sh
ADD ./docker-source/scripts/outputCerts.sh /outputCerts.sh
RUN chmod +x /stripCert.sh
RUN chmod +x /outputCerts.sh

# enable example auth
RUN touch /usr/share/simplesamlphp/modules/exampleauth/enable
# create apache symlinks
RUN a2dissite 000-default.conf
RUN a2ensite saml.idp.local.conf 

# create certs
RUN openssl req -newkey rsa:2048 -new -x509 -days 3652 -nodes -subj "/C=US/ST=KY/L=Lexington/O=Dis/CN=www.airspringsoftware.com" -out /etc/ssl/certs/simplesamlphp.crt -keyout /etc/ssl/certs/simplesamlphp.pem

# create volumes to allow changes to simple saml config from host
VOLUME /etc/simplesamlphp
VOLUME /usr/share/simplesamlphp
VOLUME /etc/ssl/certs

# reload apache
RUN service apache2 start 

RUN /outputCerts.sh

EXPOSE 8080
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]


