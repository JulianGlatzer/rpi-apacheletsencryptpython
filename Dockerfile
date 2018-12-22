FROM arm32v7/debian:stable

MAINTAINER Julian Glatzer "jg@commail.glatzer.eu"

RUN apt-get update --fix-missing && apt-get install -y \
    openssl \
    apache2 apache2-doc apache2-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

#ADD conf

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

VOLUME ["/apache"]

EXPOSE 80 81 443

ENTRYPOINT ["/entrypoint.sh"]