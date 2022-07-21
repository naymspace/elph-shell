#!/bin/sh
npx --yes chokidar-cli ../elph/ -c "rsync -r --exclude=deps --exclude=_build --exclude=mix.lock --delete ../elph/* deps/elph/" --initial
