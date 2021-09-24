#!/bin/bash
# poa user repository branch path_for_control script_for_creating_deb

if [[ $1 == "--help" ]]; then
 echo "Using:"
 echo "poa repository name branch path_for_PKGBUILD_file"
 exit 1
fi
echo "++++++++++++++++++++++++++++"
echo "+ packager of apmpkg PACMAN+"
echo "++++++++++++++++++++++++++++"
echo
echo "Print info"
uname -a
rustc -V
makepkg --version
git --version
curl --version
echo "Cloning the repository $1"
cd /home/$(whoami)
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
echo "Build binary"
makepkg -s --noconfirm
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Upload binary..."
curl -o link.txt --upload-file ./*.pkg.* https://transfer.sh
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
