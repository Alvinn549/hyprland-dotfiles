#!/bin/bash

# Paths
CONFIG_DIR="$HOME/.config"
REPO_DIR="$HOME/Projects/hyprland-dots/.config"

# Config directories to sync
DIRECTORIES=("dunst" "hypr" "kitty" "tofi" "waybar" "wlogout")

sync_directory() {
  local source_dir="$1"
  local target_dir="$2"

  echo "Syncing $source_dir to $target_dir..."

  # Ensure target directory exists
  mkdir -p "$target_dir"

  # Sync files (delete removed files, copy new and modified ones)
  rsync -av --delete "$source_dir/" "$target_dir/"

  echo "$(basename "$source_dir") synced successfully."
}

sync_file() {
  local source_file="$1"
  local target_file="$2"

  echo "Syncing $source_file to $target_file..."

  # Ensure the target directory exists
  mkdir -p "$(dirname "$target_file")"

  # Sync the file
  rsync -av "$source_file" "$target_file"

  echo "$(basename "$source_file") synced successfully."
}

echo "Starting config sync..."

for dir in "${DIRECTORIES[@]}"; do
  sync_directory "$CONFIG_DIR/$dir" "$REPO_DIR/$dir"
done
