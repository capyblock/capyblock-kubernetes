#!/usr/bin/env bash

prepare_installation(){
  # shellcheck disable=SC2034
  SCRIPT_NAME="Prepare Installation"
  
  log "Updating the package list"
  sudo apt-get update
  
  log "Upgrading installed packages"
  sudo apt-get upgrade -y
}