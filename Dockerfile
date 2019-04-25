FROM ubuntu:trusty-20171117
LABEL maintainer="operations@invoca.com"

ENV BUILD_DEPS '\
    apt-transport-https \
    curl \
    dnsutils \
    git \
    jq \
    ngrep \
    vim \
    '

RUN apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS \
    && rm -rf /var/lib/apt/lists/* \
    && find /etc/cron.* /etc/logrotate.d -type f -delete
