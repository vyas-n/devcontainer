#!/bin/sh

# Nix
# shellcheck disable=SC1090
if [ -f "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
