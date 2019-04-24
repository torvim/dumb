#!/usr/bin/env bash

git clone https://github.com/torvim/nu
cd nu

if
	shards install
	sudo crystal build src/main.cr -o /usr/bin/nu ; then
    echo "Successfully compiled and updated"
else
    echo "Unsuccessfully compiled and updated"
fi

