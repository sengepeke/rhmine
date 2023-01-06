FROM alpine:latest
WORKDIR /pkt
RUN wget https://github.com/RainbowMiner/miner-binaries/releases/download/v2.3-rhminer/rhminer.2.3.Linux.CPU.zip
RUN unzip -q rhminer.2.3.Linux.CPU.zip
RUN ls

COPY --from=usr /usr/rhminer /usr/bin/rhminer


ENTRYPOINT [ "packetcrypt", "ann", "-p", "$ptk_address", "$ptk_address" ]
