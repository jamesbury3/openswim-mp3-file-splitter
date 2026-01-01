# OpenSwim MP3 Splitter

This project was created to split up long MP3 files such as audiobooks and podcasts into smaller tracks which can be played on MP3 players such as the Shokz OpenSwim headphones.

## Prerequisites

- Install [ffmpeg](https://ffmpeg.org/):

## Configuration

Edit `split_mp3_file.sh` to adjust these settings:

- `tempo="1.0"` - Playback speed multiplier (e.g., "1.5" for 1.5x speed, "2.0" for 2x)
- `segment_length_s=60` - Segment length in seconds (default: 60 seconds)

Edit `copy_to_openswim.sh`:

- Set `target_base` to be the directory of your MP3 player when it is plugged in. It is currently set to the default value when using MacOS

## Usage

### Step 1: Add your MP3 files

Place your MP3 files in the `input/` directory:

```
input/
  your-audiobook.mp3
  podcast-episode.mp3
  ...
```

### Step 2: Run the main script

```bash
./openswim.sh
```

The main script will:
1. Create split versions of all MP3 files in the `input/` directory
2. Create subdirectories in `output/` named after each source file
3. Generate speed-adjusted segments with sequential numbering (001.mp3, 002.mp3, etc.)
4. Prompt you to run the copy script when done

Processed files will be created in subdirectories:
```
output/
  your-audiobook/
    your-audiobook-001.mp3
    your-audiobook-002.mp3
    your-audiobook-003.mp3
    ...
  podcast-episode/
    podcast-episode-001.mp3
    podcast-episode-002.mp3
    ...
```

### Step 3: Copy to device

When prompted (or run manually), the copy script will transfer files to your device:

```bash
./copy_to_openswim.sh
```

This will:
1. Find all subdirectories in `output/` containing MP3 files
2. Copy files to `/Volumes/OpenSwim/` in alphabetical order
3. Organize files into groups of 20 per subdirectory (e.g., `/Volumes/OpenSwim/your-audiobook/1/`, `/Volumes/OpenSwim/your-audiobook/2/`, etc.)
4. Add small delays between copies to preserve playback order

### Credit

- This project was inspired by this gist https://gist.github.com/AlexKrupa/0a4eff86435152cf3dd41c32eca56a89.
