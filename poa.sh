#!/bin/sh -l
# poa user repository branch path_for_control script_for_creating_deb

if [[ $1 == "--help" ]]; then
 echo "Using:"
 echo "poa repository name branch path_for_APKBUILD_file"
 exit 1
fi
echo "+++++++++++++++++++++++++"
echo "+ packager of apmpkg APK+"
echo "+++++++++++++++++++++++++"
echo
echo "Set path"
HOME=/home/$(whoami)
echo "home = $HOME"
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Using path for rust"
source $HOME/.cargo/env
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Print info"
uname -a
rustc -V
abuild -V
git --version
curl --version
echo "Entry in the directory"
cd $HOME
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Cloning the repository $1"
git clone https://github.com/$1.git
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Selecting the branch $3"
cd $2
git checkout $3
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Outing of directory"
cd ..
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Coping $4"
cp $2/$4 .
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Deleting the source code"
rm -rf $2
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Checking sha sums..."
abuild checksum
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Download depdencies..."
doas apk add wget ruby-bundler py3-pip rsync bash ruby-dev npm openssl-dev
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Build binary"
abuild -r
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Upload binary..."
curl -o link.txt --upload-file /home/buildozer/packages/home/x86_64/*.apk https://transfer.sh
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "::set-output name=link::$(cat link.txt)"
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "DONE!"
