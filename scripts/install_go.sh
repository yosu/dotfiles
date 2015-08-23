#!/bin/bash
set -e

OS=${OS:-linux}
VERSION=${VERSION:-1.4.1}
ARCH=${ARCH:-amd64}
GO_SRC=go${VERSION}.${OS}-${ARCH}.tar.gz
PROF_FILE=$HOME/.zsh-sources/go

DEST_DIR=${DEST_DIR:-$HOME}
GOROOT=$DEST_DIR/go

if [ ! -d $GOROOT ];then
    mkdir $GOROOT
fi

wget https://storage.googleapis.com/golang/${GO_SRC}
tar -C $DEST_DIR -xzf $GO_SRC
rm $GO_SRC

cat << END > $PROF_FILE
export GOROOT=$GOROOT
export GOPATH=\$HOME/.go
export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin
END
