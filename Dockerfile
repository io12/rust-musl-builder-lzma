# Generate statically-linked musl builds

FROM ekidd/rust-musl-builder

# Modified to include liblzma

RUN PKG_CONFIG_ALL_STATIC=1 && \
    sudo apt-get -y update && \
    sudo apt-get -y install pkg-config autoconf automake autopoint libtool m4 && \
    cd /home/rust/libs && \
    git clone https://git.tukaani.org/xz.git && \
    cd xz && \
    git checkout v5.2.4 && \
    CC=musl-gcc ./autogen.sh && \
    CC=musl-gcc ./configure --disable-shared && \
    cd src/liblzma/ && \
    make && \
    sudo make install && \
    cd ../../../ && \
    rm -rf xz
