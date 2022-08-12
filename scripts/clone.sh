#! /usr/bin/env bash

# A script that provides cloning functionality of the git repositories

work_dir="$PWD"

. "$work_dir/scripts/functions.sh"

function usage() {
  echo "Usage: $0 -r <repo-url> -d <destination> [-h]";
}

while getopts "r:d:h" optname; do 
  case "${optname}" in
    r) repo=${OPTARG}
      ;;
    d) destination=${OPTARG}
      ;;
    h) usage
      exit 0
      ;;
    :) error "-${OPTARG} requires an argument"
      exit 1
      ;;
    *) usage
      exit 1
  esac
done

if [ -z "$repo" ]; then
  error "-r is a mandatory argument"
  exit 1
fi

if [ -z "$destination" ]; then
  error "-d is a mandatory argument"
  exit 1
fi

if [ -d "$destination" ] || [ -f "$destination" ]; then
  checkAndConfirm "$destination already exists. Confirm its removal?"
  rm -rf "$destination"
fi

log "Performing clone of $repo into $destination..."
git clone "$repo" "$destination"

checkExitCode "$?" "clone"

log "$repo cloned successfully"