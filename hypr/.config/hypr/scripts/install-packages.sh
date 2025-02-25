#!/bin/bash

# set -x  # Enable script debugging

manifest_file="/home/diego/package_manifest.txt"
packages_to_install=()

if [[ ! -f $manifest_file ]]; then
  echo "Package manifest file not found at $manifest_file."
  exit 1
fi

echo "Reading packages from $manifest_file"

while IFS="|" read -r package description; do
  package=$(echo "$package" | xargs)
  description=$(echo "$description" | xargs)

  echo "Processing package: '$package'"

  if [[ -n "$package" && -n "$description" ]]; then
    # Directly use a prompt in a subshell if needed
    echo "Do you want to install '$package' ($description)? [Y/n]: "
    read -r response < /dev/tty
    response=${response:-Y}
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
      packages_to_install+=("$package")
      echo "Added '$package' to install list"
    else
      echo "Skipped '$package'"
    fi
  else
    echo "Empty package or description found, skipping..."
  fi
done < "$manifest_file"

if [ "${#packages_to_install[@]}" -gt 0 ]; then
  echo "Installing packages: ${packages_to_install[*]}"
  yay -S "${packages_to_install[@]}"
else
  echo "No packages selected for installation."
fi
