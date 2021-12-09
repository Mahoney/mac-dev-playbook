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

#  export PATH="$HOME/Library/Python/3.8/bin:$PATH"
#
#  sudo pip3 install --upgrade pip
#  python3 -m pip install --user libyaml
#  python3 -m pip install --user ansible
}

main "$@"
