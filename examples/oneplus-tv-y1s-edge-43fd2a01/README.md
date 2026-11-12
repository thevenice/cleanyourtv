# Prakash's OnePlus 43 Y1S Edge (43FD2A01): clean home screen

The TV reports itself as OnePlus **D00 "Dubai"**, running **Google TV / Android 14** (firmware UTT1.240928.001). IP: 192.168.1.11.
Debloated and re-skinned on 21 Oct 2026. Nothing was uninstalled; everything is reversible.

## What changed
- **Disabled** (list and reasons in `debloat.txt`): Google feedback, recommendation rows and sponsored partner rows, calendar sync, OnePlus TV Assistant, OnePlus smart home, Google TV (Play Movies), Play Games, the OxygenPlay page (`com.oneplus.tv.launcher`) and the stock Google TV launcher.
- **Kept:** Netflix, Prime Video, JioHotstar, YouTube, YouTube Music, Apple TV, Google Assistant (mic), Chromecast, OnePlus Connect and Bluetooth speaker, remote/firmware updates, File Browser (also the USB video/music player), Live TV (`com.heytap.tv.livetv`), Play Store and Play Services.
- **New Home:** the Apple TV-style launcher from `launcher/` (`com.gathin.tvhome`). Dock: YouTube, Netflix, Prime Video, JioHotstar. Inputs menu: HDMI 1, HDMI 2, Component, Composite, VGA and Live TV.
- **Remote:** Netflix, Prime Video, JioHotstar, Mic and Settings work as before. The **OnePlus button** (keycode 132): long press still shows Sleep / Restart / Power off; a short tap does nothing now that OxygenPlay is disabled (re-enable `com.oneplus.tv.launcher` to get it back). Mapping the short tap to YouTube was tried and dropped: once the launcher's key service takes the button, the long-press power menu breaks, and passing the key through makes the tap unreliable.
- Backup of the original state (package lists, getprop, all settings, screenshots): `backup/20261021-093613/`.

Before running any script below, switch **USB debugging** (and network debugging, if shown) back on under Settings → System → Developer options, and accept the prompt on the TV.

## Re-enable one app
```
adb connect 192.168.1.11:5555
adb shell pm enable --user 0 <package>      # e.g. com.google.android.videos
```
Or on the TV: Settings → Apps → See all apps → show system apps → the app → Enable.

## Undo everything
```
examples/oneplus-tv-y1s-edge-43fd2a01/restore.sh
```

## Change the dock order or the greeting
1. Edit `launcher/app/src/main/res/values/config.xml`:
   - `dock_apps`: the four packages, in order (YouTube `com.google.android.youtube.tv`, Netflix `com.netflix.ninja`, Prime Video `com.amazon.amazonvideo.livingroom`, JioHotstar `in.startv.hotstar`, Apple TV `com.apple.atve.androidtv.appletv`, YouTube Music `com.google.android.youtube.tvmusic`).
   - `greeting_name`: the name after "Good morning".
2. Run `examples/oneplus-tv-y1s-edge-43fd2a01/build-and-install.sh`.

## Change the wallpaper
Use a theme: `TV_HOST=192.168.1.11 tools/theme.sh themes/<name>` (see `themes/README.md` for `config.json` and the wallpaper file). You can also hold the Settings pill on the home screen to open the launcher's own settings.

## Optional: ad-blocking DNS (not applied)
```
adb shell settings put global private_dns_specifier dns.adguard-dns.com
adb shell settings put global private_dns_mode hostname
```
It doesn't block YouTube ads. Undo: `adb shell settings put global private_dns_mode opportunistic`.

## Home wallpaper and screensaver (12 Nov 2026, after a factory reset)
- Home: theme `themes/badrinath` (Badrinath photo, `wallpaper_dim` 70) and a whitish glass dock band. Push with `TV_HOST=192.168.1.11 tools/theme.sh themes/badrinath`.
- Screensaver: the launcher's `ClockDream` with a photo, a small see-through clock in the bottom-right corner. Starts after 5 min idle.
  Change the photo: `adb push images/screensaver-family.jpg /sdcard/Android/data/com.gathin.tvhome/files/dream.jpg`
- Personal photos live in `images/` and `themes/*/*.jpg`, both git-ignored. Only code and config are committed.
- Also disabled after the reset: ad-measurement services, both screensaver apps' predecessors (ambient mode), OnePlus user guide, JioGames. Usage & Diagnostics switched off in Settings. Ad ID kept.
