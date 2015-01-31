#!/bin/bash
############################
# install_nvm.sh
# This script installs nvm
############################

NVM_REPO=https://github.com/creationix/nvm.git 
NVM_ROOT=$HOME/.nvm
RC_FILE=$HOME/.zsh-sources/nvm

die () {
    echo $1 >&2
    exit 1
}

install_nvm () {
    git --version || die "git is not installed."

    if [[ -d $NVM_ROOT ]]; then
        echo nvm is already installed
        exit 0
    fi

    git clone $NVM_REPO $NVM_ROOT || die "git clone failure $NVM_REPO"
    echo 'source ~/.nvm/nvm.sh' > $RC_FILE
}

install_nvm
