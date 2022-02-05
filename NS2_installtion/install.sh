#!/bin/zsh

echo 'Downloading NS2 source and patch'
curl -L https://github.com/poz1/NS2/raw/fIles/ns-allinone-2.35.tar.gz -o ns-allinone-2.35.tar.gz
curl -L https://github.com/poz1/NS2/raw/fIles/ns-allinone-2.35-patch.zip -o ns-allinone-2.35-patch.zip
sleep 2s

echo 'Unzipping...'
tar xvzf ns-allinone-2.35.tar.gz
tar xvzf ns-allinone-2.35-patch.zip -C ns-allinone-2.35
sleep 2s

cd ns-allinone-2.35

chmod +x install64


echo "Unzipping complete"

echo "Starting installation..."
./install64
echo "Installation complete"

echo "Installing paths"

echo "export PATH=$PATH:`pwd`/ns-2.35:`pwd`/nam-1.15" >> ~/.zprofile
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/otcl-1.14:`pwd`/lib" >> ~/.zprofile
echo "export TCL_LIBRARY=$TCL_LIBRARY:`pwd`/tcl8.5.10/" >> ~/.zprofile
source ~/.zprofile

echo 'Path installation complete. Run ns or nam'

echo 'cleaning up...'

cd ..
rm ns-allinone-2.35.tar.gz
rm ns-allinone-2.35-patch.zip

echo 'Installation complete'
