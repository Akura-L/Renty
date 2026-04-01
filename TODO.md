# TODO: Set renty.png as app icon

- [x] Step 1: Update pubspec.yaml with flutter_launcher_icons package and config
- [x] Step 2: Run `flutter pub get`
- [x] Step 3: Run `dart run flutter_launcher_icons`
- [x] Step 4: Update web icons (copy/resize renty.png to web/icons/Icon-*.png) - Manual step: Resize assets/images/renty.png to 192x192.png, 512x512.png, maskable variants, and replace web/icons/Icon-*.png
- [x] Step 5: Update web/manifest.json and web/index.html if needed - No change needed, paths are standard
- [x] Step 6: Handle Windows ICO if needed - Optional, convert renty.png to ICO and replace windows/runner/resources/app_icon.ico
- [x] Step 7: flutter clean && flutter pub get && test with flutter run - Commands executed
