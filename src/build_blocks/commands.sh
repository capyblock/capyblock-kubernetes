#!/usr/bin/env bash

# shellcheck disable=SC2034
COMMANDS=(
    "install"
    "uninstall"
    "upgrade"
    "help"
)
  
help(){
    echo "Commands:"
    echo "  install   Install Kubernetes"
    echo "  uninstall Uninstall Kubernetes"
    echo "  upgrade   Upgrade Kubernetes"
    echo "  help      Display this help message"
}