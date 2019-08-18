#!/bin/bash

# Script for installing and configuring things after linux installation
# It requires sudo privileges

# Initialize variables
DOWNLOADS=$HOME/Downloads
DEFAULT_APPLICATIONS_FILE=/etc/gnome/defaults.list
BACKGROUND=/usr/share/backgrounds/pop/kate-hazen-unleash-your-robot.png
SCREENSAVER=/usr/share/backgrounds/pop/nick-nazzaro-ice-cave.png

# Download and install google-chrome --------------------------------------------------------------
wget --output-document=$DOWNLOADS/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install $DOWNLOADS/google-chrome.deb -y
rm $DOWNLOADS/google-chrome.deb

# Install vlc -------------------------------------------------------------------------------------
sudo apt install vlc -y

# Install vscode
sudo apt install code -y

# Configure default applications ------------------------------------------------------------------
sudo sed -i 's/firefox.desktop/google-chrome.desktop/g' $DEFAULT_APPLICATIONS_FILE
sudo sed -i 's/org.gnome.Totem.desktop/vlc.desktop/g' $DEFAULT_APPLICATIONS_FILE

# Configure favorite applications -----------------------------------------------------------------
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Calculator.desktop']"

# Set background
if [ -f $BACKGROUND ]; then
	echo "Setting background image"
	gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND"
fi
if [ -f $SCREENSAVER ]; then
	echo "Setting screen-saver image"
	gsettings set org.gnome.desktop.screensaver picture-uri "file://$SCREENSAVER"
fi


# Configure keyboard shortcuts --------------------------------------------------------------------
# Attach window to sides or corners
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-sw "['<Alt>KP_1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-side-s "['<Alt>KP_2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-se "['<Alt>KP_3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-side-w "['<Alt>KP_4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Alt>KP_5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-side-e "['<Alt>KP_6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-nw "['<Alt>KP_7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-side-n "['<Alt>KP_8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-ne "['<Alt>KP_9']"
# Switch windows
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Alt>Above_Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Super>Above_Tab']"
gsettings set org.gnome.desktop.wm.keybindings cycle-group "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Alt>Tab']"
# Screenshots
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "<Shift>Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "<Ctrl><Shift>Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "<Ctrl>Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "<Alt><Shift>Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "<Alt>Print"
# Enter command
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['XF86Keyboard']"
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Alt>F2', '<Super>space']"
# Move to monitor
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-right "['<Alt>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Alt>Left']"






