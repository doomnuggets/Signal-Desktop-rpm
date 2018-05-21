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


if [ $distro == 'centos' ]
then
    sudo $packagemgr install epel-release -y
fi

sudo $packagemgr install rpm-build node npm gcc-c++ python2 git \
    clang dbus-devel gtk3-devel libnotify-devel \
    libgnome-keyring-devel xorg-x11-server-utils libcap-devel \
    cups-devel libXtst-devel alsa-lib-devel libXrandr-devel \
    GConf2-devel nss-devel libXScrnSaver \
    -y

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
