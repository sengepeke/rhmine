FROM rust:latest AS build
WORKDIR /build
COPY packetcrypt_rs /build/packetcrypt_rs
RUN cd /build/packetcrypt_rs && cargo build --release --features jemalloc 


FROM alpine:latest
# Create a group and user
RUN apk update \
#   && apk add --no-cache gcc \
  && addgroup -S pkt-group && adduser -S pkt-miner -G pkt-group -h /pkt

# Tell docker that all future commands should run as the pkt-miner user
USER pkt-miner
WORKDIR /pkt
COPY --from=build /build/packetcrypt_rs/target/release/packetcrypt /usr/local/bin/packetcrypt

ENV ptk_address=pkt1q7j3znlm9u9wkv8pwgpdprnqwnsg2ldrd23q6dc
ENV ptk_pool="http://pool.pkteer.com http://pool.pkt.world http://pool.pktpool.io"

ENTRYPOINT [ "packetcrypt", "ann", "-p", "$ptk_address", "$ptk_address" ]
