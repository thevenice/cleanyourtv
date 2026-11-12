#!/usr/bin/env bash
# Undo everything on Prakash's OnePlus 43 Y1S Edge (192.168.1.11): re-enable every disabled app,
# give Home back to the stock Google TV launcher, and remove the new launcher's key service.
# Needs USB debugging + network debugging switched ON again on the TV first.
set -euo pipefail
cd "$(dirname "$0")/../.."
export TV_HOST="${TV_HOST:-192.168.1.11}"
S="$TV_HOST:5555"
adb connect "$S"
grep -vE '^\s*(#|$)' examples/oneplus-tv-y1s-edge-43fd2a01/debloat.txt | sed -E 's/\s+#.*$//' | awk '{print $1}' | while read -r p; do
  adb -s "$S" shell pm enable --user 0 "$p"
done
adb -s "$S" shell settings delete secure enabled_accessibility_services || true
adb -s "$S" shell cmd package set-home-activity --user 0 com.google.android.tvlauncher/.MainActivity
adb -s "$S" shell pm disable-user --user 0 com.gathin.tvhome   # or: adb shell pm uninstall com.gathin.tvhome
echo "Restored. Press Home on the remote."
