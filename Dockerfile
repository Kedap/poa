FROM rust:1.54.0-slim-buster
WORKDIR /app
RUN apt-get update && \
  apt-get install -y curl pkg-config libssl-dev git --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*
COPY poa.sh /usr/bin/poa
ENTRYPOINT [ "poa" ]
