#!/bin/bash
trap "echo '🛑 Interrupted!'; exit 1" SIGINT SIGTERM

# Loop through all CSV files in the ToDo folder
for CSV_FILE in playlists/ToDo/*.csv; do
  # Check if the file exists
  if [ ! -f "$CSV_FILE" ]; then
    echo "No CSV file found in playlists/ToDo"
    continue
  fi
  
  # Extract the playlist name (without the .csv extension)
  PLAYLIST=$(basename "$CSV_FILE" .csv)
  
  echo "========================================="
  echo "Processing playlist: ${PLAYLIST}"
  echo "========================================="
  
  # Create the destination folder
  mkdir -p "music/${PLAYLIST}"
  
  # Read the CSV and download each song (skipping the first header line)
  tail -n +2 "$CSV_FILE" | while IFS=',' read -r col1 col2 col3 col4 rest; do
    # Remove quotes from columns
    TITRE=$(echo "$col2" | sed 's/"//g')
    ARTISTE=$(echo "$col4" | sed 's/"//g')
    
    # Build the search query
    SEARCH_QUERY="${ARTISTE} ${TITRE}"
    
    # Check if a file with this title already exists (to avoid duplicates and allow resume)
    if find "music/${PLAYLIST}" -type f -iname "*${TITRE}*.mp3" 2>/dev/null | grep -q .; then
      echo "⏭️  Already downloaded: ${SEARCH_QUERY}"
      continue
    fi
    
    echo "⬇️  Downloading: ${SEARCH_QUERY}"

    # Execute yt-dlp in a Docker container to download and convert a YouTube video to MP3 format
    # - Runs in ephemeral mode (--rm) to auto-remove container after execution
    # - Mounts local directory ./music/${PLAYLIST} to /downloads inside container for saving files
    # - Uses jauderho/yt-dlp Docker image
    # - Extracts audio only (-x) and converts to MP3 format (--audio-format mp3)
    # - Saves file with YouTube video title as filename (-o "/downloads/%(title)s.%(ext)s")
    # - Searches and downloads first YouTube result matching the query (ytsearch:${SEARCH_QUERY})
    docker run --rm -v "$(pwd)/music/${PLAYLIST}:/downloads" jauderho/yt-dlp -x --audio-format mp3 -o "/downloads/%(title)s.%(ext)s" "ytsearch:${SEARCH_QUERY}"
  done
  
  # Move the CSV file to the Done folder once finished
  echo "✅ Playlist ${PLAYLIST} completed, moving CSV file to Done"
  mv "$CSV_FILE" "playlists/Done/"
  
done

echo "========================================="
echo "All playlists have been processed!"
echo "========================================="