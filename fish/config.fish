function fish_user_keybindings
    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
end

if test "$__fish_active_key_bindings" = "fish_vi_key_bindings"
    fish_user_keybindings
end

fish_vi_key_bindings

if status is-interactive
    # Existing Aliases and Settings
    set -g fish_greeting
    alias vim='nvim'
    alias gts='git status'
    alias gta='git add'
    alias gtc='git commit'
    alias gtp='git push'

    alias sd "cd && cd (find * -type d | fzf)"
    alias sdh "cd (find * -type d | fzf)"
    alias sdvi "vim (find * -type f | fzf)"

    alias openssl-idea='~/.config/scripts/oidea.sh'
    alias openssl-ssh='~/.config/scripts/idea_script_ssh.sh'
    alias bit_opener='~/.config/scripts/bit_opener.sh'

    alias quant_rishik='cd /mnt/aliqyan_hdd/Vicharak/repos/Quantpnr_RisikAnna/'
    alias vicharak='cd /mnt/aliqyan_hdd/Vicharak'
    
    set -g theme_color_user ffffff
    set -g theme_color_group 666666
    set -g theme_color_host ffffff
    set -g theme_display_time no
    set -g theme_display_group no
    set -g theme_display_hostname yes
    set -g theme_display_git yes
    set -g theme_display_jobs no
    set -g theme_display_jobs_always no
    set -g theme_display_rw no
    set -g theme_display_virtualenv no
    set -g theme_display_batt no
    set -g theme_display_batt_icon no
end

set -q GHCUP_INSTALL_BASE_PREFIX; or set GHCUP_INSTALL_BASE_PREFIX $HOME

set -gx PATH /home/aliqyanabid/go/bin /home/aliqyanabid/.ghcup/bin $HOME/.cabal/bin $HOME/.cargo/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /var/lib/snapd/snap/bin

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/aliqyanabid/.ghcup/bin # ghcup-env
