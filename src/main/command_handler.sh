#!/usr/bin/env bash

# shellcheck disable=SC2154
help

while true; do
    # shellcheck disable=SC2034
    ask_command
    eval "$COMMAND"
    unset COMMAND
done