#!/bin/sh -l

echo "Downloading patch"
curl -O https://krep0.bitbucket.io/pastes/abuild.conf.patch
echo "Patching file"
sudo patch -R -u -b /etc/abuild.conf -i abuild.conf.patch
echo "Creating keys..."
abuild-keygen -a -i -n
echo "Adding comunity repository..."
echo 'https://dl-cdn.alpinelinux.org/alpine/v3.14/community' >> /etc/apk/repositories
echo "Installing rust..."
curl https://sh.rustup.rs -sSf | sh -s -- -y
echo "Load cargo path"
source $HOME/.cargo/env
echo "Done!!!"
exit 0
