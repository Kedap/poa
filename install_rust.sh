#!/bin/sh -l

echo "Creating keys..."
abuild-keygen -a -i -n
echo "Adding comunity repository..."
echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
echo "Installing rust..."
curl https://sh.rustup.rs -sSf | sh -s -- -y
echo "Load cargo path"
source $HOME/.cargo/env
echo "Done!!!"
exit 0
