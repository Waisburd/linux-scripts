#!/bin/bash

# Script for installing and configuring things after linux installation
# It requires sudo privileges

# Initialize variables
DOWNLOADS=$HOME/Downloads
DEFAULT_APPLICATIONS_FILE=/etc/gnome/defaults.list
BACKGROUND=/usr/share/backgrounds/pop/kate-hazen-unleash-your-robot.png
SCREENSAVER=/usr/share/backgrounds/pop/nick-nazzaro-ice-cave.png

# Download and install google-chrome --------------------------------------------------------------
echo "Downloding Google Chrome"
wget --output-document=$DOWNLOADS/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --no-verbose
echo "Download finished"
echo "Installing Google Chrome"
sudo apt-get install $DOWNLOADS/google-chrome.deb -y
rm $DOWNLOADS/google-chrome.deb
echo "Google Chrome installation finished, installer removed"

# Install vlc -------------------------------------------------------------------------------------
echo "Installing vlc"
sudo apt-get install vlc -y

# Install vscode
echo "Installing vscode"
sudo apt-get install code -y

# Configure default applications ------------------------------------------------------------------
echo "Configuring default applications"
sudo sed -i 's/firefox.desktop/google-chrome.desktop/g' $DEFAULT_APPLICATIONS_FILE
sudo sed -i 's/org.gnome.Totem.desktop/vlc.desktop/g' $DEFAULT_APPLICATIONS_FILE

# Configure favorite applications -----------------------------------------------------------------
echo "Configuring favorite applications"
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Calculator.desktop']"

# Set background
echo "Changing background and screen-saver"
if [ -f $BACKGROUND ]; then
	gsettings set org.gnome.desktop.background picture-uri "file://$BACKGROUND"
	echo "Background set"
else
	echo "Cannot set background. File not found at: $BACKGROUND"
fi
if [ -f $SCREENSAVER ]; then
	gsettings set org.gnome.desktop.screensaver picture-uri "file://$SCREENSAVER"
	echo "Screen-saver set"
else
	echo "Cannot set screen-saver. File not found at: $SCREENSAVER"
fi



# Install go --------------------------------------------------------------------------------------
echo "Installing go"
sudo apt-get install golang-go -y -q
echo "Configuring go environment variables"
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
echo "Go installation finished"



# Configure keyboard shortcuts --------------------------------------------------------------------
# Attach window to sides or corners
echo -e "\vConfiguring keybindings: window position\n"
ACTIONS=(move-to-corner-sw move-to-side-s move-to-corner-se move-to-side-w move-to-center move-to-side-e move-to-corner-nw move-to-side-n move-to-corner-ne)
DIRECTIONS=(sw s se w center e nw n ne)
for i in {1..9}; do
	gsettings set org.gnome.desktop.wm.keybindings ${ACTIONS[i-1]} "['<Alt>KP_$i']"
	output=$(gsettings get org.gnome.desktop.wm.keybindings ${ACTIONS[i-1]})
	if test "$output" = "['<Alt>KP_$i']"; then
		echo "Move window to ${DIRECTIONS[i-1]}: Alt + Numpad_$i"
	else
		echo "Cannot set keybinding: ${ACTIONS[i-1]}"
		echo "Current keybinding for ${ACTIONS[i-1]}: $output"
	fi
done

# Switch windows
echo -e "\vConfiguring keybindings: application/window swith method\n"
ACTIONS=(switch-applications switch-windows switch-group cycle-group cycle-windows move-to-monitor-left move-to-monitor-right)
VALUES=("['<Alt>Above_Tab']" "[]" "['<Super>Above_Tab']" "['<Super>Tab']" "['<Alt>Tab']" "['<Alt>Left']" "['<Alt>Right']")
VALUES_TO_SHOW=("Alt + Abobe_Tab" "Empty" "Super + Above_Tab" "Super + Tab" "Alt + Tab" "Alt + Left" "Alt + Right")

for i in {0..6}; do
	gsettings set org.gnome.desktop.wm.keybindings ${ACTIONS[i]} ${VALUES[i]}
	output="$(gsettings get org.gnome.desktop.wm.keybindings ${ACTIONS[i]})"

	test "${VALUES[i]}" = "[]" && declare value="@as []" || declare value=${VALUES[i]}
	if test "$output" = "$value"; then
		echo  "Keyboard shortcut for ${ACTIONS[i]}: ${VALUES_TO_SHOW[i]}"
	else
		echo "Cannot set keybinding: ${ACTIONS[i]}"
		echo "Current keyboard shortcut for ${ACTIONS[i]}: $output"
	fi
done

# Screenshots
echo "Configuring keybindings: screenshots"
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot "<Shift>Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot "<Ctrl><Shift>Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "<Ctrl>Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot "<Alt><Shift>Print"
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot-clip "<Alt>Print"

# Enter command
echo "Configuring keybindings: Enter command"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['XF86Keyboard']"
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Alt>F2', '<Super>space']"








