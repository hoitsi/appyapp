import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTheme {
  // Art Deco Palette
  static const Color artDecoGold = Color(0xFFD4AF37);
  static const Color artDecoGoldLight = Color(0xFFFAD5A5);
  static const Color artDecoTeal = Color(0xFF0F4C5C); // Deep Teal
  static const Color artDecoTealLight = Color(0xFF1A7C88); // Lighter Teal
  static const Color artDecoCream = Color(0xFFF8EDEB);
  static const Color artDecoBlack = Colors.black;

  // Legacy Aliases (Mapped to Art Deco)
  static const Color primaryBlue = artDecoGold; 
  static const Color trustGreen = artDecoTealLight;
  static const Color riskRed = Color(0xFFCF6679);
  static const Color communityAmber = artDecoGoldLight;
  static const Color textSecondary = Color(0xB3F8EDEB); // Cream with opacity ~70%
  static const Color accentBlue = artDecoTealLight;
  static const Color warningOrange = artDecoGoldLight;


  // Background: Cream -> White (Linear) - Light Art Deco


  // Background: Cream -> White (Linear) - Light Art Deco
  static BoxDecoration get premiumBackground {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          artDecoCream,
        ],
      ),
    );
  }

  // Background: Dark -> Black (Linear) - Dark Art Deco
  static BoxDecoration get premiumBackgroundDark {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF1E1E1E), // Dark Grey
          Colors.black,
        ],
      ),
    );
  }

  // Glass Theme (Light Art Deco + Glassmorphism)
  static ThemeData get glassTheme {
    return ThemeData(
      brightness: Brightness.light, // Light Mode
      primaryColor: artDecoGold,
      scaffoldBackgroundColor: Colors.transparent,
      useMaterial3: true,
      
      colorScheme: const ColorScheme.light( // Light Scheme
        primary: artDecoGold, // CTA / Primary Action
        onPrimary: Colors.black, // Text on Gold
        secondary: artDecoTeal, // Secondary / Accent
        onSecondary: Colors.white,
        tertiary: artDecoTealLight,
        error: Color(0xFFCF6679),
        surface: Colors.transparent,
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.manrope(
          fontSize: 48,
          fontWeight: FontWeight.w600, // Semibold
          color: artDecoTeal, // Dark Teal Text
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.manrope(
          fontSize: 32,
          fontWeight: FontWeight.w600, // Semibold
          color: artDecoTeal, // Dark Teal Text
        ),
        headlineMedium: GoogleFonts.manrope(
          fontSize: 22, // Updated
          fontWeight: FontWeight.w600, // Semibold
          color: artDecoTeal, // Dark Teal Text
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          color: Colors.black87, // Readable Black
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 15, // Updated
          fontWeight: FontWeight.w400, // Regular
          color: Colors.black87, // Readable Black
        ),
        labelSmall: GoogleFonts.lato(
          fontSize: 12, // Updated
          fontWeight: FontWeight.w400, // Regular
          color: artDecoTealLight,
        ),
      ),
      
      iconTheme: const IconThemeData(
        color: artDecoTeal, // Dark Icons
        size: 24,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: artDecoTeal),
        titleTextStyle: GoogleFonts.manrope(
          color: artDecoTeal,
          fontSize: 24,
          fontWeight: FontWeight.w600, // Semibold
          letterSpacing: 0.5, // Reduced letter spacing for sans-serif
        ),
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: artDecoTeal, // Dark Teal for active
        unselectedItemColor: Colors.grey, // Grey for inactive
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: artDecoGold, // CTA
          foregroundColor: Colors.black, // High contrast on Gold
          elevation: 4, // Extruded look
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Sharp corners
          ),
          textStyle: GoogleFonts.manrope(
            fontWeight: FontWeight.w600, // Semibold
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: artDecoGold,
        foregroundColor: Colors.black,
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: artDecoTeal, // Links/Text Buttons
        ),
      ),
    );
  }
  // Dark Glass Theme (Dark Art Deco + Glassmorphism)
  static ThemeData get glassThemeDark {
    return ThemeData(
      brightness: Brightness.dark, // Dark Mode
      primaryColor: artDecoGold,
      scaffoldBackgroundColor: Colors.transparent,
      useMaterial3: true,
      
      colorScheme: const ColorScheme.dark( // Dark Scheme
        primary: artDecoGold, // CTA / Primary Action
        onPrimary: Colors.black, // Low contrast text on Gold
        secondary: artDecoTeal, // Secondary
        onSecondary: Colors.white,
        tertiary: artDecoTealLight,
        error: Color(0xFFCF6679),
        surface: Colors.transparent,
      ),
      
      textTheme: TextTheme(
        displayLarge: GoogleFonts.manrope(
          fontSize: 48,
          fontWeight: FontWeight.w600, // Semibold
          color: artDecoGold, // Gold Text
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.manrope(
          fontSize: 32,
          fontWeight: FontWeight.w600, // Semibold
          color: artDecoGold, // Gold Text
        ),
        headlineMedium: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w600, // Semibold
          color: artDecoGold, // Gold Text
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          color: artDecoCream, // Readable Cream
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 15,
          fontWeight: FontWeight.w400, // Regular
          color: artDecoCream, // Readable Cream
        ),
        labelSmall: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w400, // Regular
          color: artDecoGoldLight,
        ),
      ),
      
      iconTheme: const IconThemeData(
        color: artDecoGold, // Gold Icon
        size: 24,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: artDecoGold),
        titleTextStyle: GoogleFonts.manrope(
          color: artDecoGold,
          fontSize: 24,
          fontWeight: FontWeight.w600, // Semibold
          letterSpacing: 0.5,
        ),
      ),
      
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black.withValues(alpha: 0.5), // Semi-transparent black
        selectedItemColor: artDecoGold, 
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: artDecoGold, 
          foregroundColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: GoogleFonts.manrope(
            fontWeight: FontWeight.w600, // Semibold
            letterSpacing: 0.5,
          ),
        ),
      ),
      
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: artDecoGold,
        foregroundColor: Colors.black,
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: artDecoGold,
        ),
      ),
    );
  }

  static const Color textPrimary = artDecoTeal;

  // Brand Palette
  static const Color brandPrimary = artDecoGold;
  static const Color brandBackground = Color(0xFFEDEDED);
  static const Color textGrey = Color(0xFF999999);
  static const Color brandWhite = Colors.white;

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: brandPrimary,
      scaffoldBackgroundColor: brandBackground,
      fontFamily: 'Lato',
      useMaterial3: true,
      
      colorScheme: const ColorScheme.light(
        primary: brandPrimary,
        secondary: brandPrimary,

        surface: brandBackground,
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: brandBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: brandWhite,
        selectedItemColor: brandPrimary,
        unselectedItemColor: textGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600), // Bumped 20->22
        bodyLarge: TextStyle(color: Colors.black, fontSize: 16), // Keep 16
        bodyMedium: TextStyle(color: Colors.black87, fontSize: 15), // Bumped 14->15
        labelSmall: TextStyle(color: textGrey, fontSize: 12), // Bumped 10->12 for accessibility
      ),
    );
  }
}


