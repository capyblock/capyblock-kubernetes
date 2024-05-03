#!/usr/bin/env bash
set -e

# make bash-merger executable
chmod +x ../bash-merger/src/merge.sh

# execute merge.sh
../bash-merger/src/merge.sh -r . -c merge-config.sh

