import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import 'glass_container.dart';

class UnifiedSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final bool showFeatureIndicators;

  const UnifiedSearchBar({
    super.key,
    this.hintText = 'Search',
    this.controller,
    this.onSubmitted,
    this.showFeatureIndicators = false,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'global_search_bar',
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderGradient: Theme.of(context).brightness == Brightness.dark
        ? LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.30), // Increased from 0.15
              Colors.white.withValues(alpha: 0.10), // Increased from 0.05
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              AppTheme.brandPrimary.withValues(alpha: 0.5),
              Colors.teal.withValues(alpha: 0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 18),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              if (onSubmitted != null) {
                onSubmitted!(value);
              } else if (value.isNotEmpty) {
                 context.push('/search?q=${Uri.encodeComponent(value)}');
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Theme.of(context).hintColor, fontSize: 18),
              prefixIcon: const Icon(Icons.search, color: AppTheme.artDecoTeal, size: 28),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          if (showFeatureIndicators)
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFeatureIcon(context, icon: Icons.language, label: 'Web'),
                  _buildFeatureIcon(context, icon: Icons.image, label: 'Image'),
                  _buildFeatureIcon(context, icon: Icons.mic, label: 'Voice'),
                  _buildFeatureIcon(context, icon: Icons.qr_code_scanner, label: 'Scan'),
                ],
              ),
            ),
        ],
      ),
      ),
    );
  }

  Widget _buildFeatureIcon(BuildContext context, {required IconData icon, required String label}) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppTheme.artDecoTeal),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.labelSmall?.color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
