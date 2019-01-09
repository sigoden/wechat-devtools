FROM ubuntu:18.04

RUN groupadd --gid 1000 node \
	&& useradd --uid 1000 --gid node --shell /bin/bash --create-home node

RUN set -ex; \
	apt-get update; \
	echo "Asia/Shanghai" > /etc/timezone;  \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	ca-certificates \
	curl \
	net-tools \
	wget \
	git \
	libssl1.0-dev \
	libcurl3-gnutls \
	libcurl4-nss-dev \
	libgtk3.0 \
	libgconf-2-4 \
	libasound2 \
	libxtst6 \
	libxss1 \
	; \
	dpkg-reconfigure --frontend noninteractive tzdata;

RUN set -ex; \
	dpkg --add-architecture i386; \
	apt-get update; \
	apt-get install -y --no-install-recommends \ 
	language-pack-zh-hans \
	ttf-wqy-microhei \
	wine-stable \
	wine32 \
	; \
	rm -rf /var/lib/apt/lists/*;

USER node

ENV LANG zh_CN.UTF-8

RUN set -ex; \
	mkdir -p ~/weapp; \
	mkdir -p ~/.config/微信web开发者工具; \
	ln -s ~/.config/微信web开发者工具 ~/.wine; 

COPY --chown=1000:1000 dist /app

ENTRYPOINT [ "/app/launch.sh", "--disable-gpu" ]