FROM arm32v7/debian:stable

MAINTAINER Julian Glatzer "jg@commail.glatzer.eu"

RUN apt-get update --fix-missing && apt-get upgrade -y && apt-get install -y \
    openssl \
    apache2 apache2-doc apache2-utils \
    certbot \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/apache","/etc/letsencrypt"]

EXPOSE 80 81 443

ADD ports.conf /etc/apache2/
ADD envvars /etc/apache2/
ADD apache2.conf /etc/apache2/
ADD 000-default.conf /etc/apache2/sites-available/
ADD letsencrypt.conf /etc/apache2/sites-available/
ADD default-ssl.conf /etc/apache2/sites-available/

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]