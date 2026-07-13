# Innioasis Y1 Rockbox Playlist Generator

A lightweight Bash script to automatically generate Rockbox-compatible `.m3u` playlists for the **Innioasis Y1** digital audio player from your Linux PC (like a Steam Deck). 

Just run it—the script auto-detects your Y1 and makes a playlist `.m3u` file for all the folders inside your `Music` directory. It can also be modified easily for other audio formats.

## Features

* **Zero Configuration:** Automatically detects your Y1 device via its `.rockbox` folder.
* **Smart Organization:** Creates an `.m3u` playlist for each music subfolder and saves them directly to your card's `Playlists` directory.
* **Innioasis Y1 Path Fix:** Formats internal file paths with the exact prefix required by the Y1 (`/sdcard/Music/...`) so songs actually play and display cover art.

## Setup & Execution

1. Save the script as `autom3u.sh` on your Linux PC.
2. Connect your Innioasis Y1 to your computer via USB.
3. Open a terminal and run the following commands to give the script permission and run it:

```bash
chmod +x autom3u.sh
./autom3u.sh

Modifying File Formats

If you need to add or change supported file types, look inside the script for the find command section. You can add or modify formats by following this pattern:
Bash

-iname "*.mp3" -o -iname "*.flac" -o -iname "*.your_format"
