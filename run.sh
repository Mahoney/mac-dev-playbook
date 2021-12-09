#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

main() {

  local role="$1"

  ansible-galaxy install -r requirements.yml
  ansible-playbook -i ./hosts "$role.yml"

  ANSIBLE_CONFIG=~/.macup/ansible.cfg ansible-playbook -i ~/.macup/inventory ~/.macup/main.yml -K

  echo "Setup done"
}

main "$@"
