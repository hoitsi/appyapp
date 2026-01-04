import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/unified_search_bar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Discover', style: TextStyle(color: Theme.of(context).textTheme.headlineMedium?.color, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppTheme.artDecoTeal),
          onPressed: () {},
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: UnifiedSearchBar(
              hintText: 'Search Discover',
              showFeatureIndicators: true, // Exact match to Home
            ),
          ),
          _buildSectionHeader(context, 'MEDIA'),
          _buildListItem(
            context: context,
            icon: Icons.camera_alt,
            label: 'Moments',
            iconColor: AppTheme.brandPrimary,
            badgeCount: 4,
          ),
          
          _buildSectionHeader(context, 'ADDITIONAL OPTIONS'),
          _buildListItem(
            context: context,
            icon: Icons.qr_code_scanner,
            label: 'Scan with QR code',
            iconColor: AppTheme.brandPrimary,
          ),
          Divider(height: 1, indent: 56, color: Theme.of(context).dividerColor),
          _buildListItem(
            context: context,
            icon: Icons.phone_iphone, // Shake approx
            label: 'Shaking',
            iconColor: Colors.blue,
          ),
          
          _buildSectionHeader(context, 'LOCATION'),
          _buildListItem(
            context: context,
            icon: Icons.location_on,
            label: 'Users nearby',
            iconColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.labelSmall?.color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color iconColor,
    int? badgeCount,
  }) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color)),
          ),
          if (badgeCount != null) ...[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                badgeCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
        ],
      ),
    );
  }
}
