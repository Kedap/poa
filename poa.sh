#!/bin/bash
# poa user repository branch path_for_control script_for_creating_deb

if [[ $1 == "--help" ]]; then
 echo "Using:"
 echo "poa repository name branch path_for_control script_for_creating_deb"
 exit 1
fi
echo "++++++++++++++++++++++++++++"
echo "+ packager of apmpkg DEBIAN+"
echo "++++++++++++++++++++++++++++"
echo
echo "Print info"
uname -a
rustc -V
git --version
curl --version
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
echo "Compilating"
cargo build --release --locked
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Creating the tree for packaging"
mkdir -p $2/DEBIAN
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Coping the control file"
cp $4 $2/DEBIAN/control
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
if [[ -z $5 ]]; then
  echo "Using installing generic"
  install -Dm 755 "target/release/$2" -t "$2/usr/bin"
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
else
  bash $5
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
fi
echo "Creating the package"
dpkg-deb --build $2 $2-i386.deb
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Upload binary..."
curl -o link.txt --upload-file ./$2-i386.deb https://transfer.sh
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
