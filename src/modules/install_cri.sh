#!/usr/bin/env bash

install_cri_containerd(){
  # shellcheck disable=SC2034
  SCRIPT_NAME="Install Containerd"
  
  function_update_packages
  function_upgrade_packages
  
  local OLD_PACKAGES=(docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc)
  
  log "Uninstalling old versions of Docker and related packages"
  
  for pkg in "${OLD_PACKAGES[@]}"; do
      if dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
          read -p "Package $pkg is installed. Do you want to remove it? (y/n) " -n 1 -r
          echo
          if [[ $REPLY =~ ^[Yy]$ ]]; then
              log "Removing package $pkg"
              sudo apt-get remove -y "$pkg"
          fi
      fi
  done
  
  function_update_packages
  
  local REQUIRED_PACKAGES=(ca-certificates curl software-properties-common)
  log "Installing the required packages for Docker and containerd"
  for pkg in "${REQUIRED_PACKAGES[@]}"; do
      if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
          log "Installing package $pkg"
          sudo apt-get install -y "$pkg"
      fi
  done
  
  log "Configuring sysctl settings for containerd"
  echo "net.ipv4.ip_forward = 1
  net.bridge.bridge-nf-call-iptables = 1
  net.bridge.bridge-nf-call-ip6tables = 1" | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
  
  log "Applying sysctl settings"
  sudo sysctl --system
  
  log "Adding Docker's official GPG key"
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  
  log "Adding Docker's repository"
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  function_update_packages
  
  log "Installing Docker and containerd"
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  
  local NEW_PACKAGES=(docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin)
  log "Installing the Docker packages"
  for pkg in "${NEW_PACKAGES[@]}"; do
      if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q "ok installed"; then
          log "Installing package $pkg"
          sudo apt-get install -y "$pkg"
      fi
  done
  
  log "Marking Docker on hold"
  sudo apt-mark hold docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  
  log "Creating containerd configuration file"
  sudo mkdir -p /etc/containerd
  sudo containerd config default | sudo tee /etc/containerd/config.toml
  
  log "settings containerd cgroup driver to systemd"
  sudo sed -i 's/            SystemdCgroup = false/            SystemdCgroup = true/' /etc/containerd/config.toml
  
  log "Restarting containerd"
  sudo systemctl restart containerd
}