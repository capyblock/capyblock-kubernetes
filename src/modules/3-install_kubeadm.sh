#!/usr/bin/env bash

install_kubeadm(){
  # shellcheck disable=SC2034
  SCRIPT_NAME="Install Kubeadm"
  
  log "Updating the package list"
  sudo apt-get update
  
  local REQUIRED_PACKAGES=(apt-transport-https ca-certificates curl gpg)
  log "Installing the required packages for kubeadm"
  for pkg in "${REQUIRED_PACKAGES[@]}"; do
      if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
          log "Installing package $pkg"
          sudo apt-get install -y "$pkg"
      fi
  done
  
  log "Adding Kubernetes official GPG key"
  sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

  log "Adding Kubernetes repository to package sources"
  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

  log "Updating the package list"
  sudo apt-get update

  log "Installing kubeadm packages"
  sudo apt-get install -y kubeadm kubelet kubectl

  log "Marking kubeadm packages on hold"
  sudo apt-mark hold kubeadm kubelet kubectl

  log "Enabling and starting the kubelet service"
  sudo systemctl enable --now kubelet
}