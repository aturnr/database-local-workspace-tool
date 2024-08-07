#!/usr/bin/env bash

# Script: load-sql-file.sh
#
# Descripts:
# Used to load SQL files within databases running in a container. 
#
# Example:
#  - ./load-sql-file.sh /path/to/somefile.sql
#  - LOAD_DUMP=/path/to/somefile.sql ./load-sql-file.sh

set -Eeuo pipefail

# Variables

MYSQLD_SOCKET_FILE="/var/run/mysqld/mysqld.sock"

# Functions

msg() {
  echo >&2 -e "${1-}"
}

error() {
  local msg="[ERROR] ${1}"
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

#
# Main Script Logic
#

# Stop local runs
type -f "mysqld" > /dev/null 2>&1 || error "This script is intended to run inside MySQL Container."

# using first arg passed to script or SQL_FILE env variable as default
SQL_FILE=${1-${SQL_FILE}}

if [ -z "${SQL_FILE}" ]; then
  error "Either no args passed to script or SQL_FILE variable is not set."
fi

test -f "${SQL_FILE}" || error "${SQL_FILE} file doesn't exist!"

# Test readiness of MySQL Server socket (MySQL in docker takes a while to start...)
for _ in 1 2 3 4 5 6; do
  if [ -S "${MYSQLD_SOCKET_FILE}" ]; then
    break
  fi 
  msg "Waiting for MySQL Server to start..."
  sleep 5
done
test -S "${MYSQLD_SOCKET_FILE}" || error "Waiting for MySQL Server socket timed out..."

# Load sql file
msg "Loading SQL file: ${SQL_FILE}"
mysql < "${SQL_FILE}" || error "Failed to load ${SQL_FILE}"
msg "Loaded."