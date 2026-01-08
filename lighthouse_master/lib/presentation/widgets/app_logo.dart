import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  final double size;
  
  const AppLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color primary = Theme.of(context).primaryColor;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Center(
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              primary,
              secondary,
              if (isDark) Colors.white else primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        child: Text(
          "'appyapp",
          style: GoogleFonts.greatVibes(
            fontSize: size * 0.6, // Large fancy font
            fontWeight: FontWeight.bold,
            color: Colors.white, // Required for ShaderMask to apply
            shadows: [
              Shadow(
                color: primary.withValues(alpha: 0.5),
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
              if (isDark)
                Shadow(
                  color: secondary.withValues(alpha: 0.3),
                  blurRadius: 40,
                  offset: const Offset(0, 0),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
