#!/usr/bin/bash
set -e

if ! [ -x "$(command -v ansible)" ]; then
  sudo pacman -S ansible
fi

ansible-playbook -i ~/.config/dotfiles/hosts ~/.config/dotfiles/dotfiles.yml \
  --ask-become-pass

if command -v terminal-notifier 1>/dev/null 2>&1; then
  terminal-notifier -title "dotfiles: Bootstrap complete" -message "Successfully set up dev environment."
fi
