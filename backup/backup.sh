#!/bin/sh

sudo rsync -vaE --progress -filter=". backup_folders.txt" /Volumes/MyHDAlpha /Volumes/MyHDBeta
