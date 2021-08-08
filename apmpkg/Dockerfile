FROM rust:1.54.0-slim-buster
WORKDIR /app
COPY install_apmpkg.sh .
RUN ./install_apmpkg.sh
COPY poa.sh /usr/bin/poa
ENTRYPOINT [ "poa" ]
