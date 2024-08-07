#!/usr/bin/env bash

# Script: check-setup.sh
#
# Description:
# Used to check the current setup has the prerequisites and dependencies for running the project.
#
# Example:
#  - ./check-setup.sh

set -Eeuo pipefail

# shellcheck disable=SC2034
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
project_root_dir="$(git rev-parse --show-toplevel)"
status=PASS

setup_colors() {
  # Checks for terminal colour support
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    # shellcheck disable=SC2034
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

check_tool() {
  tool=${1}
  if type -f "${tool}" > /dev/null 2>&1; then
    msg "${GREEN} ✅ Found tool: ${tool} ${NOFORMAT}"
  else 
    msg "${RED} ❌ Missing tool: ${tool} ${NOFORMAT}"
    status=FAIL
  fi
}

check_file() {
  file=${1}
  if [ -f "${project_root_dir}/${file}" ]; then
    msg "${GREEN} ✅ Found file: ${file}! ${NOFORMAT}"
  else 
    msg "${RED} ❌ Missing file: ${file}! ${NOFORMAT}"
    status=FAIL
  fi
}

setup_colors

# script logic here

msg "${CYAN}Checking setup...${NOFORMAT}"
msg ""
check_tool "docker"
check_tool "task"
check_file "docker-compose.yml"
msg ""

if [ "${status}" == "PASS" ]; then
  msg "${GREEN}Everything is setup correctly! ${NOFORMAT}"
else
  msg "${RED}Something is missing, check the logs! ${NOFORMAT}"
fi




