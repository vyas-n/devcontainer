#!/bin/bash

# Homebrew
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# ASDF: https://asdf-vm.com/#/core-manage-asdf?id=add-to-your-shell
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Nix
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"
