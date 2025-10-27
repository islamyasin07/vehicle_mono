import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData _base(ColorScheme scheme) {
  final textTheme = GoogleFonts.interTextTheme().copyWith(
    headlineMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w700,
      fontSize: 28,
    ),
    titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 18),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: scheme.surface,

    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleMedium,
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      surfaceTintColor: scheme.surfaceTint,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: TextStyle(color: scheme.onInverseSurface),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),

    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: scheme.secondaryContainer.withAlpha((0.6 * 255).round()),
      labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      elevation: 1,
      backgroundColor: scheme.surface,
    ),

    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        ),
        TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        ),
        TargetPlatform.windows: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        ),
        TargetPlatform.linux: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        ),
        TargetPlatform.macOS: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        ),
      },
    ),
  );
}

ThemeData buildLightTheme() => _base(
  ColorScheme.fromSeed(
    seedColor: const Color(0xFF5B8DEF),
    brightness: Brightness.light,
  ),
);

ThemeData buildDarkTheme() => _base(
  ColorScheme.fromSeed(
    seedColor: const Color(0xFF5B8DEF),
    brightness: Brightness.dark,
  ),
);
