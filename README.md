# GNOME Desktop Slideshow Generator

A simple bash script to create an XML slideshow file for GNOME desktop wallpapers that automatically cycles through your image collection.

## Features

- Automatically scans a directory for all JPG and PNG images
- Creates a GNOME-compatible XML slideshow file
- Configurable image duration and transition times
- Applies to both light and dark mode backgrounds
- Supports environment-based configuration

## Setup

1. Clone or download this repository
2. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
3. Edit `.env` to customize your settings:
   - `WALLPAPER_DIR`: Directory containing your wallpapers (default: `~/Pictures`)
   - `OUTPUT`: Path for the generated XML file (default: `~/Pictures/wallpaper-slideshow.xml`)
   - `DURATION`: How long each image displays in seconds (default: 300)
   - `TRANSITION`: Transition time between images in seconds (default: 5)

## Usage

Run the script to generate the slideshow and apply it:

```bash
./generate-slideshow.sh
```

The script will:
1. Scan your wallpaper directory for images
2. Generate an XML slideshow file
3. Set it as your GNOME desktop background for both light and dark modes

## Manually Setting the Wallpaper

If you need to manually set the wallpaper slideshow:

```bash
gsettings set org.gnome.desktop.background picture-uri "file:///path/to/wallpaper-slideshow.xml"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///path/to/wallpaper-slideshow.xml"
```

## Restarting GNOME Shell

If the wallpapers are not rotating at the expected interval or the slideshow doesn't appear to be working, you may need to restart GNOME Shell:

### On X11
Press `Alt+F2`, type `r`, and press `Enter`

### On Wayland
You'll need to log out and log back in

## Troubleshooting

**Wallpapers rotating too quickly/slowly:**
- Edit your `.env` file and adjust the `DURATION` value
- Run `./generate-slideshow.sh` again to regenerate the XML with new timing
- Restart GNOME Shell (see above)

**No images found:**
- Verify that `WALLPAPER_DIR` in your `.env` file points to the correct directory
- Ensure the directory contains JPG or PNG files
- Check file permissions

**Changes not taking effect:**
- Make sure you restart GNOME Shell after regenerating the slideshow
- Verify the XML file was created at the expected location
