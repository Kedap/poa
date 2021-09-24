#!/bin/bash
# poa user repository branch path_for_control script_for_creating_deb

if [[ $1 == "--help" ]]; then
 echo "Using:"
 echo "poa repository name path_for_spec version branch"
 exit 1
fi
echo "++++++++++++++++++++++++++++"
echo "+ packager of apmpkg FEDORA+"
echo "++++++++++++++++++++++++++++"
echo
echo "Print info"
uname -a
rustc -V
curl --version
echo "Cloning repository $1"
git clone https://github.com/$1.git
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Selecting the branch $5"
cd $2
git checkout $5
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Outing of repo"
cd ..
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Creating rpm tree"
rpmdev-setuptree
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Coping spec file"
cp $2/$3 ~/rpmbuild/SPECS
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Rename the folder with source code"
mv $2 $2-$4
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Creating tar file"
tar -czf $4.tar.gz $2-$4
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Coping tarball"
cp $4.tar.gz ~/rpmbuild/SOURCES
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Installing depencies"
dnf install openssl-devel -y
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Creating binary"
rpmbuild -bb ~/rpmbuild/SPECS/*.spec
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Coping binary"
mv ~/rpmbuild/RPMS/x86_64/$2-$4-*.fc34.x86_64.rpm .
if [[ $? -ne 0 ]]; then
  echo "Oops... A error"
  exit 1
fi
echo "Upload binary..."
curl -o link.txt --upload-file ./$2-$4-*.fc34.x86_64.rpm https://transfer.sh
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
