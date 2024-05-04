#!/usr/bin/env bash

print_cri_list(){
    echo "1. Containerd (Recommended)"
    echo "2. CRI-O (NOT IMPLEMENTED YET)"
    echo "3. Docker (NOT IMPLEMENTED YET)"
    echo "4. Mirantis Container Runtime (NOT IMPLEMENTED YET)"
}

cri_selector(){    
    # run print_cri_list function
    print_cri_list
    
    ask_selection
    
    # shellcheck disable=SC2034
    CRI_SELECTION=$SELECTION
    
    unset SELECTION
    
    case $CRI_SELECTION in
        1) CRI_SELECTION="install_cri_containerd" ;;
        2) CRI_SELECTION="install_cri_cri-o" ;;
        3) CRI_SELECTION="install_cri_docker" ;;
        4) CRI_SELECTION="install_mirantis_cri" ;;
        *) CRI_SELECTION="install_cri_containerd" ;;
    esac
}