#!/usr/bin/env bash

cri_selector(){
    local cri
    
    cri=$(dialog --clear --stdout \
        --title "Container Runtime Interface" \
        --menu "Choose the container runtime interface:" 0 0 0 \
        "1" "Containerd (Recommended)" \
        "2" "CRI-O (NOT IMPLEMENTED YET)" \
        "3" "Docker (NOT IMPLEMENTED YET)" \
        "4" "Mirantis Container Runtime (NOT IMPLEMENTED YET)" \
    )
    
    case $cri in
        1) echo "install_cri_containerd" ;;
        2) echo "install_cri_cri-o" ;;
        3) echo "install_cri_docker" ;;
        4) echo "install_mirantis_cri" ;;
        *) echo "install_cri_containerd" ;;
    esac
}