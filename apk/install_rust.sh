#!/bin/sh -l

echo "Downloading patch"
curl -O https://krep0.bitbucket.io/pastes/abuild.conf.patch
echo "Patching file"
sudo patch -R -u -b /etc/abuild.conf -i abuild.conf.patch
echo "Creating keys..."
abuild-keygen -a -i -n
echo "Installing rust..."
curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
