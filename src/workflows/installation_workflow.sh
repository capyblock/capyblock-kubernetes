#!/usr/bin/env bash

install(){
  prepare_installation
  
  cri_selector
  eval "$CRI_SELECTION"
  
  install_kubeadm
  
  initialize_kubadm
}
