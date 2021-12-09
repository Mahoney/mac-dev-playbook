#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

main() {

  local git_repo="$1"

  local install_dir="$2"

  echo
  echo "If asked for a password you may need to use an access token. You may have stored it in LastPass."
  if [ -f "$install_dir" ]; then
    cd "$install_dir"
    git pull
  else
    git clone "$git_repo" "$install_dir"
  fi
}

main "$@"
