#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load environment variables from .env file if it exists
if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
fi

# Directory containing your wallpapers (default if not set in .env)
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures}"
# Output XML file (default if not set in .env)
OUTPUT="${OUTPUT:-$HOME/Pictures/wallpaper-slideshow.xml}"
# Duration for each image in seconds (default if not set in .env)
DURATION="${DURATION:-300}"
# Transition time in seconds (default if not set in .env)
TRANSITION="${TRANSITION:-5}"

# Start XML
cat > "$OUTPUT" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<background>
    <starttime>
        <year>$(date +%Y)</year>
        <month>$(date +%m)</month>
        <day>$(date +%d)</day>
        <hour>0</hour>
        <minute>0</minute>
        <second>0</second>
    </starttime>
EOF

# Get all images
mapfile -t images < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort)

# Add each image
for ((i=0; i<${#images[@]}; i++)); do
    current="${images[$i]}"
    next="${images[$(( (i+1) % ${#images[@]} ))]}"
    
    echo "    <static>
        <duration>$DURATION.0</duration>
        <file>$current</file>
    </static>
    
    <transition>
        <duration>$TRANSITION.0</duration>
        <from>$current</from>
        <to>$next</to>
    </transition>" >> "$OUTPUT"
done

echo "</background>" >> "$OUTPUT"

echo "Slideshow XML created at: $OUTPUT"

# Set the background for both light and dark mode
gsettings set org.gnome.desktop.background picture-uri "file://$OUTPUT"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$OUTPUT"

echo "Background slideshow has been applied for both light and dark mode"