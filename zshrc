# Path to oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="johndbritton"

# Load my oh-my-zsh customizations
ZSH_CUSTOM=$HOME/.zsh-custom

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
