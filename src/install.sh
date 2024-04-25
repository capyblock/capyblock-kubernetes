#!/usr/bin/env bash
set -e

# Directory containing the installation scripts
INSTALL_DIR="installation"

# Iterate over each .sh file in the installation directory
for script in "$INSTALL_DIR"/*.sh; do
    # Check if the file is readable
    if [ -r "$script" ]; then
        echo "Running $script"
        if bash "$script"; then
            echo "$script completed successfully"
        else
            echo "Error: $script failed"
            exit 1
        fi
    else
        echo "Error: Cannot read $script"
        exit 1
    fi
done

echo "Installation completed successfully"