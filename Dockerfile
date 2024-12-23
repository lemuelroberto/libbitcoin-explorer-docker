FROM debian:12-slim AS build

RUN set -eux; apt-get update; \
  apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    ca-certificates \
    clang \
    g++ \
    gcc \
    git \
    libtool \
    pkg-config \
    wget \
  ; \
  update-ca-certificates; \
  mkdir -p /mnt/libbitcoin; \
  cd /mnt/libbitcoin; \
  wget https://raw.githubusercontent.com/libbitcoin/libbitcoin-explorer/version3/install.sh; \
  chmod +x ./install.sh; \
  ./install.sh \
    --with-icu \
    --build-icu \
    --build-boost \
    --build-zmq \
    --prefix=/mnt/libbitcoin/build; \
  true ;

FROM debian:12-slim

RUN set -eux; \
  adduser \
    --disabled-password \
    --gecos "libbitcoin user;"\
    --home /home/libbitcoin \
    --shell /usr/bin/bash \
    --uid 1000 \
    libbitcoin; \
  mkdir -p /home/libbitcoin/workspace; \
  true;

COPY --from=build /mnt/libbitcoin/build/bin/* /usr/bin/
COPY --from=build /mnt/libbitcoin/build/etc/* /etc/
COPY --from=build /mnt/libbitcoin/build/include/* /usr/include/
COPY --from=build /mnt/libbitcoin/build/lib/* /usr/lib/
COPY --from=build /mnt/libbitcoin/build/sbin/* /usr/sbin/
COPY --from=build /mnt/libbitcoin/build/share/* /usr/share/

USER 1000

WORKDIR /home/libbitcoin/workspace
