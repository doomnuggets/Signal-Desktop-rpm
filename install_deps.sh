#!/bin/bash

packagemgr=''

if [ -f '/etc/fedora-release' ]
then
    packagemgr=dnf
fi
if [ -f '/etc/centos-release' ]
then
    packagemgr=yum
fi

if [ -z "$packagemgr" ]
then
    echo "Unable to detect package manager... aborting."
    exit 1
fi


function add_to_shell_rc() {
    for shellCfg in ".zshrc" ".bashrc"
    do
        echo -e $1 >> "$HOME/$shellCfg"
    done
}

# install g++
if ! rpm -q --quiet gcc-c++
then
    sudo $packagemgr install gcc-c++
fi

# Install yarn
if [ ! -f /etc/yum.repos.d/yarn.repo ]
then
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo $packagemgr install yarn
fi

# install electron
if [ ! -f /usr/local/bin/electron ]
then
    sudo yarn global add electron
fi
