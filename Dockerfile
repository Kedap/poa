FROM fedora:34
WORKDIR /app
RUN dnf -y update && \
  dnf -y install cargo git curl rpmdevtools && \
  dnf clean all
COPY poa.sh /usr/bin/poa
ENTRYPOINT [ "poa" ]
