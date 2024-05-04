#!/usr/bin/env bash

initialize_kubeadm(){
  # shellcheck disable=SC2034
  SCRIPT_NAME="Initialize Kubeadm"
  
  log "Initializing kubeadm cluster"
  sudo kubeadm init
  
  log "Configuring kubectl for the current user"
  mkdir -p "$HOME/.kube"
  sudo cp -i /etc/kubernetes/admin.conf "$HOME/.kube/config"
  sudo chown "$(id -u)":"$(id -g)" "$HOME/.kube/config"
  
  log "Configuring kubectl autocompletion"
  echo 'source <(kubectl completion bash)' >> "$HOME/.bashrc"
  
  log "Installing Calico pod network add-on"
  kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
  
  log "Checking Calico pod status"
  kubectl get pods -n kube-system
  
  log "Tainting the master node"
  kubectl taint nodes --all node-role.kubernetes.io/master-
}