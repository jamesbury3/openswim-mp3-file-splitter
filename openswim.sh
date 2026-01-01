#!/bin/sh

echo "Splitting MP3 Files in the input folder..."
sh split_mp3_file.sh

echo ""
printf "Run copy_to_openswim.sh? (y/n): "
read response
if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
    sh copy_to_openswim.sh
fi
