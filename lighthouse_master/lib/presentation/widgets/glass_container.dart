import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

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
    final double blurValue = blur ?? 20.0; // Frosted glass
    final double opacityValue = opacity ?? 0.6; // Increased opacity for Light Mode visibility
    final Color baseColor = color ?? Colors.white;
    final BorderRadius borderR = borderRadius ?? BorderRadius.circular(4); // Sharp 4px Art Deco radius

    Widget container = Container(
      margin: margin,
      decoration: showShadow ? BoxDecoration(
        borderRadius: borderR,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1), // Much lighter shadow
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ) : null,
      child: ClipRRect(
        borderRadius: borderR,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurValue / 2,
            sigmaY: blurValue / 2,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: baseColor.withValues(alpha: opacityValue),
              borderRadius: borderR,
              border: (showBorder && borderGradient == null) ? Border.all(
                color: AppTheme.artDecoGold.withValues(alpha: 0.3), // Gold borders
                width: 1.0,
              ) : (showBorder && borderGradient != null) ? Border.all(color: Colors.transparent) : null, // Handle gradient border differently if needed, or just standard border
              // Actually, Flutter's BoxDecoration doesn't support 'border' property with Gradient directly. 
              // We usually simulate it or use 'border' with color. 
              // But 'decoration: BoxDecoration(border: ...)' takes a Border object.
              // To support gradient border, we often need a separate wrapper or Painter.
              // For simplicity, let's assume standard usage or just omit 'border' if gradient is meant for background?
              // The user code passed 'borderGradient' to GlassContainer constructor, likely intended to be used as BORDER or maybe BACKGROUND gradient?
              // The user code in HomeScreen passed:
              // borderGradient: LinearGradient(...)
              // Let's assume it was meant to be the 'gradient' of the container itself (background gradient overlay)?
              // But the name is 'borderGradient'.
              // Wait, I am the one who wrote the HomeScreen code.
              // I passed 'borderGradient' to GlassContainer.
              // Standard GlassContainer doesn't have it.
              // If I want a gradient BORDER, it's complex.
              // If I want a gradient BACKGROUND, I should use 'color' or new 'gradient' property.
              // In HomeScreen, I likely meant 'gradient' for the container's background tint.
              // Because I used keys like 'colors' inside LinearGradient.
              // Let's rename parameter to 'gradient' in GlassContainer to match standard Flutter container usage?
              // Or if I really meant Border Gradient, I need a CustomPainter.
              // Let's change GlassContainer to accept 'gradient' which overrides the default white gradient.
              gradient: borderGradient ?? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.7),
                  Colors.white.withValues(alpha: 0.3),
                ],
                stops: const [0.0, 1.0],
              ),
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
                    (item.icon as Icon).icon,
                    // Use Teal for Active/Inactive (Active: Gold, Inactive: Teal/Grey)
                    color: isSelected ? AppTheme.artDecoGold : AppTheme.artDecoTeal.withValues(alpha: 0.7),
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label ?? '',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? AppTheme.artDecoGold : AppTheme.artDecoTeal.withValues(alpha: 0.7),
                      fontFamily: 'Playfair Display', // Art Deco font
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
