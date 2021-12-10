#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

main() {

  set +e
  local install_output; install_output=$(xcode-select --install 2>&1)
  local result=$?
  set -e
  if [[ "$result" -gt 1 || ("$result" == 1 && "$install_output" != *"already installed"* ) ]]; then
    echo "$install_output" >&2
    exit "$result"
  fi

  sudo pip3 install --upgrade pip
  sudo pip3 install ansible
}

main "$@"
