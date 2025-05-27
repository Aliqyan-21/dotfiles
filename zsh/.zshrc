# sudo dnf install zsh-syntax-highlighting
# sudo dnf install zsh-autosuggestions 

# cursor blink
echo -ne '\e[1 q'

# loading fpath, necessary to avoid some errors
fpath=(/usr/share/zsh/site-functions /usr/share/zsh/$ZSH_VERSION/functions $fpath)
PATH="/home/aliqyanabid/.local/bin:$PATH"

zmodload zsh/zutil

# Ensure XDG_CONFIG_HOME is set
: ${XDG_CONFIG_HOME:=$HOME/.config}

# Sources global shell alias & variables files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

# Load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# Completion options
zstyle ':completion:*' menu select           # Tab opens completion menu
zstyle ':completion:*' special-dirs true     # Include . and .. in completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33  # Colorize completion
zstyle ':completion:*' file-list true        # Show detailed file list
zstyle ':completion:*' squeeze-slashes false # Allow /*/ expansion

# History options
setopt append_history         # Append to history instead of overwriting
setopt inc_append_history     # Append history immediately
# setopt share_history          # Share history across sessions
# setopt hist_ignore_dups       # Ignore duplicate commands
setopt hist_reduce_blanks     # Remove extra blanks from history
setopt hist_verify            # Verify history expansion before executing

# General options
setopt auto_menu              # Show completion menu automatically
setopt menu_complete          # Autocomplete first match
setopt autocd                 # Type directory name to cd
setopt auto_param_slash       # Add trailing slash for directories
setopt no_case_glob           # Case-insensitive globbing
setopt no_case_match          # Case-insensitive matching
setopt globdots               # Include dotfiles in globbing
setopt extended_glob          # Enable extended globbing (^, ~, etc.)
setopt interactive_comments   # Allow comments in interactive shell
unsetopt prompt_sp            # Don't clean up blank lines
stty stop undef               # Disable accidental Ctrl+S

# Ensure XDG_CACHE_HOME is set
: ${XDG_CACHE_HOME:=$HOME/.cache}
mkdir -p ${XDG_CACHE_HOME}

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_CACHE_HOME}/zsh_history"

# Vi mode setup 
bindkey -v
# Custom keybinding for jk to escape insert mode 
# bindkey -M viins 'jk' vi-cmd-mode

alias vim='nvim'
alias gts='git status'
alias gta='git add'
alias gtc='git commit'
alias gtp='git push'
alias sd='cd && cd $(find * -type d | fzf)'
alias sdh='cd $(find * -type d | fzf)'
alias sdvi='vim $(find * -type f | fzf)'
alias rain='~/.config/scripts/rain.sh'

alias openssl-idea='~/.config/scripts/oidea.sh'
alias openssl-ssh='~/.config/scripts/idea_script_ssh.sh'
alias bit_opener='~/.config/scripts/bit_opener.sh'
alias quant_rishik='cd /mnt/aliqyan_hdd/Vicharak/repos/Quantpnr_RisikAnna/'
alias vicharak='cd /mnt/aliqyan_hdd/Vicharak'
alias vinuwa='cd /home/aliqyanabid/Vicharak/repos/refact/ViNuwa'

alias music='~/.config/scripts/spotube.sh'
alias cmaker='~/.config/scripts/cmaker.sh'
alias eda='~/.config/scripts/eda.sh'
alias ob='~/.config/scripts/obsidian.sh'
alias openfpga='~/.config/scripts/openfpga.sh'
alias efx='source ~/Downloads/efinity/2024.2/bin/setup.sh'
alias t120_posi='cp /usr/local/bin/posi_bcram .'
alias t4_posi='cp /usr/local/bin/blank.db ./posi_bcram'
# alias efx_client='~/.config/scripts/efx_client'

# PATH setup
export PATH="$HOME/go/bin:$HOME/.ghcup/bin:$HOME/.cabal/bin:$HOME/.cargo/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/var/lib/snapd/snap/bin:$PATH"

# GHCUP setup
export GHCUP_INSTALL_BASE_PREFIX="${GHCUP_INSTALL_BASE_PREFIX:-$HOME}"

# set up prompt
NEWLINE=$'\n'

# Load vcs_info for Git status
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Enable Git in vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b)'         
zstyle ':vcs_info:git:*' actionformats '(%b|%a)'
zstyle ':vcs_info:git:*' formats '(%b%u%c)'     
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr ' ✗'       
zstyle ':vcs_info:git:*' stagedstr ' ✔'         

# Set PROMPT
PROMPT="${NEWLINE}%K{#2E3440}%F{#E5E9F0} %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k %F{#88C0D0}\${vcs_info_msg_0_}%f ${NEWLINE}❯ "

# echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m"

# sourcing plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# shows a random quote on startup
if command -v fortune &> /dev/null && command -v boxes &> /dev/null && command -v lolcat &> /dev/null; then
  fortune -s | lolcat -g 88CCEE:FFDD99 -h 0.1 -v 0.05
fi

# Custom Ctrl+L to scroll up instead of clearing (soft clear)
scroll-and-clear() {
  printf '\n%.0s' {1..$LINES}
  zle clear-screen
}
zle -N scroll-and-clear
bindkey '^L' scroll-and-clear

# for no colors in ls
LS_COLORS+=':ow=01;33'

export VIDOT_EDITOR=gedit
export VIDOT_TERMINAL=wezterm
