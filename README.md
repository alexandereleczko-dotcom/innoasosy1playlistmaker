# Innioasis Y1 Rockbox Playlist Generator

A lightweight Bash script to automatically generate Rockbox-compatible `.m3u` playlists for the **Innioasis Y1** digital audio player from your Linux PC (like a Steam Deck). 

The script automatically scans for your connected device, reads the subfolders inside your `Music` directory, and builds flat playlist files optimized for the Y1's unique Android-under-the-hood storage pathing (`/sdcard/Music/...`).

## Features

* **Zero Configuration:** Just run it—the script auto-detects your Y1 mount point across common Linux directories (`/run/media/`, `/media/`, etc.).
* **Smart Folder Mapping:** Creates a dedicated `.m3u` playlist named after each folder in your `Music` directory. Nested subfolders are flattened (e.g., `Artist/Album` becomes `Artist-Album.m3u`).
* **Innioasis Y1 Optimized:** Forces the correct absolute path prefix (`/sdcard/`) and strips away Windows carriage returns (`CRLF`) to ensure Rockbox reads, plays, and displays album art without freezing.
* **Extensible Format Support:** Handles 15+ high-fidelity and compressed audio extensions out of the box.

## Supported Audio Formats

The script natively indexes the following formats:
* `.mp3`, `.flac`, `.m4a`, `.ogg`, `.wav`, `.aac`, `.opus`
* `.alac`, `.aiff`, `.wma`, `.ape`, `.wv`, `.mpc`, `.dsf`, `.dsd`, `.tta`

*Note: If you need to add or remove formats, you can easily modify the file extension block inside the script.*

## How to Use

### 1. Prerequisite
Ensure your Innioasis Y1 has a `.rockbox` folder on the root of its storage card (this is how the script finds your device).

### 2. Download and Setup
Clone or copy the script file (`autom3u.sh`) to your computer. Open your terminal, navigate to the folder where you saved it, and give it execute permissions:

```bash
chmod +x autom3u.sh

3. Run the Script

Connect your Innioasis Y1 to your computer via USB in storage transfer mode, then execute the script:
Bash

./autom3u.sh

Example Terminal Output
Plaintext

Found Rockbox device at: /run/media/deck/B7F7-07FA
Targeting Music directory: /run/media/deck/B7F7-07FA/Music
Outputting playlists to: /run/media/deck/B7F7-07FA/Playlists

 -> Created Y1 Playlist: Asphalt Legends Soundtrack.m3u
 -> Created Y1 Playlist: Indie Rock.m3u
 -> Created Y1 Playlist: Jazz.m3u

Done! Run this, safely eject your deck, and your tracks will play instantly.

How It Works Under the Hood

Because the Innioasis Y1 runs on an embedded Android environment hosting Rockbox, typical absolute paths like /Music/Song.mp3 fail to play. This script transforms local paths into the exact virtual Android layout the player demands:
Plaintext

# Internal playlist structure outputted by the script:
/sdcard/Music/Jazz/Take Five.mp3
/sdcard/Music/Indie Rock/Sick Boi.mp3
