#!/usr/bin/env bash

# shellcheck disable=SC2154
$help

while true; do
    read -rp "Enter command: " command
    $command
done