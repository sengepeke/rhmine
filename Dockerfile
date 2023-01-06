FROM alpine:latest

RUN wget https://github.com/RainbowMiner/miner-binaries/releases/download/v2.3-rhminer/rhminer.2.3.Linux.CPU.zip
RUN unzip -q rhminer.2.3.Linux.CPU.zip

COPY /usr/rhminer /usr/bin/rhminer

ENTRYPOINT [ "rhminer" ]
