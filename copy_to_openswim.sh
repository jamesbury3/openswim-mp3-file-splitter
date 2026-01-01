#!/bin/sh

source ./config.sh

output_base="output"

# Check if OpenSwim volume is mounted
if [ ! -d "$target_base" ]; then
    echo "Error: OpenSwim volume not found at $target_base"
    echo "Please make sure the device is connected and mounted."
    exit 1
fi

# Find all subdirectories in output/ that contain mp3 files
for source_dir in "$output_base"/*/; do
    # Skip if directory doesn't exist
    [ -d "$source_dir" ] || continue

    # Get the folder name
    folder_name=$(basename "$source_dir")

    # Skip if no mp3 files in this directory
    if ! ls "$source_dir"*.mp3 >/dev/null 2>&1; then
        continue
    fi

    target_dir="$target_base/$folder_name"

    echo "Processing: $folder_name"

    # Get all mp3 files and sort them alphabetically
    mp3_files=$(ls "$source_dir"*.mp3 | sort)

    total=$(echo "$mp3_files" | wc -l | tr -d ' ')
    current=0
    group_size=20

    # Copy files one by one in alphabetical order, grouping into subdirectories
    for file in $mp3_files; do
        current=$((current + 1))
        filename=$(basename "$file")

        # Calculate which group this file belongs to
        group_num=$(( (current - 1) / group_size + 1 ))
        current_target_dir="$target_dir/$group_num"

        # Create target subdirectory if it doesn't exist
        mkdir -p "$current_target_dir"

        echo "  [$current/$total] Copying $filename to group $group_num..."
        cp "$file" "$current_target_dir/"

        # Small delay to ensure different timestamps
        sleep 0.1
    done

    total_groups=$(( (total - 1) / group_size + 1 ))
    echo "  Completed: $folder_name ($total files in $total_groups groups)"
    echo ""
done

echo "All files copied to OpenSwim!"
