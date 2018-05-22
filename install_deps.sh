#!/bin/bash


distro=''
packagemgr=''

if [ -f '/etc/fedora-release' ]
then
    packagemgr=dnf
    distro='fedora'
fi
if [ -f '/etc/centos-release' ]
then
    packagemgr=yum
    distro='centos'
fi

if [ -z "$packagemgr" ]
then
    echo 'Unable to detect package manager... aborting.'
    exit 1
fi

# Install dependencies for the rpm build process, including the electron
# package.  The electron package sadly is not in the official repositories of
# Fedora / CentOS, so we have to build it via npm.
sudo $packagemgr install rpm-build gcc-c++ python2 git \
    clang dbus-devel gtk3-devel libnotify-devel \
    libgnome-keyring-devel xorg-x11-server-utils libcap-devel \
    cups-devel libXtst-devel alsa-lib-devel libXrandr-devel \
    GConf2-devel nss-devel libXScrnSaver make \
    -y

# CentOS doesn't ship with an ideal version of node and npm, so we download and
# install them on our own.
if [ $distro == 'centos' ]
then
    sudo $packagemgr install epel-release -y
    curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
    sudo $packagemgr install nodejs -y
    sudo npm install npm@latest -g
fi

# Fedora has a decent version for node and npm, we can simply install them.
if [ $distro == 'fedora' ]
then
    sudo $packagemgr install node npm -y
fi

# Install yarn
if [ ! -f /etc/yum.repos.d/yarn.repo ]
then
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo $packagemgr install yarn -y
fi

# install electron
if [ ! -f /usr/local/bin/electron ]
then
    sudo yarn global add electron
fi
