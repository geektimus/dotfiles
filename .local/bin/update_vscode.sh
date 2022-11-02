#!/bin/env bash

echo "Downloading new version of Visual Studio Code"
wget -t0 https://go.microsoft.com/fwlink/\?LinkID\=620884 -O code-stable.tar.gz
echo "Unzipping update file"
tar -xf code-stable.tar.gz && mv VSCode-linux-x64 vscode && sudo rm -rf /opt/vscode && sudo mv vscode /opt && rm code-stable.tar.gz
echo "Replacing current version of Visual Studio Code"
sudo ln -sf /opt/vscode/bin/code /usr/bin/code
