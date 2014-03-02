# Path to oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="yosu"

# Load my oh-my-zsh customizations
ZSH_CUSTOM=$HOME/.zsh-custom

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
source $HOME/.zshrc.local

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
