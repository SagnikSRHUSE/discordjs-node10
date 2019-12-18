FROM node:10

MAINTAINER Sagnik Sasmal, <sagnik@sagnik.me>

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

# Install OS deps
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && apt-get -y install dirmngr curl software-properties-common locales git cmake \
    && apt-get -y install ffmpeg libmp3lame-dev x264 \
    && adduser -D -h /home/container container

# Ensure UTF-8
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen
    
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install NodeJS Dependencies
RUN apt-get -y install sqlite3 libsqlite3-dev \
    && npm install discord.js \
    && npm install yarn --global \
    && npm install node-opus \
    && npm install @discordjs/uws \
    && npm install bufferutil \
    && npm install hammerandchisel/erlpack \
    && npm install sodium \
    && npm install -g node-gyp \
    && npm install sqlite3 \
    && npm install better-sqlite3 \
    && npm install ffmpeg

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
