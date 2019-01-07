FROM ubuntu:18.04

RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

RUN set -ex; \
	apt-get update; \
    echo "Asia/Shanghai" > /etc/timezone;  \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		wget \
		libcurl4-openssl-dev \
		libgl1-mesa-glx \
		libgtk3.0 \
		libgconf-2-4 \
        libasound2 \
		libxtst6 \
		libxss1 \
		libnss3 \
	; \
	dpkg-reconfigure --frontend noninteractive tzdata;

RUN set -ex; \
	dpkg --add-architecture i386; \
	apt-get update; \
	apt-get install -y --no-install-recommends \ 
	ttf-wqy-microhei \
	wine-stable \
	wine32 \
	wine-binfmt \
	; \
    update-binfmts --import /usr/share/binfmts/wine; \
	rm -rf /var/lib/apt/lists/*;

USER node

COPY --chown=1000:1000 dist /app
COPY --chown=1000:1000 docker/entrypoint.sh /

CMD /entrypoint.sh