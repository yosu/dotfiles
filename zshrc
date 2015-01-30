# Path to oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="yosu"

# Load my oh-my-zsh customizations
ZSH_CUSTOM=$HOME/.zsh-custom

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Fixed TMUX window name
# http://superuser.com/questions/306028/tmux-and-zsh-custom-prompt-bug-with-window-name
export DISABLE_AUTO_TITLE=true

# Make git diff show UTF8 encoded characters properly
export LESSCHARSET=UTF-8
