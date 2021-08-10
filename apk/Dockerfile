FROM alpinelinux/alpine-gitlab-ci
WORKDIR /home/buildozer
COPY install_rust.sh .
RUN ./install_rust.sh
COPY poa.sh /usr/bin/poa
ENTRYPOINT [ "poa" ]
