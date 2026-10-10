import 'package:flutter/material.dart';
import '../../core/constants/app_values.dart';

abstract final class AppTheme {
  static ThemeData light() {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppValues.lightPrimary,
      onPrimary: Colors.white,
      primaryContainer: AppValues.lightAccentSoft,
      onPrimaryContainer: AppValues.lightTextPrimary,
      secondary: AppValues.lightAccent,
      onSecondary: AppValues.lightTextPrimary,
      tertiary: AppValues.lightWarning,
      onTertiary: Colors.white,
      error: AppValues.lightCritical,
      onError: Colors.white,
      surface: AppValues.lightSurface,
      onSurface: AppValues.lightTextPrimary,
      onSurfaceVariant: AppValues.lightTextSecondary,
      outline: AppValues.lightDivider,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppValues.lightBackground,
      dividerColor: AppValues.lightDivider,
      inputDecorationTheme: _inputTheme(
        fill: AppValues.lightSurfaceAlt,
        border: AppValues.lightDivider,
        focus: AppValues.lightPrimary,
      ),
      cardTheme: const CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 1,
        shadowColor: Color(0x1810211D),
        surfaceTintColor: Colors.transparent,
        color: AppValues.lightSurface,
      ),
    );
  }

  static ThemeData dark() {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppValues.darkPrimary,
      onPrimary: Color(0xFF07130F),
      primaryContainer: AppValues.darkAccentSoft,
      onPrimaryContainer: AppValues.darkTextPrimary,
      secondary: AppValues.darkAccent,
      onSecondary: Color(0xFF07130F),
      tertiary: AppValues.darkWarning,
      onTertiary: Color(0xFF211200),
      error: AppValues.darkCritical,
      onError: Color(0xFF210505),
      surface: AppValues.darkSurface,
      onSurface: AppValues.darkTextPrimary,
      onSurfaceVariant: AppValues.darkTextSecondary,
      outline: AppValues.darkDivider,
    );
    return _base(scheme).copyWith(
      scaffoldBackgroundColor: AppValues.darkBackground,
      dividerColor: AppValues.darkDivider,
      inputDecorationTheme: _inputTheme(
        fill: AppValues.darkSurfaceAlt,
        border: AppValues.darkDivider,
        focus: AppValues.darkPrimary,
      ),
      cardTheme: const CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: AppValues.darkSurface,
      ),
    );
  }

  static ThemeData _base(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'PowerLeftSans',
      fontFamilyFallback: const ['PowerLeftJapanese'],
      colorScheme: scheme,
      textTheme:
          const TextTheme(
            displaySmall: TextStyle(
              fontSize: 38,
              height: 1.2,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.3,
            ),
            headlineMedium: TextStyle(
              fontSize: 28,
              height: 34 / 28,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.9,
            ),
            titleLarge: TextStyle(
              fontSize: 20,
              height: 25 / 20,
              fontWeight: FontWeight.w600,
            ),
            titleMedium: TextStyle(
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(fontSize: 15, height: 1.6),
            bodyMedium: TextStyle(fontSize: 14, height: 1.55),
            bodySmall: TextStyle(fontSize: 12, height: 1.55),
            labelLarge: TextStyle(
              fontSize: 17,
              height: 22 / 17,
              fontWeight: FontWeight.w600,
            ),
          ).apply(
            fontFamily: 'PowerLeftSans',
            bodyColor: scheme.onSurface,
            displayColor: scheme.onSurface,
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, AppValues.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.buttonRadius),
          ),
          textStyle: const TextStyle(
            fontFamily: 'PowerLeftSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 50),
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.buttonRadius),
          ),
          textStyle: const TextStyle(
            fontFamily: 'PowerLeftSans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      visualDensity: VisualDensity.standard,
      dividerTheme: DividerThemeData(color: scheme.outline, thickness: .7),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            fontFamily: 'PowerLeftSans',
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: scheme.primary,
          backgroundColor: scheme.primaryContainer.withValues(alpha: .45),
          minimumSize: const Size(44, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontFamily: 'PowerLeftSans',
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          side: WidgetStatePropertyAll(BorderSide(color: scheme.outline)),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.surface.withValues(alpha: .2),
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? scheme.onPrimary
                : scheme.onSurfaceVariant,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surface,
        selectedColor: scheme.primaryContainer,
        side: BorderSide(color: scheme.outline),
        labelStyle: TextStyle(
          fontFamily: 'PowerLeftSans',
          color: scheme.onSurface,
          fontSize: 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.primary,
        textColor: scheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        titleTextStyle: TextStyle(
          fontFamily: 'PowerLeftSans',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
        subtitleTextStyle: TextStyle(
          fontFamily: 'PowerLeftSans',
          fontSize: 12,
          color: scheme.onSurfaceVariant,
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: scheme.primary,
        collapsedIconColor: scheme.onSurfaceVariant,
        shape: const Border(),
        collapsedShape: const Border(),
      ),
    );
  }

  static InputDecorationTheme _inputTheme({
    required Color fill,
    required Color border,
    required Color focus,
  }) {
    final radius = BorderRadius.circular(AppValues.inputRadius);
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: focus, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      helperMaxLines: 4,
      errorMaxLines: 3,
    );
  }
}
