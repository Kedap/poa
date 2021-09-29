#!/bin/bash

apt-get update
apt-get install -y file wget curl pkg-config libssl-dev git zstd --no-install-recommends
curl -o pacman_file.tar.zst https://krep0.bitbucket.io/archlinux/x86_64/apmpkg-dev-195.4e6c5c1-1-x86_64.pkg.tar.zst
tar -xf pacman_file.tar.zst
rm pacman_file.tar.zst
cp -rf * /
rm /usr/bin/apmpkg
git clone https://github.com/kedap/apmpkg
cd apmpkg
cargo build --release --locked
install -Dm 755 "target/release/apmpkg" -t "/usr/bin"
cd ..
rm -rf *
rm -rf /var/lib/apt/lists/*
