#!/bin/bash

# Define the manifest file
MANIFEST_FILE="package_manifest.txt"

# Clear the manifest file
> "$MANIFEST_FILE"

# Get the list of installed packages with descriptions
PACKAGES=$(for line in "$(pacman -Qqe)"; do pacman -Qi $(echo "$line") ; done | \
    perl -pe 's/ +/ /gm' | \
    perl -pe 's/^(Groups +: )(.*)/$1($2)/gm' | \
    perl -0777 -pe 's/^Name : (.*)\nVersion :(.*)\nDescription : ((?!None).*)?(?:.|\n)*?Groups :((?! \(None\)$)( )?.*)?(?:.|\n(?!Name))+/$1$2$4\n    $3/gm' | \
    grep -A1 --color -P "^[^\s]+")

# Convert to an array
IFS=$'\n' read -d '' -r -a PACKAGE_ARRAY <<< "$PACKAGES"

# Iterate over the packages
for ((i = 0; i < ${#PACKAGE_ARRAY[@]}; i+=2)); do
    PACKAGE_LINE="${PACKAGE_ARRAY[i]}"
    DESCRIPTION_LINE="${PACKAGE_ARRAY[i+1]}"
    
    # Extract package name
    PACKAGE_NAME=$(echo "$PACKAGE_LINE" | awk '{print $1}')
    
    # Display the package info
    echo -e "\nPackage: $PACKAGE_NAME"
    echo -e "Description: ${DESCRIPTION_LINE:4}"
    
    # Ask the user if they want to add it to the manifest
    read -p "Add this package to the manifest? (Y/n): " choice
    choice=${choice:-Y}
    case "$choice" in
        y|Y) echo "$PACKAGE_NAME | ${DESCRIPTION_LINE:4}" >> "$MANIFEST_FILE" ;;
        *) echo "Skipping $PACKAGE_NAME" ;;
    esac

done

echo -e "\nManifest file saved: $MANIFEST_FILE"
