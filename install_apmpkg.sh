#!/bin/bash

apt-get update
apt-get install -y file wget curl pkg-config libssl-dev git --no-install-recommends
wget https://github.com/Kedap/apmpkg/releases/download/1.4.1/apmpkg-bin-x86_64
chmod +x apmpkg-bin-x86_64
mv apmpkg-bin-x86_64 /usr/bin/apmpkg
git clone https://github.com/Kedap/apmpkg.git
mkdir -p /etc/apmpkg/iiabc
cp -r apmpkg/src/iiabc /etc/apmpkg
rm -rf apmpkg
rm -rf /var/lib/apt/lists/*
