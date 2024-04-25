#!/usr/bin/env bash
set -e

BUILD_DIR="../build"
mkdir -p "$BUILD_DIR"
BUILD_FILE="$BUILD_DIR/kubernetes-installer.sh"

# Add #!/usr/bin/env bash to the build file
echo "#!/usr/bin/env bash" > "$BUILD_FILE"

VARIABLES_DIR="variables"
BUILD_BLOCKS_DIR="build_blocks"

read_script(){
    # Check if the file is readable
    if [ -r "$1" ]; then
        echo "Running $1"
        grep -v '^#' "$1" >> "$BUILD_FILE"
    else
        echo "Error: Cannot read $1"
        exit 1
    fi
}

# Iterate over each .sh file in variables directory read all data except comment lines and add to build file
for script in "$VARIABLES_DIR"/*.sh; do
    read_script "$script"
done

# Iterate over each .sh file in build_blocks directory read all data except comment lines and add to build file
for script in "$BUILD_BLOCKS_DIR"/*.sh; do
    read_script "$script"
done