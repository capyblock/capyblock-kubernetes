#!/usr/bin/env bash

ask_command() {
    read -rp "Enter your choice: " COMMAND
    echo "$COMMAND"
}