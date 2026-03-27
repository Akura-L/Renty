import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================
//  RENTY — Complete Design System & ThemeData
//  Match the PDF design exactly
// ============================================================

// ─────────────────────────────────────────
//  1. COLOR PALETTE
// ─────────────────────────────────────────
class RentyColors {
  RentyColors._();

  // Primary
  static const Color primary =
      Color.fromARGB(133, 1, 77, 77); // Turquoise Teal CTA
  static const Color primaryLight =
      Color(0xFFCCE8E8); // Turquoise Teal chip bg / avatar bg
  static const Color primaryDark = Color.fromARGB(255, 11, 63, 63); // Pressed turquoise teal

  // Backgrounds
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5); // Cards, input fills
  static const Color surfaceCard = Color(0xFFFFFFFF); // Elevated white cards

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A); // Headings
  static const Color textSecondary = Color(0xFF757575); // Subtitles / hints
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Text on teal buttons

  // Semantic
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Borders & Dividers
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFF0F0F0);

  // Badge / Tag backgrounds
  static const Color badgeTopRated = Color.fromARGB(112, 5, 99, 86);
  static const Color badgeLuxury = Color(0xFF7B1FA2);
  static const Color badgeElectric = Color(0xFF1565C0);
  static const Color badgeEconomy = Color(0xFF2E7D32);
  static const Color badgeFeatured = Color(0xFFF57F17);

  // Booking status
  static const Color statusConfirmed = Color(0xFF4CAF50);
  static const Color statusPending = Color(0xFFFFA726);
  static const Color statusCancelled = Color(0xFFE53935);

  // Unread dot
  static const Color unreadDot = Color.fromARGB(100, 5, 113, 99);

  // Bottom nav
  static const Color navActive = Color.fromARGB(111, 6, 119, 104);
  static const Color navInactive = Color(0xFF9E9E9E);
}

// ─────────────────────────────────────────
//  2. TYPOGRAPHY
// ─────────────────────────────────────────
class RentyTextStyles {
  RentyTextStyles._();

  static const String _font = 'DMSans';

  // Display
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _font,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: RentyColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // Screen headings  e.g. "Welcome back", "Drive Your Way"
  static const TextStyle headingXL = TextStyle(
    fontFamily: _font,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: RentyColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.25,
  );

  static const TextStyle headingL = TextStyle(
    fontFamily: _font,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: RentyColors.textPrimary,
    letterSpacing: -0.2,
  );

  static const TextStyle headingM = TextStyle(
    fontFamily: _font,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: RentyColors.textPrimary,
  );

  static const TextStyle headingS = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: RentyColors.textPrimary,
  );

  // Body
  static const TextStyle bodyL = TextStyle(
    fontFamily: _font,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: RentyColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyM = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: RentyColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodyS = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: RentyColors.textSecondary,
    height: 1.4,
  );

  // Labels & Captions
  static const TextStyle labelL = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: RentyColors.textPrimary,
    letterSpacing: 0.1,
  );

  static const TextStyle labelM = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: RentyColors.textSecondary,
    letterSpacing: 0.2,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _font,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: RentyColors.textSecondary,
    letterSpacing: 0.3,
  );

  // Price
  static const TextStyle price = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: RentyColors.primary,
  );

  static const TextStyle priceSmall = TextStyle(
    fontFamily: _font,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: RentyColors.primary,
  );

  // Button text
  static const TextStyle button = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: RentyColors.textOnPrimary,
    letterSpacing: 0.2,
  );

  static const TextStyle buttonOutlined = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(117, 7, 122, 107),
    letterSpacing: 0.2,
  );

  // Links
  static const TextStyle link = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: RentyColors.primary,
    decoration: TextDecoration.none,
  );
}

// ─────────────────────────────────────────
//  3. SPACING & RADIUS CONSTANTS
// ─────────────────────────────────────────
class RentySpacing {
  RentySpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  // Screen horizontal padding
  static const double screenH = 16.0;
  static const double screenV = 20.0;
}

class RentyRadius {
  RentyRadius._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double pill = 30.0; // Fully rounded buttons
  static const double circle = 999.0;
}

// ─────────────────────────────────────────
//  4. THEMEDATA
// ─────────────────────────────────────────
class RentyTheme {
  RentyTheme._();

  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: RentyColors.primary,
      onPrimary: RentyColors.textOnPrimary,
      primaryContainer: RentyColors.primaryLight,
      onPrimaryContainer: RentyColors.primaryDark,
      secondary: RentyColors.primary,
      onSecondary: RentyColors.textOnPrimary,
      secondaryContainer: RentyColors.primaryLight,
      onSecondaryContainer: RentyColors.primaryDark,
      error: RentyColors.error,
      onError: Colors.white,
      surface: RentyColors.surface,
      onSurface: RentyColors.textPrimary,
      outline: RentyColors.border,
      outlineVariant: RentyColors.divider,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: RentyColors.background,
      fontFamily: 'DMSans',

      // ── AppBar ──────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: RentyColors.background,
        foregroundColor: RentyColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: RentyTextStyles.headingM,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),

      // ── Bottom Navigation ────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: RentyColors.background,
        selectedItemColor: RentyColors.navActive,
        unselectedItemColor: RentyColors.navInactive,
        selectedLabelStyle: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // ── Elevated Button (primary CTA) ────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: RentyColors.primary,
          foregroundColor: RentyColors.textOnPrimary,
          disabledBackgroundColor: RentyColors.border,
          disabledForegroundColor: RentyColors.textDisabled,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RentyRadius.pill),
          ),
          textStyle: RentyTextStyles.button,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),

      // ── Outlined Button (secondary) ──────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: RentyColors.primary,
          side: const BorderSide(color: RentyColors.border, width: 1.5),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RentyRadius.pill),
          ),
          textStyle: RentyTextStyles.buttonOutlined,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),

      // ── Text Button ──────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: RentyColors.primary,
          textStyle: RentyTextStyles.link,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        ),
      ),

      // ── Input Fields ─────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: RentyColors.background,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RentyRadius.lg),
          borderSide: const BorderSide(color: RentyColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RentyRadius.lg),
          borderSide: const BorderSide(color: RentyColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RentyRadius.lg),
          borderSide: const BorderSide(color: RentyColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RentyRadius.lg),
          borderSide: const BorderSide(color: RentyColors.error, width: 1),
        ),
        labelStyle: RentyTextStyles.bodyM,
        hintStyle: RentyTextStyles.bodyM,
        floatingLabelStyle: const TextStyle(
          fontFamily: 'DMSans',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: RentyColors.primary,
        ),
      ),

      // ── Cards ────────────────────────────────
      cardTheme: CardThemeData(
        color: RentyColors.surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RentyRadius.lg),
          side: const BorderSide(color: RentyColors.border, width: 0.8),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Chip (filter pills) ──────────────────
      chipTheme: ChipThemeData(
        backgroundColor: RentyColors.surface,
        selectedColor: RentyColors.primary,
        disabledColor: RentyColors.surface,
        labelStyle: const TextStyle(
          fontFamily: 'DMSans',
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: RentyColors.textPrimary,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: 'DMSans',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: RentyColors.textOnPrimary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RentyRadius.pill),
          side: const BorderSide(color: RentyColors.border),
        ),
        side: const BorderSide(color: RentyColors.border),
      ),

      // ── Divider ──────────────────────────────
      dividerTheme: const DividerThemeData(
        color: RentyColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── ListTile ─────────────────────────────
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minLeadingWidth: 24,
      ),

      // ── Radio ────────────────────────────────
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return RentyColors.primary;
          return RentyColors.border;
        }),
      ),

      // ── Checkbox ─────────────────────────────
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return RentyColors.primary;
          return Colors.transparent;
        }),
        side: const BorderSide(color: RentyColors.border, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // ── Progress Indicator ───────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: RentyColors.primary,
        linearTrackColor: RentyColors.primaryLight,
      ),

      // ── Floating Action Button ───────────────
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: RentyColors.primary,
        foregroundColor: RentyColors.textOnPrimary,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // ── Tab Bar ──────────────────────────────
      tabBarTheme: const TabBarThemeData(
        labelColor: RentyColors.primary,
        unselectedLabelColor: RentyColors.textSecondary,
        indicatorColor: RentyColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'DMSans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Icon ─────────────────────────────────
      iconTheme: const IconThemeData(
        color: RentyColors.textSecondary,
        size: 22,
      ),
    );
  }
}

// ─────────────────────────────────────────
//  5. REUSABLE WIDGET STYLES
// ─────────────────────────────────────────
class RentyDecorations {
  RentyDecorations._();

  /// Standard white card with border
  static BoxDecoration get card => BoxDecoration(
        color: RentyColors.surfaceCard,
        borderRadius: BorderRadius.circular(RentyRadius.lg),
        border: Border.all(color: RentyColors.border, width: 0.8),
      );

  /// Light grey surface card (stats, sections)
  static BoxDecoration get surfaceCard => BoxDecoration(
        color: RentyColors.surface,
        borderRadius: BorderRadius.circular(RentyRadius.lg),
      );

  /// Upload zone — dashed border
  static BoxDecoration get uploadZone => BoxDecoration(
        color: RentyColors.surface,
        borderRadius: BorderRadius.circular(RentyRadius.lg),
        border: Border.all(color: RentyColors.border, width: 1.2),
      );

  /// Search bar
  static BoxDecoration get searchBar => BoxDecoration(
        color: RentyColors.surface,
        borderRadius: BorderRadius.circular(RentyRadius.pill),
      );

  /// Teal badge (Top Rated, etc.)
  static BoxDecoration badge(Color color) => BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(RentyRadius.xs),
      );

  /// Bottom sheet handle
  static BoxDecoration get sheetHandle => BoxDecoration(
        color: RentyColors.border,
        borderRadius: BorderRadius.circular(RentyRadius.circle),
      );

  /// Profile avatar circle (initials)
  static BoxDecoration get avatarInitials => const BoxDecoration(
        color: RentyColors.primaryLight,
        shape: BoxShape.circle,
      );

  /// OTP input box
  static BoxDecoration get otpBox => BoxDecoration(
        color: RentyColors.background,
        borderRadius: BorderRadius.circular(RentyRadius.md),
        border: Border.all(color: RentyColors.border, width: 1.5),
      );

  static BoxDecoration get otpBoxActive => BoxDecoration(
        color: RentyColors.background,
        borderRadius: BorderRadius.circular(RentyRadius.md),
        border: Border.all(color: RentyColors.primary, width: 2),
      );
}

// ─────────────────────────────────────────
//  6. STEP PROGRESS INDICATOR WIDGET
// ─────────────────────────────────────────
class RentyStepIndicator extends StatelessWidget {
  final int currentStep; // 1-based
  final int totalSteps;
  final List<String> labels;

  const RentyStepIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
    this.labels = const ['Contact', 'Verify', 'Details', 'Photo', 'License'],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(labels.length, (i) {
        final stepNum = i + 1;
        final isCompleted = stepNum < currentStep;
        final isActive = stepNum == currentStep;
        final color = (isCompleted || isActive)
            ? RentyColors.primary
            : RentyColors.textDisabled;

        return Expanded(
          child: Column(
            children: [
              Text(
                labels[i],
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────
//  BACKWARD COMPATIBILITY ALIASES
//  Map old AppTheme to new system (add these temporarily)
// ─────────────────────────────────────────
// To use: AppTheme.grey700 → RentyColors.textSecondary, etc.
// Full migration in TODO.md step 7

class AppTheme {
  // Colors (aliases)
  static const Color primary = RentyColors.primary;
  static const Color dark = RentyColors.textPrimary;
  static const Color grey = RentyColors.textSecondary;
  static Color get grey600 => RentyColors.textSecondary.withOpacity(0.6);
  static Color get grey700 => RentyColors.textSecondary.withOpacity(0.7);
  static Color get grey10 => RentyColors.border.withOpacity(0.1);

  // Spacing (alias old constants)
  static const double kPaddingXS = RentySpacing.xs;
  static const double kPaddingSmall = RentySpacing.sm;
  static const double kPaddingMedium = RentySpacing.md;
  static const double kPaddingLarge = RentySpacing.lg;
  static const double kPaddingXL = RentySpacing.xl;

  // Use RentyTheme.light instead of lightTheme
  // Sizes - backward compatibility
  static const double kCardImageHeight = 140.0;
  static const double kThumbnailHeight = 60.0;
  static const double kThumbnailWidth = 80.0;
  static const double kDetailImageHeight = 240.0;
  static const double kIconSizeLarge = 28.0;
  static const double kFontSizeLargeTitle = 28.0;
  static const double kFontSizeSmall = 12.0;

  // Colors - backward compatibility
  static Color get primary10 => RentyColors.primary.withOpacity(0.1);
  static Color get grey25 => RentyColors.border.withOpacity(0.25);
  static Color get grey300 => RentyColors.surface;

  static ThemeData get lightTheme => RentyTheme.light;
}
