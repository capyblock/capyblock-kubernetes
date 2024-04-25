#!/usr/bin/env bash

print_cri_list(){
    echo "1. Containerd (Recommended)"
    echo "2. CRI-O (NOT IMPLEMENTED YET)"
    echo "3. Docker (NOT IMPLEMENTED YET)"
    echo "4. Mirantis Container Runtime (NOT IMPLEMENTED YET)"
}

cri_selector(){
    local SELECTED_CRI
    
    # run print_cri_list function
    print_cri_list
    
    SELECTED_CRI=$(ask_selection)
    
    case $SELECTED_CRI in
        1) echo "install_cri_containerd" ;;
        2) echo "install_cri_cri-o" ;;
        3) echo "install_cri_docker" ;;
        4) echo "install_mirantis_cri" ;;
        *) echo "install_cri_containerd" ;;
    esac
}