#!/bin/bash

# spotdl.sh - Helper script pour lancer spotdl en container
# Usage: ./spotdl.sh <URL playlist ou track Spotify>

# Dossier où seront téléchargées les musiques
MUSIC_DIR="${MUSIC_DIR:-$(pwd)/music}"

# Créer le dossier si nécessaire
mkdir -p "$MUSIC_DIR"

# Lancer le container
docker run --rm -it \
    -v "$MUSIC_DIR":/music \
    spotdl "$@"