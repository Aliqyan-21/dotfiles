#!/bin/bash

languages=$(cat <<EOF
golang
cpp
c
python
lua
haskell
EOF
)

core_utils=$(cat <<EOF
xargs
find
mv
sed
awk
grep
EOF
)

options=$(printf "%s\n%s" "$languages" "$core_utils")

selected=$(echo "$options" | fzf --prompt="Select language/utility: ")

if [[ -z "$selected" ]]; then
  echo "No selection made. Exiting."
  exit 1
fi

read -p "query: " query
if [[ -z "$query" ]]; then
  echo "Query cannot be empty. Please try again."
  exit 1
fi

formatted_query=$(echo "$query" | tr ' ' '+')

if echo "$languages" | grep -qs "$selected"; then
  if [[ -n "$TMUX" ]]; then
    tmux neww bash -c "curl -s cht.sh/$selected/$formatted_query | bat --paging=always --style=plain; tmux kill-window"
  else
    curl -s cht.sh/$selected/$formatted_query | bat --paging=always --style=plain
  fi
else
  if [[ -n "$TMUX" ]]; then
    tmux neww bash -c "curl -s cht.sh/$selected~$formatted_query | bat --paging=always --style=plain; tmux kill-window"
  else
    curl -s cht.sh/$selected~$formatted_query | bat --paging=always --style=plain
  fi
fi
