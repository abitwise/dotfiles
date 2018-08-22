#!/usr/bin/env bash

# Fix ulimit error (needs to use sudo)
echo "Fixing ulimit error, make sure you have sudo rights and enter your pw"
echo kern.maxfiles=65536 | sudo tee -a /etc/sysctl.conf
echo kern.maxfilesperproc=65536 | sudo tee -a /etc/sysctl.conf
sudo sysctl -w kern.maxfiles=65536
sudo sysctl -w kern.maxfilesperproc=65536
