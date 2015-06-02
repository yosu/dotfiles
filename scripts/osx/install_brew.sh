#!/usr/bin/env bash

if [[ ! -x /usr/local/bin/brew ]]; then
    echo 'installing brew ...'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap Homebrew/bundle
    echo 'done'
fi




