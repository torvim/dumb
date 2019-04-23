#!/usr/bin/env bash

if
	shards install
	sudo crystal build src/main.cr -o /usr/bin/nu ; then
    echo "Successfully compiled and installed"
else
    echo "Unsuccessfully compiled and installed"
fi

