#!/bin/sh

# You might need to restart your pc if sharun doesn't create `AppDir` in this directory (It should create dirs on its own)

# Run git.yml and extract the pkg.tar.zst generated from that to the folder this .sh file is in. As a result a folder named `usr` should be in the same folder as this script.
set -eu

ARCH="$(uname -m)"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/753b3ba3c77a573f8c2eeb0b397752df2d3235df/useful-tools/quick-sharun.sh"

export ADD_HOOKS="self-updater.bg.hook"
#export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export OUTNAME=zerotier-desktop-ui-anylinux-"$ARCH".AppImage
export DESKTOP=./usr/share/applications/zerotier-ui.desktop
export ICON=./usr/share/icons/hicolor/512x512/apps/zerotier.png
export OUTPATH=./dist
export DEPLOY_OPENGL=0
export DEPLOY_VULKAN=0
export DEPLOY_DOTNET=0

#Remove leftovers
rm -rf AppDir dist appinfo

# ADD LIBRARIES
wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun

# Point to binaries
./quick-sharun ./usr/bin/zerotier_desktop_ui

# Make AppImage
./quick-sharun --make-appimage

echo "All Done!"
