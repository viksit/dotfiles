#!/bin/sh

# diff is called by git with 7 parameters:
# path old-file old-hex old-mode new-file new-hex new-mode
#FM="open -a /Applications/Xcode.app/Contents/Applications/FileMerge.app"
FM="opendiff"
$FM "$2" "$5" -merge "$1"
