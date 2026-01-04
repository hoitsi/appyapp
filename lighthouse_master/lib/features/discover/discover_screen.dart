import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Discover', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppTheme.artDecoTeal),
          onPressed: () {},
        ),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('MEDIA'),
          _buildListItem(
            icon: Icons.camera_alt,
            label: 'Moments',
            iconColor: AppTheme.brandPrimary,
            badgeCount: 4,
          ),
          
          _buildSectionHeader('ADDITIONAL OPTIONS'),
          _buildListItem(
            icon: Icons.qr_code_scanner,
            label: 'Scan with QR code',
            iconColor: AppTheme.brandPrimary,
          ),
          Divider(height: 1, indent: 56, color: Colors.black.withValues(alpha: 0.1)),
          _buildListItem(
            icon: Icons.phone_iphone, // Shake approx
            label: 'Shaking',
            iconColor: Colors.blue,
          ),
          
          _buildSectionHeader('LOCATION'),
          _buildListItem(
            icon: Icons.location_on,
            label: 'Users nearby',
            iconColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListItem({
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
            child: Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87)),
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
          const Icon(Icons.chevron_right, color: Colors.black54),
        ],
      ),
    );
  }
}
