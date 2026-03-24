import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primary = Color(0xFF00BFA5);
  static const Color dark = Color(0xFF1A1A1A);
  static const Color grey = Color(0xFF666666);

  // Spacing Constants
  static const double kPaddingXS = 8.0;
  static const double kPaddingSmall = 12.0;
  static const double kPaddingMedium = 16.0;
  static const double kPaddingLarge = 20.0;
  static const double kPaddingXL = 24.0;

  // Sizes
  static const double kCardImageHeight = 140.0;
  static const double kDetailImageHeight = 200.0;
  static const double kThumbnailHeight = 60.0;
  static const double kThumbnailWidth = 80.0;
  static const double kSmallImageHeight = 60.0;
  static const double kAvatarRadius = 20.0;
  static const double kLargeAvatarRadius = 60.0;
  static const double kIconSizeLarge = 80.0;
  static const double kFontSizeLargeTitle = 22.0;
  static const double kFontSizeTitle = 18.0;
  static const double kFontSizeBody = 15.0;
  static const double kFontSizeSmall = 12.0;

  // Color Shades & Variants
  static Color get grey10 => grey.withOpacity(0.1);
  static Color get grey300 => grey.withOpacity(0.3);
  static Color get grey600 => grey.withOpacity(0.6);
  static Color get grey700 => grey.withOpacity(0.7);
  static Color get grey18 => grey.withOpacity(0.18);
  static Color get grey22 => grey.withOpacity(0.22);
  static Color get grey25 => grey.withOpacity(0.25);
  static Color get grey55 => grey.withOpacity(0.55);

  static Color get primary05 => primary.withOpacity(0.05);
  static Color get primary07 => primary.withOpacity(0.07);
  static Color get primary10 => primary.withOpacity(0.1);
  static Color get primary12 => primary.withOpacity(0.12);
  static Color get primary14 => primary.withOpacity(0.14);
  static Color get primary20 => primary.withOpacity(0.2);

  // Shadows
  static const List<BoxShadow> kCardShadow = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static ThemeData get lightTheme => ThemeData(
        primaryColor: primary,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.inter().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: dark),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kPaddingMedium),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kPaddingMedium),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kPaddingMedium),
            borderSide: const BorderSide(color: primary, width: 2),
          ),
        ),
        extensions: [
          ResponsiveExtension(AppTheme()),
        ],
      );
  }
}

class Responsive {
  /// Responsive utilities to prevent overflow on different devices
  double screenPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * 0.05).clamp(12.0, 28.0);
  }

  double horizontalGap(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * 0.025).clamp(6.0, 16.0);
  }

  int dynamicGridCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / 200).floor().clamp(1, 2);
  }

  double adaptiveHeight(BuildContext context, double baseHeight) {
    final height = MediaQuery.sizeOf(context).height;
    return (baseHeight * (height / 800)).clamp(height * 0.18, height * 0.28);
  }

  double adaptiveRadius(BuildContext context, double baseRadius) {
    final width = MediaQuery.sizeOf(context).width;
    return (baseRadius * (width / 400)).clamp(40.0, 90.0);
  }
}

class ResponsiveExtension extends ThemeExtension<Responsive> {
  const ResponsiveExtension(this.appTheme) : super();
  
  final AppTheme appTheme;

  @override
  ThemeExtension<Responsive> copyWith({Responsive? responsive}) => this;

  @override
  ResponsiveExtension lerp(ThemeExtension<Responsive>? other, double t) => this;
}


class Responsive {
  /// Responsive utilities to prevent overflow on different devices
  static double screenPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * 0.05).clamp(12.0, 28.0);
  }

  static double horizontalGap(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * 0.025).clamp(6.0, 16.0);
  }

  static int dynamicGridCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width / 200).floor().clamp(1, 2);
  }

  static double adaptiveHeight(BuildContext context, double baseHeight) {
    final height = MediaQuery.sizeOf(context).height;
    return (baseHeight * (height / 800)).clamp(height * 0.18, height * 0.28);
  }

  static double adaptiveRadius(BuildContext context, double baseRadius) {
    final width = MediaQuery.sizeOf(context).width;
    return (baseRadius * (width / 400)).clamp(40.0, 90.0);
  }
}


