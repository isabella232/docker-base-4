FROM ubuntu:trusty-20171117
LABEL maintainer="operations@invoca.com"

ENV BUILD_DEPS '\
    curl \
    dnsutils \
    jq \
    ngrep \
    vim \
    '

RUN apt-get update && apt-get install -y --no-install-recommends $BUILD_DEPS \
    && rm -rf /var/lib/apt/lists/*
