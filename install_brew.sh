#!/usr/bin/env bash

if [[ ! -x /usr/local/bin/brew ]]; then
    echo 'installing brew ...'
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    echo 'done'
fi




