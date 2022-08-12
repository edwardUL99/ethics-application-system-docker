#! /usr/bin/env bash

# A script that provides the build for the backend

work_dir="$PWD"

. "$PWD/scripts/functions.sh"

makeCodeDirIfNotExists

"$work_dir/scripts/clone.sh" -r "https://github.com/edwardUL99/ethics-application-system-backend" -d "$work_dir/code/backend"
checkExitCode "$?"

removeGit "backend"

log "Building backend code..."

if [ ! -f "$work_dir/backend/ethics-envs.sh" ]; then
  error "$work_dir/backend/ethics-envs.sh doesn't exist"
  exit 1
fi

if [ -f "$work_dir/backend/application.properties" ]; then
  . "$work_dir/backend/ethics-envs.sh"

  profile="prod"
  set_profile=""

  if [ ! -z "$SPRING_PROFILES_ACTIVE" ]; then
    profile="$SPRING_PROFILES_ACTIVE"
  else
    set_profile="Y"
  fi

  cp "$work_dir/backend/application.properties" "$work_dir/code/backend/app/src/main/resources/application-$profile.properties"

  if [ ! -z "$set_profile" ]; then
    echo 'exportIfNotSet "SPRING_PROFILES_ACTIVE" "prod"' >> "$work_dir/backend/ethics-envs.sh"
    warn "SPRING_PROFILES_ACTIVE was not set in, so it has been set"
  fi
else
  warn "$work_dir/backend/application.properties doesn't exist, required environment properties may not be set"
fi

cd "$work_dir/code/backend"
tools/build.sh -DskipTests
checkExitCode "$?" "backend build"
cd "$work_dir"

cp "$work_dir"/code/backend/app/target/*.jar "$work_dir/backend/app.jar"

log "Building Docker image..."
cd "$work_dir/backend"
docker build --tag ethics-backend .
checkExitCode "$?" "backend docker image build"

log "Cleaning up backend build..."
rm -rf "$work_dir/scripts/code/backend" && rm -rf "$work_dir/backend/app.jar"
checkExitCode "$?" "clean up"

log "Backend docker image built successfully..."