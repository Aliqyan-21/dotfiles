if status is-interactive
  # Commands to run in interactive sessions can go here
  set -g fish_greeting
  alias vim='nvim'
  alias gts='git status'
  alias gta='git add'
  alias gtc='git commit'
  alias gtp='git push'

  set -g theme_color_user                            ffffff
  set -g theme_color_group                           666666
  set -g theme_color_host                            ffffff

  ## Enable the time to be displayed.
  set -g theme_display_time no

  ## Disable playing the user's current group.
  set -g theme_display_group no

  # Display the system hostname.
  set -g theme_display_hostname yes

  ## Disable Git-awareness.
  set -g theme_display_git yes

  ## Don't disable jobs indicator.
  set -g theme_display_jobs no

  ## Always display the jobs indicator, even if there are no jobs.
  set -g theme_display_jobs_always no

  ## Hide the current directory read/write indicator.
  set -g theme_display_rw no

  ## Don't display the VirtualEnv prompt.
  set -g theme_display_virtualenv no

  ## Display the battery
  set -g theme_display_batt no
  set -g theme_display_batt_icon no
end

set -q GHCUP_INSTALL_BASE_PREFIX; or set GHCUP_INSTALL_BASE_PREFIX $HOME

# Set PATH without duplicates
set -gx PATH /home/aliqyanabid/.ghcup/bin $HOME/.cabal/bin $HOME/.cargo/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /var/lib/snapd/snap/bin
