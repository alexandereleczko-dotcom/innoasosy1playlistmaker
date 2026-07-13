#!/bin/bash

# find device with a .rockbox folder
find_rockbox_device() {
    for mount_point in /media/*/* /run/media/*/* /mnt/* /Volumes/*; do
        [ -d "$mount_point" ] || continue

        if [ -d "$mount_point/.rockbox" ]; then
            echo "$mount_point"
            return 0
        fi
    done

    echo "Error: Could not find device with .rockbox folder" >&2
    return 1
}

# Find the mounted device root
DEVICE_ROOT=$(find_rockbox_device)
if [ $? -ne 0 ]; then
    exit 1
fi

MUSIC_DIR="$DEVICE_ROOT/Music"
PLAYLISTS_DIR="$DEVICE_ROOT/Playlists"

echo "Found Innioasis Y1 at: $DEVICE_ROOT" >&2
echo "Targeting Music directory: $MUSIC_DIR" >&2
echo "Outputting playlists to: $PLAYLISTS_DIR" >&2
echo "" >&2

mkdir -p "$PLAYLISTS_DIR"

# Loop through every single subfolder inside the Music directory
find "$MUSIC_DIR" -type d | while read -r sub_dir; do

    [ "$sub_dir" = "$MUSIC_DIR" ] && continue

    relative_folder="${sub_dir#$MUSIC_DIR/}"
    playlist_filename=$(echo "$relative_folder" | tr '/' '-')
    playlist_file="$PLAYLISTS_DIR/${playlist_filename}.m3u"

    true > "$playlist_file"

    # Find all music files in this specific directory
    find "$sub_dir" -maxdepth 1 -type f \( \
        -iname "*.mp3" -o \
        -iname "*.flac" -o \
        -iname "*.ogg" -o \
        -iname "*.wav" -o \
        -iname "*.m4a" -o \
        -iname "*.aac" -o \
        -iname "*.alac" -o \
        -iname "*.aiff" -o \
        -iname "*.opus" -o \
        -iname "*.wma" -o \
        -iname "*.ape" -o \
        -iname "*.wv" -o \
        -iname "*.mpc" -o \
        -iname "*.dsf" -o \
        -iname "*.dsd" -o \
        -iname "*.tta" \
    \) | sort | while read -r track; do

        # Strip away your host computer mount point (e.g. /run/media/deck/B7F7-07FA)
        local_relative_path="${track#$DEVICE_ROOT/}"

        # INNIOASIS Y1 CRITICAL PATH FIX:
        # Maps line output exactly to: /sdcard/Music/YourFolder/Song.mp3
        printf "/sdcard/%s\n" "$local_relative_path" | tr -d '\r' >> "$playlist_file"
    done

    if [ ! -s "$playlist_file" ]; then
        rm "$playlist_file"
    else
        echo " -> Created Y1 Playlist: ${playlist_filename}.m3u" >&2
    fi
done

echo "" >&2
echo "Done! Run this, safely eject your deck, and your tracks will play instantly." >&2
