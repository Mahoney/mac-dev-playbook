#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

main() {
  local git_repo="${1:-https://github.com/Mahoney/mac-dev-playbook.git}"
  local install_dir="${2:-$HOME/.mac_up}"

  echo "==========================================="
  echo "Setting up your mac using $git_repo"
  echo "==========================================="

  echo
  echo "If asked for a password you may need to use an access token. You may have stored it in LastPass."

  installXcodeCliTools
  export PATH="$HOME/Library/Python/3.8/bin:$PATH"

  if [ -f "$install_dir" ]; then
    cd "$install_dir"
    git pull
  else
    git clone "$git_repo" "$install_dir"
    cd "$install_dir"
  fi

  sudo pip3 install --upgrade pip
  sudo pip3 install ansible

  ansible-galaxy install -r requirements.yml

  ANSIBLE_CONFIG="$install_dir/ansible.cfg" ansible-playbook -i "$install_dir/inventory" "$install_dir/main.yml" -K

  echo "Setup done"
}

installXcodeCliTools() {
  set +e
  local install_output; install_output=$(sudo xcode-select --install 2>&1)
  local result=$?
  set -e
  if [[ "$result" -eq 0 ]]; then
    # Waiting on them to actually be installed...
    sleep 1
    installXcodeCliTools
  elif [[ "$result" -eq 1 && "$install_output" == *"already installed"* ]]; then
    # All good! Away we go
    echo "Installed XCode Command Line Tools"
    return 0
  else
    echo "$install_output" >&2
    return "$result"
  fi
}

main "$@"
