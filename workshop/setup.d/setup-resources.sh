#!/bin/bash

cat >> ~/.bashrc << EOF
set -o vi
EOF

# install kubens/kubectx ..
git clone https://github.com/ahmetb/kubectx.git ~/.kubectx
mkdir ~/bin
ln -s ~/.kubectx/kubectx ~/bin/
ln -s ~/.kubectx/kubens ~/bin/
