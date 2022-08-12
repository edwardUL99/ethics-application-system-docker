#! /usr/bin/env bash

# A script that provides the build for the frontend

work_dir="$PWD"

. "$work_dir/scripts/functions.sh"

makeCodeDirIfNotExists

"$work_dir/scripts/clone.sh" -r "https://github.com/edwardUL99/ethics-application-system-frontend" -d "$work_dir/code/frontend"
checkExitCode "$?"

removeGit "frontend"

log "Building frontend code..."
cp "$work_dir/frontend/environment.ts" "$work_dir/code/frontend/src/environments/environment.prod.ts"
cd "$work_dir/code/frontend"
npm ci
checkExitCode "$?" "NPM installation"
npm run build
checkExitCode "$?" "frontend build"
cd "$work_dir"

cp -r "$work_dir/code/frontend/dist" "$work_dir/frontend"

log "Building Docker image..."
cd "$work_dir/frontend"
docker build --tag ethics-frontend .
checkExitCode "$?" "frontend docker image build"

log "Cleaning up frontend build..."
rm -rf "$work_dir/code/frontend" && rm -rf "$work_dir/frontend/dist"
checkExitCode "$?" "clean up"

log "Frontend docker image built successfully..."
