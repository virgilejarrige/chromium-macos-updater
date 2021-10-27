#!/bin/sh
# Chromium update script - macOS
# - by shad <shad@zaphod.eu>
# - modified by virgile.jarrige@unistra.fr
# Place this file in /Users/Shared/mbin/
# Launch this file with this command line: /Users/Shared/mbin/chromium_update.sh
# Enjoy.


osascript -e 'display alert "Chromium is about to be updated" message "Press OK when you are ready"'

DL_URL=https://download-chromium.appspot.com/dl/Mac?type=snapshots
INSTALL_DIR=/Applications
TMP_DIR="/tmp/update-chromium-$RANDOM"
TMP_File=chromium.zip

echo Stopping Chromium...
pkill -x Chromium
echo Chromium stopped.

(
mkdir $TMP_DIR ; cd $TMP_DIR
echo Downloading latest version of Chromium...
wget -q -O ${TMP_File} ${DL_URL}
if [ $? -ne 0 ] ; then
	echo Cannot update.
	exit 1
fi
echo "Download done."
echo "Unzipping..."
unzip -qq ${TMP_File}
echo "Unzip done."
echo "Replacing Chromium.app file in Application folder with the latest version..."
rm -rf "${INSTALL_DIR}/Chromium.app"
mv chrome-mac/Chromium.app "$INSTALL_DIR"
echo "Latest version of Chromium.app is in Application folder."
)

echo Removing temporary files...
rm -rf $TMP_DIR
echo "temporary files deleted."
echo "-"
echo "All done."

osascript -e 'display alert "Chromium has been updated" message "Enjoy!"'
