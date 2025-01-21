#!/bin/sh

echo "Running Kali-specific setup..."

sudo apt install kali-linux-everything

echo "Calling debian.sh as part of the setup..."
bash ./debian.sh

echo "Finished Kali setup."
