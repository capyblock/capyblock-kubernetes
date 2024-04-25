#!/usr/bin/env bash
set -e

BUILD_DIR="../build"
mkdir -p "$BUILD_DIR"
BUILD_FULL_FILE="$BUILD_DIR/kubernetes-installer.sh"

# Add #!/usr/bin/env bash to the build file
echo "#!/usr/bin/env bash" > "$BUILD_FULL_FILE"

VARIABLES_DIR="variables"
FUNCTIONS_DIR="functions"
BUILD_BLOCKS_DIR="build_blocks"

read_script(){
    # Check if the file is readable
    if [ -r "$1" ]; then
        echo "Running $1"
        grep -v '^#' "$1" >> "$BUILD_FULL_FILE"
    else
        echo "Error: Cannot read $1"
        exit 1
    fi
}

# Read all data from the variable files and add to build file
for script in "$VARIABLES_DIR"/*.sh; do
    read_script "$script"
done

# Read all data from the function files and add to build file
for script in "$FUNCTIONS_DIR"/*.sh; do
    read_script "$script"
done

# Read all data from the build block files and add to build file
for script in "$BUILD_BLOCKS_DIR"/*.sh; do
    read_script "$script"
done

# Read all data from the workflow files and add to build file
for script in "$WORKFLOWS_DIR"/*.sh; do
    read_script "$script"
done

# Add the command handler to the build file
read_script "command_handler.sh"
