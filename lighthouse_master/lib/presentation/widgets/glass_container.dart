import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? blur;
  final double? opacity;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool showBorder;
  final bool showShadow;
  final Gradient? borderGradient; // Added

  const GlassContainer({
    super.key,
    required this.child,
    this.blur,
    this.opacity,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onTap,
    this.showBorder = true,
    this.showShadow = true,
    this.borderGradient, // Added
  });

  @override
  Widget build(BuildContext context) {
    // Glassmorphism Spec: Blur 20px
    final double blurValue = blur ?? 20.0; 
    
    // Glassmorphism Spec: Opacity 0.6 - 0.8
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double defaultOpacity = isDark ? 0.60 : 0.70;
    final double opacityValue = opacity ?? defaultOpacity;
    
    final Color baseColor = color ?? (isDark ? AppTheme.darkSurface : AppTheme.lightSurface);
    final BorderRadius borderR = borderRadius ?? BorderRadius.circular(16); // Soft 16px corners

    // Glassmorphism Spec: 1px Border
    final Color borderColor = isDark ? AppTheme.darkBorder : AppTheme.lightBorder;

    Widget container = Container(
      margin: margin,
      decoration: showShadow ? BoxDecoration(
        borderRadius: borderR,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05), // Softer shadow for light mode
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ) : null,
      child: ClipRRect(
        borderRadius: borderR,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurValue / 2, // Flutter sigma is ~ half of CSS blur radius
            sigmaY: blurValue / 2,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: baseColor.withValues(alpha: opacityValue),
              borderRadius: borderR,
              // Glassmorphism Spec: 1px stylized border
              border: (showBorder && borderGradient == null) ? Border.all(
                color: borderColor.withValues(alpha: 0.5), 
                width: 1.0,
              ) : (showBorder && borderGradient != null) ? Border.all(color: Colors.transparent) : null,
              gradient: borderGradient, // Optional overlay gradient
            ),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: container,
      );
    }
    return container;
  }
}

// Glass Navigation Bar
class GlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const GlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      borderRadius: BorderRadius.circular(30),
      // Higher opacity for heavy usage area
      opacity: 0.8,
      borderGradient: Theme.of(context).brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.25),
              Colors.white.withValues(alpha: 0.10),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = index == currentIndex;
          
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppTheme.artDecoGold.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4), // Sharp corners
                border: isSelected ? Border.all(color: AppTheme.artDecoGold.withValues(alpha: 0.5)) : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    (item.icon is Icon) ? (item.icon as Icon).icon : Icons.circle,
                    // Use Teal for Active/Inactive (Active: Gold, Inactive: Teal/Grey)
                    color: isSelected 
                      ? (Theme.of(context).brightness == Brightness.dark ? AppTheme.artDecoGold : AppTheme.artDecoGold)
                      : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : AppTheme.artDecoTeal.withValues(alpha: 0.7)),
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label ?? '',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected 
                        ? AppTheme.artDecoGold 
                        : (Theme.of(context).brightness == Brightness.dark ? Colors.white70 : AppTheme.artDecoTeal.withValues(alpha: 0.7)),
                      fontFamily: GoogleFonts.manrope().fontFamily ?? 'Manrope',
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
