#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

SRC_DIR=$SCRIPT_DIR/dotfiles # dotfiles directory
BACKUP_DIR=~/dotfiles_old    # old dotfiles backup directory

##########
# make symlinks
make_symlink () {
    local file=$1

    if [ -e ~/.$file ]; then
        echo "Moving any existing dotfiles from $HOME to $BACKUP_DIR"
        mv ~/.$file $BACKUP_DIR
    fi

    echo "Creating symlink to $file in home directory."
    ln -s $SRC_DIR/$file ~/.$file
}

append_line () {
    local LINE=$1
    local FILE=$2
    
    if [ $(grep "$LINE" "$FILE" | wc -l) -eq 0 ]; then
        echo $LINE >> $FILE
    fi
}

install_oh_my_zsh () {
    # Clone oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
}

install_vim_bundle () {
    # Install vundle only if it isn't already present
    if [[ ! -d $SRC_DIR/vim/bundle/ ]]; then
        echo "Installing vundle"
        git clone https://github.com/gmarik/vundle.git $SRC_DIR/vim/bundle/vundle
    fi

    vim +BundleInstall +qall
}

setup_zsh () {
    # check preconditions
    if ! type -P zsh > /dev/null; then
        echo "Please install zsh, then re-run this script!"
        exit 1
    fi

    # Clone oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
        git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi

    # Set the tmux default shell to zsh
    append_line "set-option -g default-shell $(which zsh)" "$SRC_DIR/tmux.shell.conf"
}

make_symlinks () {
    # create dotfiles_old in homedir
    echo -n "Creating $BACKUP_DIR for backup of any existing dotfiles in ~ ..."
    mkdir -p $BACKUP_DIR
    echo "done"

    for path in $SRC_DIR/*; do
        make_symlink $(basename $path)
    done
}

setup_zsh
make_symlinks
install_vim_bundle
