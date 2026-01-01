import 'package:flutter/material.dart';

ThemeData myAppTheme() {
  const primaryColor = Color(0xFF4F46E5);
  const secondaryColor = Color(0xFF22C55E);

  final colorScheme = ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,

    scaffoldBackgroundColor: const Color(0xFFF7F8FA),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF111827),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF111827)),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.all(8),
    ),

    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF111827),
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1F2937),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.5,
        color: Color(0xFF374151),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    ),

    splashFactory: InkRipple.splashFactory,
  );
}
