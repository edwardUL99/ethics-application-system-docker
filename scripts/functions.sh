# utility functions for use by the scripts

RED="\033[0;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

function log() {
  echo -e "[${GREEN}INFO${RESET}] $1"
}

function error() {
  echo -e "[${RED}ERROR${RESET}] $1"
}

function warn() {
  echo -e "[${YELLOW}WARN${RESET}] $1"
}

ABORT_CODE="123"

function checkExitCode() {
  exitCode="$1"
  commandName="$2"

  if [ "$exitCode" -ne "0" ]; then
    if [ ! -z "$commandName" ]; then
      error "$commandName failed to execute"
    fi

    exit "$exitCode"
  fi
}

function checkAndConfirm() {
  alwaysYes="$DOCKER_ALWAYS_YES"

  if [ -z "$alwaysYes" ]; then
    prompt="$1 (Y/n)"
    warn "$prompt"
    read confirmation

    while [ "$confirmation" != "Y" ] && [ "$confirmation" != "n" ]; do
      warn "$prompt";
      read confirmation
    done

    if [ "$confirmation" != "Y" ]; then
      log "Aborting..."
      exit "$ABORT_CODE"
    fi
  fi
}

function removeGit() {
  repo="code/$1"
  rm -rf "$repo/.git"
}

function makeCodeDirIfNotExists() {
  if [ ! -d "$PWD/code" ] && [ ! -f "$PWD/code" ]; then
    mkdir "$PWD/code"
  elif [ -f "$PWD/code" ]; then
    checkAndConfirm "$PWD/code already exists as a file. Confirm removal?"
    rm "$PWD/code"
    mkdir "$PWD/code"
  fi
}