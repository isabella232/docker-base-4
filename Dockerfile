FROM debian:9
LABEL maintainer="operations@invoca.com"

ENV BUILD_DEPS '\
    apt-transport-https \
    cron \
    curl \
    dnsutils \
    git \
    gnupg \
    jq \
    less \
    lsof \
    netcat-openbsd \
    ngrep \
    procps \
    vim \
    '

RUN apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS \
    && rm -rf /var/lib/apt/lists/* \
    && find /etc/cron.* /etc/logrotate.d -type f -delete
