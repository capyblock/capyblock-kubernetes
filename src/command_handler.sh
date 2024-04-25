#!/usr/bin/env bash

# shellcheck disable=SC2154
help

while true; do
    # shellcheck disable=SC2034
    COMMAND=$(ask_command)
    eval "$COMMAND"
done