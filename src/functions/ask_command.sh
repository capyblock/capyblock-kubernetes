#!/usr/bin/env bash

ask_command(){
  printf "Command: "
  # shellcheck disable=SC2034
  read -r COMMAND
}