#!/usr/bin/env bash

workflow_install(){
  prepare_installation
  
  cri_selector
  eval "$CRI_SELECTION"
  
  install_kubeadm
  
  initialize_kubadm
}
