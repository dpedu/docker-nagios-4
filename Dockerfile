# Using LTS ubuntu
FROM ubuntu:14.04
MAINTAINER "Mark Vartanyan <kolypto@gmail.com>"

# Const
ENV NAGIOS_PHP_TIMEZONE UTC
ENV NAGIOS_TARBALL http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.7.tar.gz
ENV NAGIOS_PLUGINS_TARBALL http://www.nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz

# Packages: update & install
ENV DEBCONF_FRONTEND noninteractive
RUN sed -i 's~.* universe$~\0 multiverse~' /etc/apt/sources.list
RUN apt-get update -qq
RUN apt-get install -qq -y --no-install-recommends python-pip supervisor build-essential
RUN apt-get install -qq -y --no-install-recommends apache2 libapache2-mod-php5 snmp-mibs-downloader
RUN apt-get install -qq -y --no-install-recommends wget curl samba-common samba-common-bin smbclient snmp whois
RUN apt-get install -qq -y --no-install-recommends libgd2-xpm-dev libssl-dev libnet-snmp-perl libperl-dev libpq5 libradius1 libsensors4 libsnmp-base libtalloc2 libtdb1 libwbclient0 libmysqlclient15-dev
RUN pip install j2cli

# Users
RUN groupadd -g 3000 nagios
RUN useradd -u 3000 -g nagios -m -s /bin/bash nagios

# Install nagios
# RUN mkdir -p /usr/local/src/nagios4
# RUN cd /usr/local/src/nagios4 && wget $NAGIOS_TARBALL -O- | tar -zxp --strip-components 1 && ./configure --prefix=/usr/local/nagios --with-nagios-user=nagios --with-nagios-group=nagios --with-command-user=nagios --with-command-group=nagios && make all
#
# # Install nagios plugins
# RUN mkdir -p /usr/local/src/nagios4-plugins
# RUN cd /usr/local/src/nagios4-plugins && wget $NAGIOS_PLUGINS_TARBALL -O- | tar -zxp --strip-components 1 && ./configure --with-nagios-user=nagios --with-nagios-group=nagios --with-openssl=/usr/bin/openssl --enable-perl-modules --enable-libtap


