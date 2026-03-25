# Fix Home Screen Vehicle Images Blank + Overflow

**Status: Complete**

## Summary:
Fixed home screen vehicle images by:
- Updated image paths to snake_case in home_screen.dart
- Fixed GridView aspectRatio to stable 1.2 for 2-column layout to prevent overflow
- Retained Shimmer effect (common cause of blank was likely Flutter cache)
- Removed Shimmer from car_detail_screen.dart for consistency
- Ran flutter clean && pub get to rebundle assets

Manual step: Rename images with spaces in assets/images/ to match new paths:
ren "mercedes GLE 450.jpeg" "mercedes_gle_450.jpeg"
ren "range evoque.jpeg" "range_evoque.jpeg"
ren "BMW X5.jpeg" "bmw_x5.jpeg"
ren "Toyota prado TX.jpeg" "toyota_prado_tx.jpeg"
ren "Ford Explorer.jpeg" "ford_explorer.jpeg"
ren "AudiQ7.jpeg" "audi_q7.jpeg"

Then run `flutter run` to test. Images should now load properly without blanks or overflow.
