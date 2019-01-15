FROM ubuntu:18.04

LABEL maintainer="Sigoden Huang <sigoden@gmail.com>"

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
	rm -rf /var/lib/apt/lists/*;

ENV LANG=zh_CN.UTF-8 \
	GID=1000 \
	UID=1000

RUN set -ex; \
	groupadd --gid $GID node; \
	useradd --uid $UID --gid node --shell /bin/bash --create-home node; \
	sudo -H -u node wineboot -u

VOLUME [ "/home/node/weapp", "/home/node/.config/微信web开发者工具" ]

COPY dist /app
COPY docker/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/app/launch.sh", "--disable-gpu" ]