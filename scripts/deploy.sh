#! /usr/bin/env bash

if [ -f docker-compose.yml ]; then
  listing="correct"
fi

if [ -f ../docker-compose.yml ]; then
  parent="correct"
fi

RED="\033[0;31m"
RESET="\033[0m"

if [ -z "$listing" ] && [ -z "$parent" ]; then
  echo -e "[${RED}ERROR${RESET}]: Deploy needs to be run from the root of the docker deployment repository..."
  exit 1
elif [ -z "$listing" ] && [ ! -z "$parent" ]; then
  cd ..
fi

work_dir="$PWD"

. "$work_dir/scripts/functions.sh"

log "Building the Docker deployment for the Ethics Application System project"

"$work_dir/scripts/backend.sh"
checkExitCode "$?"

echo

"$work_dir/scripts/frontend.sh"
checkExitCode "$?"

rm -rf code
