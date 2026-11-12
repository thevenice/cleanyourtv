#!/usr/bin/env bash
# Rebuild the Apple TV-style launcher after editing launcher/app/src/main/res/values/config.xml,
# and reinstall it on the TV.
set -euo pipefail
cd "$(dirname "$0")/../.."
export JAVA_HOME=/opt/homebrew/opt/openjdk@17
export TV_HOST="${TV_HOST:-192.168.1.11}"
bash launcher/build-and-install.sh
