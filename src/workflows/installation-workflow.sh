#!/usr/bin/env bash

# run cri_selector and get output in a variable
install(){
  prepare_installation
  
  local install_cri
  # shellcheck disable=SC2034
  install_cri=$(cri_selector)
  install_cri
  
  install_kubeadm
  
  initialize_kubadm
}
