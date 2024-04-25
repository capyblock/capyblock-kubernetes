#!/usr/bin/env bash

install(){
  prepare_installation
  
  local INSTALL_CRI_FUNC
  # shellcheck disable=SC2034
  INSTALL_CRI_FUNC=$(cri_selector)
  eval "$INSTALL_CRI_FUNC"
  
  install_kubeadm
  
  initialize_kubadm
}
