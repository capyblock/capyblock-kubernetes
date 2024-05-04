#!/usr/bin/env bash

# shellcheck disable=SC2154
help

while true; do
    # shellcheck disable=SC2034
    ask_command
    
    case $COMMAND in
        install) 
            workflow_install
            ;;
        uninstall)
            workflow_uninstall
            ;;
        help)
            workflow_help
            ;;
        *)
            echo "Invalid command"
            ;;
    esac
    
    unset COMMAND
done