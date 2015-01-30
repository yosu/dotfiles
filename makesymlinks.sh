#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

SRC_DIR=~/dotfiles                              # dotfiles directory
BACKUP_DIR=~/dotfiles_old/$(date +%Y%m%d%H%M%S) # old dotfiles backup directory

# list of files/folders to symlink in homedir
FILES="gemrc gitconfig oh-my-zsh tmux.conf vim vimbackups vimrc zshrc zsh-custom"

##########

# create dotfiles_old in homedir
echo -n "Creating $BACKUP_DIR for backup of any existing dotfiles in ~ ..."
mkdir -p $BACKUP_DIR
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $SRC_DIR directory ..."
cd $SRC_DIR
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $FILES
for file in $FILES; do
    if [ -e ~/.$file ]; then
        echo "Moving any existing dotfiles from ~ to $BACKUP_DIR"
        mv ~/.$file $BACKUP_DIR
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $SRC_DIR/$file ~/.$file
done

append_line () {
    local LINE=$1
    local FILE=$2
    
    if [ $(grep "$LINE" "$FILE" | wc -l) -eq 0 ]; then
        echo $LINE >> $FILE
    fi
}

install_zsh () {
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh -o -f /usr/local/bin/zsh ]; then
        # Clone oh-my-zsh repository from GitHub only if it isn't already present
        if [[ ! -d $SRC_DIR/oh-my-zsh/ ]]; then
            git clone https://github.com/robbyrussell/oh-my-zsh.git
        fi
    
        local ZSH=$(which zsh)
	# Set the tmux default shell to zsh
	append_line "set-option -g default-shell $ZSH" "$SRC_DIR/tmux.conf"
    else
        echo "Please install zsh, then re-run this script!"
    fi
}

install_vim_bundle () {
    # Install vundle only if it isn't already present
    if [[ ! -d $SRC_DIR/vim/bundle/ ]]; then
        echo "Installing vundle"
        git clone https://github.com/gmarik/vundle.git $SRC_DIR/vim/bundle/vundle
        echo "done"
    fi

    vim +BundleInstall +qall
}

install_vim_bundle
install_zsh
