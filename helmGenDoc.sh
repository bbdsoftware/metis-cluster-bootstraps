#!/usr/bin/env bash

if [ ! -d ./docs/charts/modules/Chart-Docs ]; then
  mkdir -p ./docs/charts/modules/Chart-Docs;
fi

for f in ./charts-modules/*; do
    if [ -d "$f" ]; then
        # Will not run if no directories are available
        filename=`basename $f`
        echo "Generating readme for ./docs/charts/modules/Chart-Docs/$filename.md"
        frigate gen $f > ./docs/charts/modules/Chart-Docs/$filename.md
        echo "Generating readme for .$f/README.md"
        frigate gen $f > $f/README.md
    fi
done


if [ ! -d ./docs/charts/bootstrap/Chart-Docs ]; then
  mkdir -p ./docs/charts/bootstrap/Chart-Docs;
fi

for f in ./charts-bootstrap/*; do
    if [ -d "$f" ]; then
        # Will not run if no directories are available
        filename=`basename $f`
        echo "Generating readme for ./docs/charts/bootstrap/Chart-Docs/$filename.md"
        frigate gen $f > ./docs/charts/bootstrap/Chart-Docs/$filename.md
        echo "Generating readme for .$f/README.md"
        frigate gen $f > $f/README.md
    fi
done
