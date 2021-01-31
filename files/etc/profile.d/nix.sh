#!/bin/sh

# Nix: https://nixos.org/manual/nix/stable/#sect-single-user-installation
export NIX_INSTALLER_NO_MODIFY_PROFILE=1
# shellcheck disable=SC1090
if [ -f "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
