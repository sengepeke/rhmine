FROM rust:latest AS build
WORKDIR /build
COPY packetcrypt_rs /build/packetcrypt_rs
RUN cd /build/packetcrypt_rs && cargo build --release --features jemalloc 


FROM alpine:latest
WORKDIR /pkt
COPY --from=build /build/packetcrypt_rs/target/release/packetcrypt /usr/bin/packetcrypt

ENV ptk_address=pkt1qegd9xjlaatf26f583m8yurtt9te4vs8340naca
ENV ptk_pool="http://pool.pkteer.com http://pool.pkt.world http://pool.pktpool.io"

ENTRYPOINT [ "packetcrypt", "ann", "-p", "$ptk_address", "$ptk_address" ]
