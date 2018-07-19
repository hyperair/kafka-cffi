FROM ubuntu:12.04

ENV LIBRDKAFKA_VERSION 0.11.4

RUN apt-get update && \
    apt-get install -y curl build-essential zlib1g-dev libssl-dev libexpat1-dev unzip

RUN mkdir /tmp/librdkafka && \
    curl -L \
    https://github.com/edenhill/librdkafka/archive/v$LIBRDKAFKA_VERSION.tar.gz | \
    tar xz -C /tmp/librdkafka --strip-components=1 && \
    cd /tmp/librdkafka && \
    ./configure && make && make install

RUN mkdir /opt/pypy2-5.10.0 && \
    curl -L https://bitbucket.org/pypy/pypy/downloads/pypy2-v5.10.0-linux64.tar.bz2 | \
    tar xj -C /opt/pypy2-5.10.0 --strip-components=1

RUN mkdir /opt/pypy2-6.0.0 && \
    curl -L https://bitbucket.org/pypy/pypy/downloads/pypy2-v6.0.0-linux64.tar.bz2 | \
    tar xj -C /opt/pypy2-6.0.0 --strip-components=1

RUN mkdir /opt/pypy3-5.10.0 && \
    curl -L https://bitbucket.org/pypy/pypy/downloads/pypy3-v5.10.0-linux64.tar.bz2 | \
    tar xj -C /opt/pypy3-5.10.0 --strip-components=1

RUN mkdir /opt/pypy3-6.0.0 && \
    curl -L https://bitbucket.org/pypy/pypy/downloads/pypy3-v6.0.0-linux64.tar.bz2 | \
    tar xj -C /opt/pypy3-6.0.0 --strip-components=1

RUN mkdir /tmp/python3.5 && \
    curl -L https://www.python.org/ftp/python/3.5.5/Python-3.5.5.tgz | \
    tar xz -C /tmp/python3.5 --strip-components=1 && \
    cd /tmp/python3.5 && \
    ./configure --prefix=/opt/python3.5 && make && make install && \
    /opt/python3.5/bin/pip3 install auditwheel

RUN mkdir /tmp/patchelf && \
    curl -L https://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.gz | \
    tar xz -C /tmp/patchelf --strip-components=1 && \
    cd /tmp/patchelf && \
    ./configure && make && make install

RUN curl https://bootstrap.pypa.io/get-pip.py > /tmp/get-pip.py && \
    /opt/pypy2-5.10.0/bin/pypy /tmp/get-pip.py && \
    /opt/pypy2-6.0.0/bin/pypy /tmp/get-pip.py && \
    /opt/pypy3-5.10.0/bin/pypy3 /tmp/get-pip.py && \
    /opt/pypy3-6.0.0/bin/pypy3 /tmp/get-pip.py

COPY . /app
WORKDIR /app
