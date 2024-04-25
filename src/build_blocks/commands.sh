#!/usr/bin/env bash

# shellcheck disable=SC2034
COMMANDS=(
    "install"
    "uninstall"
    "help"
)
  
help(){
    echo "Commands:"
    echo "  install   Install Kubernetes"
    echo "  uninstall Uninstall Kubernetes"
    echo "  help      Display this help message"
}