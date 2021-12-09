#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

main() {

  xcode-select --install

  export PATH="$HOME/Library/Python/3.8/bin:$PATH"

  sudo pip3 install --upgrade pip
  python3 -m pip install --user libyaml
  python3 -m pip install --user ansible
}

main "$@"
