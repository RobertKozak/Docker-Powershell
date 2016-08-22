#!/usr/bin/env bash

# based off of https://github.com/PowerShell/PowerShell/blob/master/tools/download.sh
#
# I made small changes to use in Dockerfile: removed sudo, added some apt-get update and cleanup
# so the resulting image  would be smaller.
# The changes I made are mostly for Ubuntu since I am not that familiar with Darwin or Centos distros

# Let's quit on interrupt of subcommands
trap '
  trap - INT # restore default INT handler
  echo "Interrupted"
  kill -s INT "$$"
' INT

# Retrieves asset ID and package name of asset ending in argument
# $info looks like: "id": 1698239, "name": "powershell_0.4.0-1_amd64.deb",
get_info() {
    curl -s https://api.github.com/repos/PowerShell/PowerShell/releases/latest | grep -B 1 "name.*$1"
}

# Get OS specific asset ID and package name
case "$OSTYPE" in
    linux*)
        source /etc/os-release
        echo "Install curl to download package"
        case "$ID" in
            centos*)
                if [[ -z $(command -v curl) ]]; then
                    echo "curl not found, installing ..."
                    yum install -y curl
                fi
                version=rpm
                ;;
            ubuntu)
                apt-get update --quiet -y
                apt-get upgrade --quiet -y
                case "$VERSION_ID" in
                    14.04)
                        version=ubuntu1.14.04.1_amd64.deb
                        ;;
                    16.04)
                        version=ubuntu1.16.04.1_amd64.deb
                        ;;
                    *)
                        echo "Ubuntu $VERSION_ID is not supported!" >&2
                        exit 2
                esac
                if [[ -z $(command -v curl) ]]; then
                    echo "curl not found, installing ..."
                    apt-get install -y curl
                fi
                ;;
            *)
                echo "$NAME is not supported!" >&2
                exit 2
        esac
        ;;
    darwin*)
        version=pkg
        ;;
    *)
        echo "$OSTYPE is not supported!" >&2
        exit 2
        ;;
esac

info=$(get_info $version)

# Parses $info for asset ID and package name
read asset package <<< $(echo $info | sed 's/[,"]//g' | awk '{ print $2; print $4 }')

# Downloads asset to file
packageuri=$(curl -s -i -H 'Accept: application/octet-stream' https://api.github.com/repos/PowerShell/PowerShell/releases/assets/$asset |
    grep location | sed 's/location: //g')
curl -C - -s -o $package ${packageuri%$'\r'}

# Installs PowerShell package
case "$OSTYPE" in
    linux*)
        source /etc/os-release
        # Install dependencies
        case "$ID" in
            centos)
                echo "Installing libicu, libunwind, and $package ..."
                yum install -y libicu libunwind
                yum install "./$package"
                ;;
            ubuntu)
                case "$VERSION_ID" in
                    14.04)
                        icupackage=libicu52
                        ;;
                    16.04)
                        icupackage=libicu55
                        ;;
                esac
                echo "Installing $libicupackage, libunwind8, and $package ..."
                apt-get install -y libunwind8 $icupackage
                dpkg -i "./$package"
                ;;
            *)
        esac
        ;;
    darwin*)
        echo "Installing $package ..."
        installer -pkg ./$package -target /
        ;;
esac

# Remove downloaded package
rm ./$package

powershell -noprofile -c '"Congratulations! PowerShell is installed at $PSHOME"'
success=$?

if [[ $success != 0 ]]; then
    echo "ERROR! PowerShell didn't install. Check script output" >&2
    exit $success
fi