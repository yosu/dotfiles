#!/bin/sh
#
# Original version:
#   rbenvsetup http://is.gd/rbenvsetup
#   Tue May 28 11:03:00 JST 2013 v0.01 by ytnobody
#

RBENV_REPO=git://github.com/sstephenson/rbenv.git
RBENV_ROOT=$HOME/.rbenv
PROF_FILE=$HOME/.zsh-sources/rbenv

RUBYBUILDER_REPO=git://github.com/sstephenson/ruby-build.git
RBENV_PLUGIN_DIR=$RBENV_ROOT/plugins

die () {
    echo $1 >&2
    exit 1
}

git --version || die "git is not installed."

### setup rbenv
git clone $RBENV_REPO $RBENV_ROOT || die "git clone failure : $RBENV_REPO"
cat << 'END' > $PROF_FILE
export RBENV_ROOT=$HOME/.rbenv
export PATH=$PATH:$RBENV_ROOT/bin
eval "$(rbenv init -)"
END

### setup ruby-builder
mkdir $RBENV_PLUGIN_DIR
git clone $RUBYBUILDER_REPO $RBENV_PLUGIN_DIR/ruby-build || die "git clone failure : $RUBYBUILDER_REPO"

### setup plugins
git clone https://github.com/sstephenson/rbenv-gem-rehash.git $RBENV_PLUGIN_DIR/rbenv-gem-rehash || die "git clone failure : rbenv-gem-rehash"
git clone https://github.com/ianheggie/rbenv-binstubs.git $RBENV_PLUGIN_DIR/rbenv-binstubs || die "git clone failure : rbenv-binstubs"
