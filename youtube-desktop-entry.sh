#!/bin/bash
# Create youtube desktop entry

if [ ! -d $HOME/.icons ]; then
	mkdir $HOME/.icons
fi
#LOGO_DIR=/usr/share/icons/hicolor/256x256/apps
LOGO_DIR=$HOME/.icons

DESKTOP_ENTRY_DIR=/usr/share/applications
PNG_URL=https://www.sfcg.org/wp-content/uploads/2016/11/youtube-flat.png

# Download logo
if [ ! -f $LOGO_DIR/youtube-logo.png ]; then
	wget --output-document=$LOGO_DIR/youtube-logo.png $PNG_URL
fi

# Create desktop entry
sudo touch $DESKTOP_ENTRY_DIR/youtube.desktop

sudo cat << EOF > $DESKTOP_ENTRY_DIR/youtube.desktop
[Desktop Entry]
Name=Youtube
Exec=/usr/bin/google-chrome-stable --app="https://www.youtube.com"
Icon=$LOGO_DIR/youtube-logo.png
StartupNotify=true
Terminal=false
Type=Application
Categories=Network;Videos;
EOF

echo "Finished"
