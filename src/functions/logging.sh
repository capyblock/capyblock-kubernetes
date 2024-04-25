#!/usr/bin/env bash

log(){
    printf "%${TERMINAL_WIDTH}s\n" | tr ' ' '-' | tee -a "$LOG_FILE"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$SCRIPT_NAME] [INFO] - $1" | tee -a "$LOG_FILE"
    printf "%${TERMINAL_WIDTH}s\n" | tr ' ' '-' | tee -a "$LOG_FILE"
}