# sudo dnf install zsh-syntax-highlighting
# sudo dnf install zsh-autosuggestions 

# loading fpath, necessary to avoid some errors
fpath=(/usr/share/zsh/site-functions /usr/share/zsh/$ZSH_VERSION/functions $fpath)
PATH="/home/aliqyanabid/.local/bin:$PATH"
export PATH="/home/aliqyanabid/.nimble/bin:$PATH"

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
unsetopt menu_complete          # Autocomplete first match
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
HISTSIZE=20000
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
alias gtcd='git checkout'
alias sd='cd && cd $(find * -type d | fzf)'
alias sdh='cd $(find * -type d | fzf)'
alias sdvi='vim $(find * -type f | fzf)'
alias rain='~/.config/scripts/rain.sh'
alias sgit='~/.config/scripts/sgit.sh'
alias fresh='~/.config/scripts/fresh'
alias nook='~/.config/scripts/nook'
alias aoc='~/.config/scripts/aoc.sh'
alias qaf='cd /mnt/aliqyan_hdd/Vicharak/repos/qaf'
alias sims='cd ~/Vicharak/repos/quantpnr_red/diff_parser/sim_models'

alias openssl-idea='~/.config/scripts/oidea.sh'
alias openssl-ssh='~/.config/scripts/idea_script_ssh.sh'
alias bit_opener='~/.config/scripts/bit_opener.sh'
alias quant_rishik='cd /mnt/aliqyan_hdd/Vicharak/repos/Quantpnr_RisikAnna/'
alias vicharak='cd /mnt/aliqyan_hdd/Vicharak'
alias vinuwa='cd /home/aliqyanabid/Vicharak/repos/refact/ViNuwa'
alias ghrep='~/.config/scripts/ghrep.sh'

alias music='~/.config/scripts/spotube.sh'
alias cmaker='~/.config/scripts/cmaker.sh'
alias eda='~/.config/scripts/eda.sh'
alias ob='~/.config/scripts/obsidian.sh'
alias openfpga='~/.config/scripts/openfpga.sh'
alias efx='source ~/Downloads/efinity/2024.2/bin/setup.sh'
alias t120_posi='cp /usr/local/bin/posi_bcram .'
alias t4_posi='cp /usr/local/bin/blank.db ./posi_bcram'
alias t120_arch='vim /mnt/aliqyan_hdd/Vicharak/repos/Quantpnr_RisikAnna/arch_exp/tiles/arch_oph_337x642_b33_d10.xml'
alias 2026='echo "Year of @Aliqyan-21"'
alias i3break='~/.config/i3/scripts/i3break.sh'
alias dp='~/Vicharak/repos/quantpnr_red/diff_parser'

# PATH setup
export PATH="$HOME/go/bin:$HOME/.ghcup/bin:$HOME/.cabal/bin:$HOME/.cargo/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/var/lib/snapd/snap/bin:$PATH"

# GHCUP setup
export GHCUP_INSTALL_BASE_PREFIX="${GHCUP_INSTALL_BASE_PREFIX:-$HOME}"

NEWLINE=$'\n'

# Load vcs_info for Git status
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# git configuration
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{#6e6a86}│%f %F{#ebbcba}%b%f%F{#6e6a86}%u%c%f'
zstyle ':vcs_info:git:*' actionformats ' %F{#6e6a86}│%f %F{#ebbcba}%b%f %F{#6e6a86}:%f %F{#f6c177}%a%f%F{#6e6a86}%u%c%f'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr ' %F{#eb6f92}✗%f'
zstyle ':vcs_info:git:*' stagedstr ' %F{#9ccfd8}✓%f'

PROMPT='%F{#6e6a86}╭─%f %F{#e0def4}%n%f %F{#6e6a86}at%f %F{#c4a7e7}%~%f${vcs_info_msg_0_}${NEWLINE}%F{#6e6a86}╰─%f %F{#9ccfd8}❯%f '

# sourcing plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-vi-man/.zsh-vi-man/zsh-vi-man.plugin.zsh

# # shows a random quote on startup
# if command -v fortune &> /dev/null && command -v boxes &> /dev/null && command -v lolcat &> /dev/null; then
#   fortune -s | lolcat -g 88CCEE:FFDD99 -h 0.1 -v 0.05
# fi

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


# Start ssh-agent and load its environment variables if not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent >! ~/.ssh-agent-thing
fi

# Load the agent environment variables if the file exists and the variables aren't set
if [ -f ~/.ssh-agent-thing ] && [ -z "$SSH_AGENT_PID" ]; then
    # The 'source' command is safer than 'eval "$(<file)"' for this purpose.
    # It also ensures that the file is not empty before reading it.
    source ~/.ssh-agent-thing > /dev/null
fi

export FPCDIR='/usr/local/share/fpcsrc'
export PP='/usr/bin/fpc'
alias boom='echo boom baam vada pav'

#cgdb
export CGDB_DIR=/home/aliqyanabid/.config/cgdb/

# fnm
FNM_PATH="/home/aliqyanabid/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
