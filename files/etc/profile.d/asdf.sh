#!/bin/sh

# ASDF Environment Variables: https://asdf-vm.com/#/core-configuration?id=environment-variables

export ASDF_DATA_DIR="${HOME}/.asdf"
export ASDF_CONFIG_FILE="${HOME}/.asdfrc" # Config: https://asdf-vm.com/#/core-configuration?id=homeasdfrc
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=".tool-versions"

# export ASDF_DIR="${HOME}/.asdf"
# export ASDF_BIN="${ASDF_DIR}/bin"
# export ASDF_USER_SHIMS="${ASDF_DIR}/shims"
# export PATH="${ASDF_USER_SHIMS}:${ASDF_BIN}:${PATH}"

if [ -f "${ASDF_DATA_DIR}/asdf.sh" ]; then
    # shellcheck disable=SC1090
    . "${ASDF_DATA_DIR}/asdf.sh"

    if [ -f "${ASDF_DATA_DIR}/completions/asdf.bash" ]; then
        # shellcheck disable=SC1090
        . "${ASDF_DATA_DIR}/completions/asdf.bash"
    fi
fi
