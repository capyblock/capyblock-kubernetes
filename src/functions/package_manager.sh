#!/usr/bin/env bash

function_update_packages(){
  log "Updating the package list"
  sudo apt-get update
}

function_upgrade_packages(){
  log "Upgrading installed packages"
  sudo apt-get upgrade -y
}