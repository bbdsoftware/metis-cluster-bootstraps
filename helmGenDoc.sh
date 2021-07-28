#!/usr/bin/env bash

if [ ! -d ./docs/charts/modules/Chart-Docs ]; then
  mkdir -p ./docs/charts/modules/Chart-Docs;
fi

for f in ./charts-modules/*; do
    if [ -d "$f" ]; then
        # Will not run if no directories are available
        echo "$f"
        filename=`basename $f`
        frigate gen $f > ./docs/charts/modules/Chart-Docs/$filename.md
    fi
done