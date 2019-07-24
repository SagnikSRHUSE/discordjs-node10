FROM debian:stretch

MAINTAINER Sagnik Sasmal, <sagnik@zadeservers.net>

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get -y install dirmngr curl software-properties-common locales git cmake \
    && useradd -d /home/container -m container \

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update \
    && apt-get -y install nodejs node-gyp node-pre-gyp \
    && npm install discord.js node-opus \
    && npm install @discordjs/uws \
    && npm install sodium \
    && npm install sqlite3 \

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
