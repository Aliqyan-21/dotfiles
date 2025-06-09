# add this file at your /home/uasername 

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR="nvim"
export VISUAL="nvim"


export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000               
export SAVEHIST=10000               
. "$HOME/.cargo/env"
