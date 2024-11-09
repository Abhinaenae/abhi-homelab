#!/bin/bash

# Install Netdata and stress
sudo apt-get install -y stress
echo "Installing Netdata..."

sudo curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh

echo "installation complete."
