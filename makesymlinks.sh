#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

SRC_DIR=~/dotfiles                              # dotfiles directory
BACKUP_DIR=~/dotfiles_old/$(date +%Y%m%d%H%M%S) # old dotfiles backup directory

# list of files/folders to symlink in homedir
FILES="zshrc oh-my-zsh zsh-custom tmux.conf gitconfig vim vimrc"

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
    echo "Moving any existing dotfiles from ~ to $BACKUP_DIR"
    mv ~/.$file $BACKUP_DIR
    echo "Creating symlink to $file in home directory."
    ln -s $SRC_DIR/$file ~/.$file
done

sudo_command() {
    local COMMAND=$1

    # clear any previous sudo permission
    sudo -k

    # run inside sudo
    sudo bash <<SCRIPT
        $COMMAND
SCRIPT
}

install_zsh () {
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh -o -f /usr/local/bin/zsh ]; then
        # Clone my oh-my-zsh repository from GitHub only if it isn't already present
        if [[ ! -d $SRC_DIR/oh-my-zsh/ ]]; then
            git clone https://github.com/robbyrussell/oh-my-zsh.git
        fi
    
        local ZSH=$(which zsh)
        # Set the default shell to zsh if it isn't currently set to zsh
        if [[ ! $(echo $SHELL) == $ZSH ]]; then
            # The default shell must be registered at /etc/shells
            if [ $(grep "$ZSH" /etc/shells | wc -l) -eq 0 ]; then
                echo "Append '$ZSH' to /etc/shells"
                sudo_command "echo $ZSH >> /etc/shells"
                echo "done"
            fi
    
            chsh -s $ZSH
        fi
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
