#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

main() {
  local git_repo="${1:-https://Mahoney@github.com/Mahoney/mac-dev-playbook.git}"
  local install_dir="${2:-$HOME/.mac_up}"

  echo "==========================================="
  echo "Setting up your mac using $git_repo"
  echo "==========================================="

  echo
  echo "If asked for a password you may need to use an access token. You may have stored it in LastPass."
  if [ -f "$install_dir" ]; then
    cd "$install_dir"
    git pull
  else
    git clone "$git_repo" "$install_dir"
    cd "$install_dir"
  fi

  set +e
  local install_output; install_output=$(xcode-select --install 2>&1)
  local result=$?
  set -e
  if [[ "$result" -gt 1 || ("$result" == 1 && "$install_output" != *"already installed"* ) ]]; then
    echo "$install_output" >&2
    exit "$result"
  fi
  export PATH="$HOME/Library/Python/3.8/bin:$PATH"

  sudo pip3 install --upgrade pip
  sudo pip3 install ansible

  ansible-galaxy install -r requirements.yml

  ANSIBLE_CONFIG=~/.macup/ansible.cfg ansible-playbook -i ~/.macup/inventory ~/.macup/main.yml -K

  echo "Setup done"
}

main "$@"
