FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# set version label
ARG BUILD_DATE
ARG VERSION
ARG ANYTYPE_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="distracted"

# title
ENV TITLE=ANYTYPE 

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://logo.svgcdn.com/s/anytype-dark.png && \
  echo "**** install packages ****" && \
  apt-key adv \
    --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv-keys 5301FA4FD93244FBC6F6149982BB6851C64F6880 && \
  echo \
    "deb https://ppa.launchpadcontent.net/xtradeb/apps/ubuntu noble main" > \
    /etc/apt/sources.list.d/xtradeb.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    libgtk-3-bin \
    libatk1.0 \
    libatk-bridge2.0 \
    libsecret-1-dev\
    libnss3 \
    gnome-keyring\
    jq\
    python3-xdg && \
  cd /tmp && \
    curl -o \
    /tmp/anytype.deb -L \
    https://anytype-release.fra1.cdn.digitaloceanspaces.com/anytype_0.47.6_amd64.deb &&\
  dpkg -i /tmp/anytype.deb &&\
    echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config