#!/usr/bin/env sh

# TODO remove debug output in final version
set -x

name=$@

if [ -f "$1" ]; then
    name=$(cat "$1")
fi

if [ "$1" -eq "" ]; then
    echo "error: no name provided"
    exit 0
fi

echo -n hello
echo -n " "
echo $name
