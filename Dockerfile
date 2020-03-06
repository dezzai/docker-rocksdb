FROM debian:buster-slim

ARG ROCKSDB_VERSION=6.6.4
ARG BUILD_DEPS='make g++'

ADD https://github.com/facebook/rocksdb/archive/v${ROCKSDB_VERSION}.tar.gz /tmp/rocksdb.tar.gz

RUN apt-get update && \
    apt-get install -y libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev liblz4-dev libzstd-dev ${BUILD_DEPS} --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    tar -xvf rocksdb.tar.gz && \
    cd rocksdb-${ROCKSDB_VERSION} && \
    make shared_lib && \
    make install-shared INSTALL_PATH=/usr && \
    cd .. && \
    rm -rf /tmp/rocksdb* && \
    apt-get clean && \
    apt-get purge -y --auto-remove ${BUILD_DEPS}
