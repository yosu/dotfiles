#!/bin/sh
#
# Original version:
#   rbenvsetup http://is.gd/rbenvsetup
#   Tue May 28 11:03:00 JST 2013 v0.01 by ytnobody
#
# Modfied:
# - PROF_FILE: bash_profile -> zshrc

RBENV_REPO=git://github.com/sstephenson/rbenv.git
RBENV_ROOT=$HOME/.rbenv
PROF_FILE=$HOME/.zshrc.local

RUBYBUILDER_REPO=git://github.com/sstephenson/ruby-build.git
RBENV_PLUGIN_DIR=$RBENV_ROOT/plugins

die () {
    echo $1 >&2
    exit 1
}

write_profile () {
    if [ $(grep "$1" $PROF_FILE | wc -l) -le 0 ] ; then
        echo "$1" >> $PROF_FILE
    fi
}

git --version || die "git is not installed."

### setup rbenv
git clone $RBENV_REPO $RBENV_ROOT || die "git clone failure : $RBENV_REPO"
write_profile 'export RBENV_ROOT=$HOME/.rbenv'
write_profile 'export PATH=$PATH:$RBENV_ROOT/bin'
write_profile 'eval "$(rbenv init -)"'

### setup ruby-builder
mkdir $RBENV_PLUGIN_DIR
git clone $RUBYBUILDER_REPO $RBENV_PLUGIN_DIR/ruby-build || die "git clone failure : $RUBYBUILDER_REPO"

### load profile
exec $SHELL -l
