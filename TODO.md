# Responsiveness Fix Plan - Prevent Overflow on Different Devices

## Completed Steps
- [ ]

## Completed Steps
- [x] 1. Add responsive utilities to lib/core/theme.dart
- [x] 2. Update lib/screens/home/home_screen.dart
- [x] 3. Update lib/screens/booking/car_detail_screen.dart

## Pending Steps

### 2. Update lib/screens/home/home_screen.dart
   - Replace fixed paddings with responsive screenPadding()
   - Change chip Row to Wrap(direction: Axis.horizontal, spacing: horizontalGap())
   - Make GridView crossAxisCount dynamic: Responsive.dynamicGridCount(context)
   - Adjust childAspectRatio based on screen width

### 3. Update lib/screens/booking/car_detail_screen.dart
   - Legend Row → Wrap(spacing: horizontalGap())
   - Dynamic avatar/review sizing with adaptiveSize()

### 4. Update auth screens (lib/auth/)
   - license_screen.dart & photo_screen.dart: Paddings → screenPadding(), upload height → adaptiveHeight(180), avatar radius adaptive
   - otp_screen.dart: OTP fields height → adaptiveHeight(70), padding responsive

### 5. Update profile & booking screens
   - profile_screen.dart: Fixed widths → horizontalGap()
   - my_bookings_screen.dart: Button Rows → Flexible + responsive gaps
   - payment_screen.dart: Similar Row/Wrap fixes

### 6. Global testing
   - Run `flutter analyze`
   - Test on emulators: iPhone SE (small), Pixel 4, iPad (large)
   - Check landscape mode
   - Verify no horizontal scrolls/overflows

### 7. Completion
   - attempt_completion with demo command (e.g., open emulator)
