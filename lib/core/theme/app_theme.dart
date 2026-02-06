import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF514ACC);
  static const Color secondaryColor = Color(0xFFFF6584);
  static const Color accentColor = Color(0xFF38B6FF);
  static const Color offerColor = Color(0xFFE53935); // Red for offers

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF9FAFB);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  // Glass Colors (simplified - single color base)
  static const Color glassLight = Colors.white;
  static const Color glassDark = Color(0xFF2A2A2A);

  // Common
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color successColor = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: lightSurface,
      error: errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: lightText,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
    ),
    textTheme: _buildTextTheme(lightText, lightTextSecondary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),
    cardTheme: CardThemeData(
      color: lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightSurface,
      selectedItemColor: primaryColor,
      unselectedItemColor: textSecondary,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: darkSurface,
      error: errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: darkText,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
    ),
    textTheme: _buildTextTheme(darkText, darkTextSecondary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[800]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[800]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),
    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      selectedItemColor: primaryColor,
      unselectedItemColor: darkTextSecondary,
    ),
  );

  static TextTheme _buildTextTheme(Color primary, Color secondary) {
    return TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primary,
      ),
      bodyLarge: GoogleFonts.inter(fontSize: 16, color: primary),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: secondary),
      bodySmall: GoogleFonts.inter(fontSize: 12, color: secondary),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
    );
  }
}
