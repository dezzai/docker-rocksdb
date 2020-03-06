FROM debian:buster-slim

ARG ROCKSDB_VERSION=6.6.4

ADD https://github.com/facebook/rocksdb/archive/v${ROCKSDB_VERSION}.tar.gz tmp/rocksdb.tar.gz

RUN apt-get update && \
    apt-get install -y make g++ libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev && \
    cd /tmp && \
    tar -xvf rocksdb.tar.gz && \
    cd rocksdb-${ROCKSDB_VERSION} && \
    make shared_lib && \
    make install-shared INSTALL_PATH=/usr && \
    rm -rf tmp/rocksdb* && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*
