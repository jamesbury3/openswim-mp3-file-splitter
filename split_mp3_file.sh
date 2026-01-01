#!/bin/sh

tempo="1.0"
segment_length_s=60

for source_file in input/*.mp3; do
    # Skip if no mp3 files found
    [ -e "$source_file" ] || continue

    source_basename=$(basename "$source_file")
    base_name="${source_basename%.mp3}"
    segment_suffix="-%03d.mp3"
    output_dir="output/$base_name"
    output_pattern="$output_dir/$base_name$segment_suffix"
    echo "source_file=$source_file, base_name=$base_name, segment_suffix=$segment_suffix, output_dir=$output_dir, output_pattern=$output_pattern, tempo=$tempo, segment_length_s=$segment_length_s"

    mkdir -p "$output_dir"
    ffmpeg -i "$source_file" -map 0:a -filter:a "atempo=$tempo" -f segment -segment_time "$segment_length_s" -segment_start_number 1 -c:a libmp3lame -b:a 192k "$output_pattern"
done
