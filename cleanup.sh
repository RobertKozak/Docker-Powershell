#!/usr/bin/env bash

# The changes I made are mostly for Ubuntu since I am not that familiar with Darwin or Centos distros

# Clean up packages
echo "Cleaning up packages"
case "$OSTYPE" in
    linux*)
        source /etc/os-release
        # Install dependencies
        case "$ID" in
            centos)
                ;;
            ubuntu)
                apt-get purge --quiet -y curl 
                apt-get clean --quiet
                apt-get autoclean --quiet
                rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/log/dpkg.log
                ;;
            *)
        esac
        ;;
    darwin*)
        ;;
esac