#!/usr/bin/env bash

# shellcheck disable=SC2034
OUT_DIR="../build"

# shellcheck disable=SC2034
OUT_FILE_NAME="kubernetes_installer.sh"

# shellcheck disable=SC2034
SCRIPT_DIRECTORIES=(
  "variables"
  "functions"
  "build_blocks"
  "selectors"
  "workflows"
)