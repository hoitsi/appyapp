import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AmbientBackground extends StatelessWidget {
  final Widget child;

  const AmbientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Base Dark Background (Radial Art Deco)
        Container(
          decoration: AppTheme.premiumBackground,
        ),
        
        // 2. Subtle Animated Mesh/Grain (Optional, keeping simple for now)
        // could add a subtle pattern here later
        
        // 3. Child Content
        child,
      ],
    );
  }

  // Remove _buildBlob logic as it is not needed for Art Deco clean look
}
