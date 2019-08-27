FROM debian:stretch

MAINTAINER Sagnik Sasmal, <sagnik@zadeservers.net>

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get -y install dirmngr curl software-properties-common locales git cmake \
    && adduser -D -h /home/container container

    # Ensure UTF-8
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen
    
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update \
    && apt-get -y install nodejs node-gyp node-pre-gyp npm \
    && apt-get -y install sqlite3 libsqlite3-dev \
    && npm install discord.js node-opus \
    && npm install @discordjs/uws \
    && npm install sqlite3 \
    && npm install better-sqlite3

USER container
ENV USER=container HOME=/home/container


WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
