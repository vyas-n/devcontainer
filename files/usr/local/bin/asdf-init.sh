#!/bin/sh

for plugin in $(sed s/' .*$'// < .tool-versions); do
  if asdf plugin-list | grep -q "${plugin}" > /dev/null 2>&1; then
    asdf plugin-add "${plugin}" || true
  fi
done
