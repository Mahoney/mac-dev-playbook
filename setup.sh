#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

main() {
  local role="${1:-personal}"
  local git_repo="${2:-https://Mahoney@github.com/Mahoney/mac-dev-playbook.git}"
  local install_dir="${3:-~/.mac_up}"

  echo "==========================================="
  echo "Setting up your mac using $git_repo"
  echo "==========================================="

  export PATH="$HOME/Library/Python/3.8/bin:$PATH"

  ./clone.sh "$git_repo" "$install_dir"
  cd "$install_dir"
  ./prepare.sh
  ./run.sh "$role"
}

main "$@"
