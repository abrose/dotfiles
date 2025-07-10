#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

# Target directory
TARGET_DIR="$HOME/.claude"

echo "Installing Claude configuration files..."
echo "Source: $SCRIPT_DIR"
echo "Target: $TARGET_DIR"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Copy all files and directories except this script itself
for item in "$SCRIPT_DIR"/*; do
    if [ -e "$item" ]; then
        item_name="$(basename "$item")"
        if [ "$item_name" != "$SCRIPT_NAME" ]; then
            echo "Copying: $item_name"
            cp -r "$item" "$TARGET_DIR/"
        fi
    fi
done

# Also copy hidden files (dotfiles)
for item in "$SCRIPT_DIR"/.*; do
    if [ -e "$item" ]; then
        item_name="$(basename "$item")"
        # Skip . and .. directories
        if [ "$item_name" != "." ] && [ "$item_name" != ".." ]; then
            echo "Copying: $item_name"
            cp -r "$item" "$TARGET_DIR/"
        fi
    fi
done

echo "Installation complete!"
echo "Claude configuration files have been copied to $TARGET_DIR"
