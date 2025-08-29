#!/bin/bash

MYHOME_DIR="/home/serverhustle/gemini/home/myhome_link"

echo "--- Script Manager ---"
echo "Listing executable scripts in $MYHOME_DIR:"

# Check if the directory exists
if [ ! -d "$MYHOME_DIR" ]; then
    echo "Error: Directory $MYHOME_DIR not found. Please ensure it's correctly linked."
    exit 1
fi

# Find all .sh and .py files, make them executable if not already
find "$MYHOME_DIR" -maxdepth 1 -type f \( -name "*.sh" -o -name "*.py" \) -print0 | while IFS= read -r -d $'\0' script; do
    if [ ! -x "$script" ]; then
        echo "Making script executable: $(basename "$script")"
        chmod +x "$script"
    fi
done

# List scripts with numbers
scripts=()
while IFS= read -r -d $'\0' script; do
    scripts+=("$script")
done < <(find "$MYHOME_DIR" -maxdepth 1 -type f \( -name "*.sh" -o -name "*.py" \) -executable -print0 | sort -z)

if [ ${#scripts[@]} -eq 0 ]; then
    echo "No executable .sh or .py scripts found in $MYHOME_DIR."
    exit 0
fi

for i in "${!scripts[@]}"; do
    echo "$((i+1))) $(basename "${scripts[$i]}")"
done

echo ""
read -p "Enter the number of the script to run (or 0 to exit): " choice

if [ "$choice" -eq 0 ]; then
    echo "Exiting Script Manager."
    exit 0
elif [ "$choice" -gt 0 ] && [ "$choice" -le ${#scripts[@]} ]; then
    selected_script="${scripts[$((choice-1))]}"
    echo "Running: $(basename "$selected_script")"
    "$selected_script" # Execute the script
else
    echo "Invalid choice. Exiting."
    exit 1
fi

echo "Script execution complete."
