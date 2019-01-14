FROM ubuntu:18.04

RUN groupadd --gid 1000 node \
	&& useradd --uid 1000 --gid node --shell /bin/bash --create-home node

RUN set -ex; \
	dpkg --add-architecture i386; \
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
	language-pack-zh-hans \
	ttf-wqy-microhei \
	sudo \
	wine-stable \
	wine32 \
	; \
	dpkg-reconfigure --frontend noninteractive tzdata; \
	rm -rf /var/lib/apt/lists/*; \
	sudo -H -u node wineboot -u;

ENV LANG zh_CN.UTF-8

VOLUME [ "/home/node/weapp", "/home/node/.config/微信web开发者工具" ]

COPY --chown=1000:1000 dist /app
COPY --chown=1000:1000 docker/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/app/launch.sh", "--disable-gpu" ]