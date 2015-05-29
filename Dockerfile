From ubuntu:15.04
MAINTAINER Chris Wininger <cwininger@airspringsoftware.com>

#install software
RUN apt-get update
RUN apt-get -y install simplesamlphp

# add php modules
RUN php5enmod mcrypt

# update apache config
ADD ./docker-source/sites-available/saml.idp.local.conf /etc/apache2/sites-available/saml.idp.local.conf
ADD ./docker-source/sites-available/saml.idp.local.conf /etc/apache2/sites-available/saml.sp.local.conf

# add our default configs
ADD ./docker-source/etc/simplesamlphp/attributemap/name2oidAirspring.php /etc/simplesamlphp/attributemap/name2oidAirspring.php
ADD ./docker-source/etc/simplesamlphp/metadata/saml20-idp-hosted.php /etc/simplesamlphp/metadata/saml20-idp-hosted.php
ADD ./docker-source/etc/simplesamlphp/metadata/saml20-sp-remote.php /etc/simplesamlphp/metadata/saml20-sp-remote.php
ADD ./docker-source/etc/simplesamlphp/authsources.php /etc/simplesamlphp/authsources.php
ADD ./docker-source/etc/simplesamlphp/config.php /etc/simplesamlphp/config.php
ADD ./docker-source/usr/share/modules/exampleauth/enable /usr/share/modules/exampleauth/enable

# create apache symlinks
RUN a2dissite 000-default.conf
RUN a2ensite saml.idp.local.conf
RUN a2ensite saml.sp.local.conf

# create volumes to allow changes to simple saml config from host
VOLUME /etc/simplesamlphp
VOLUME /usr/share/simplesamlphp

# reload apache
RUN service apache2 start
