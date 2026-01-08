import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- Modern Glassmorphism Palette ---
  
  // Dark Mode colors
  static const Color darkBackground = Color(0xFF0F172A); // Deep Night Blue
  static const Color darkSurface = Color(0xFF1E293B);    // Glass Card Surface
  static const Color darkPrimary = Color(0xFF818CF8);    // Indigo/Violet (WCAG accessible)
  static const Color darkSecondary = Color(0xFF2DD4BF);  // Turquoise
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);     // Glass Card Border

  // Light Mode colors
  static const Color lightBackground = Color(0xFFF1F5F9); // Cool White
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimary = Color(0xFF4F46E5);    // Indigo
  static const Color lightSecondary = Color(0xFF0D9488);  // Teal/Turquoise
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // System Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // --- Legacy Aliases (to prevent breakage) ---
  // Mapping old Art Deco names to new Palette for backward compatibility
  static const Color artDecoGold = lightPrimary; // Use Primary as Gold replacement
  static const Color artDecoGoldLight = lightSecondary;
  static const Color artDecoTeal = darkBackground;
  static const Color artDecoTealLight = darkSecondary;
  static const Color artDecoCream = lightBackground;
  static const Color brandPrimary = lightPrimary;
  
  // --- Legacy Aliases (Maintained for compatibility) ---
  static const Color primaryBlue = lightPrimary; 
  static const Color trustGreen = success;
  static const Color riskRed = error;
  static const Color communityAmber = warning;
  static const Color textSecondary = lightTextSecondary;
  static const Color accentBlue = lightSecondary;
  
  // ---------------------------------------------

  // Background: Dark Mode (Solid Deep Blue)
  static BoxDecoration get premiumBackgroundDark {
    return const BoxDecoration(
      color: darkBackground,
    );
  }

  // Background: Light Mode (Solid Cool White)
  static BoxDecoration get premiumBackground {
    return const BoxDecoration(
      color: lightBackground,
    );
  }

  // Glass Theme - Light
  static ThemeData get glassTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: Colors.transparent,
      useMaterial3: true,
      
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        onPrimary: Colors.white,
        secondary: lightSecondary,
        onSecondary: Colors.white,
        surface: Colors.transparent,
        error: error,
        outline: lightBorder, // For borders
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.manrope(
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: lightTextPrimary,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.manrope(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: lightTextPrimary,
        ),
        headlineMedium: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: lightTextPrimary,
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: lightTextPrimary,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: lightTextSecondary,
        ),
        labelSmall: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: lightTextSecondary,
        ),
      ),
      
      iconTheme: const IconThemeData(
        color: lightTextPrimary,
        size: 24,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: lightTextPrimary),
        titleTextStyle: GoogleFonts.manrope(
          color: lightTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: lightPrimary,
        unselectedItemColor: lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary, 
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Soft corners
          ),
          textStyle: GoogleFonts.manrope(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  // Glass Theme - Dark
  static ThemeData get glassThemeDark {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkPrimary,
      scaffoldBackgroundColor: Colors.transparent,
      useMaterial3: true,
      
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        onPrimary: Colors.white,
        secondary: darkSecondary,
        onSecondary: Colors.black,
        surface: Colors.transparent,
        error: error,
        outline: darkBorder, // For borders
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.manrope(
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.manrope(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        headlineMedium: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: darkTextPrimary,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: darkTextSecondary,
        ),
        labelSmall: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: darkTextSecondary,
        ),
      ),
      
      iconTheme: const IconThemeData(
        color: darkTextPrimary,
        size: 24,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkTextPrimary),
        titleTextStyle: GoogleFonts.manrope(
          color: darkTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: darkPrimary,
        unselectedItemColor: darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary, 
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.manrope(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}


