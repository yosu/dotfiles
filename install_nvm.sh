#!/bin/bash
############################
# install_nvm.sh
# This script installs nvm
############################

NVM_REPO=https://github.com/creationix/nvm.git 
NVM_ROOT=$HOME/.nvm
RC_FILE=$HOME/.zshrc

die () {
    echo $1 >&2
    exit 1
}

write_profile () {
    if [ $(grep "$1" $RC_FILE | wc -l) -le 0 ] ; then
        echo "$1" >> $RC_FILE
    fi
}

install_nvm () {
    git --version || die "git is not installed."

    if [[ ! -d $NVM_ROOT ]]; then
        git clone $NVM_REPO $NVM_ROOT || die "git clone failure $NVM_REPO"
	write_profile 'source ~/.nvm/nvm.sh'
    fi
}

install_nvm
