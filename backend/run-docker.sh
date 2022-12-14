#! /usr/bin/env bash

work_dir="$PWD"
jar_file="app.jar"

if [ -z "$jar_file" ]; then
	echo "Cannot find the installed app to run"
	exit 1
fi

. ethics-envs.sh

echo "Starting $work_dir/app/target/$jar_file"

jvm_args="$@"

java $jvm_args -Dspring.profiles.default=prod -jar "$jar_file"

