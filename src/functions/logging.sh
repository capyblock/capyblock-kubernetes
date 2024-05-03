#!/usr/bin/env bash

log(){
    printf "%${TERMINAL_WIDTH}s\n" | tr ' ' '-'
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$SCRIPT_NAME] [INFO] - $1"
    printf "%${TERMINAL_WIDTH}s\n" | tr ' ' '-'
}