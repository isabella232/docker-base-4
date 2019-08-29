FROM debian:9
LABEL maintainer="operations@invoca.com"

ENV BUILD_DEPS '\
    curl \
    dnsutils \
    git \
    jq \
    less \
    lsof \
    netcat \
    ngrep \
    procps \
    vim \
    '

RUN apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS \
    && rm -rf /var/lib/apt/lists/* \
    && find /etc/cron.* /etc/logrotate.d -type f -delete
