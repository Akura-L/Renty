# Renty Error Correction & Theme Migration TODO

## Status Legend
- [ ] **Pending**
- [x] **Completed**

## Step 1: Create/Update this TODO.md ✅

## Step 2: Fix fonts in lib/core/theme.dart ✅\n- Standardize fontFamily to 'DMSans' (local Inter fonts)\n- Remove GoogleFonts.dmSans() references\n- Ensure consistent font across ThemeData

## Step 3: Update lib/screens/home/home_screen.dart
- Replace GoogleFonts.inter() with RentyTextStyles.*
- Migrate AppTheme colors to RentyColors via Theme.of(context)
- Verify no overflow issues

## Step 4: Migrate auth screens (priority: sign_in_screen.dart, sign_up_screen.dart, otp_screen_fixed.dart, photo_screen.dart)
- Remove GoogleFonts.inter(), AppTheme.*
- Use theme-aware styles

## Step 5: Update main_screen.dart & other core screens
- Minor color/style updates

## Step 6: Run commands & verify
- `flutter pub get`
- `flutter analyze`
- `flutter run`

## Step 7: Full project scan & remaining migrations
- Use search_files for remaining AppTheme/GoogleFonts
- Lint fixes

## Step 8: Final audit
- No lint errors
- Theme consistency
- Visual match to design
