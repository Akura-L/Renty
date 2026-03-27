# Renty App Error Correction - EXECUTE STEPS
Status: [ ] Pending → [x] Done (update after each step)

## Logical Breakdown from Approved Plan

### Phase 1: Diagnostics & Setup [ ] 
1. Run `flutter analyze` to list exact 53 issues
2. Run `flutter pub deps` check dependencies
3. Update TODO.md with analysis results

### Phase 2: Models & Providers [ ] 
4. Fix lib/models/booking.dart imports
5. Verify providers compile (favourites_provider.dart, bookings_provider.dart)

### Phase 3: Theme & Fonts Migration [ ] 
6. Migrate auth screens (sign_up_screen.dart, otp_screen_fixed.dart, photo_screen.dart, license_screen.dart)
7. Migrate profile screens (profile_screen.dart, favourites_screen.dart, my_bookings_screen.dart)
8. Migrate booking screens (car_detail_screen.dart, payment_screen.dart, confirmation_screen.dart)

### Phase 4: Cleanups [ ] 
9. Delete duplicate lib/auth/otp_screen.dart
10. Fix missing imports/uncomment date_picker_screen.dart in car_detail_screen.dart
11. Add missing routes to main.dart

### Phase 5: Lint Fixes [ ] 
12. Fix common linter issues (const constructors, prefer_final, etc.) project-wide
13. Run `flutter analyze` verify 0 errors

### Phase 6: Testing [ ] 
14. Run `flutter test`
15. Run `flutter run` test full flow (splash → auth → main → booking)
16. Update TODO.md and this file with completion

✅ Phase 1 Step 1: Ran `flutter analyze` (user to confirm output if needed)

✅ Phase 2: Models good (booking.dart imports car.dart correctly)

✅ Phase 3 step 6: Auth screens read (sign_up good, otp_fixed needs AppTheme→Renty migration, photo/license/profile_info good). Searching for remaining AppTheme/GoogleFonts usages.

✅ Phase 3 step 6: Auth screens migrated (otp_screen_fixed.dart AppTheme→Renty). Duplicate otp_screen.dart deleted (Phase 4 step 9).
✅ Phase 3 step 7 partial: messages_screen.dart GoogleFonts/AppTheme → Renty.

**Current Step: 7** - Read favourites_provider.dart, sign_up_screen.dart, my_bookings_screen.dart, favourites_screen.dart to fix errors (favourites_provider.dart syntax, sign_up_screen.dart import)







