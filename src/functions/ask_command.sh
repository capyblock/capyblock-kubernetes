#!/usr/bin/env bash

ask_command(){
    read -rp "Command: " COMMAND
    echo "$COMMAND"
}