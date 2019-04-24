#!/usr/bin/env bash

git pull

if
	shards install
	sudo crystal build src/main.cr -o /usr/bin/nu ; then
    echo "Successfully compiled and updated"
else
    echo "Unsuccessfully compiled and updated"
fi

