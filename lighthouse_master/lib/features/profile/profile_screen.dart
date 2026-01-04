import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/glass_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Profile Header
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.person, size: 40, color: Colors.black54),
                  ),
                  const SizedBox(width: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alex Johnson', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                      SizedBox(height: 4),
                      Text('ID: alexj_2024', style: TextStyle(color: Colors.black54, fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.qr_code, color: Colors.black54),
                  const Icon(Icons.chevron_right, color: Colors.black54),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Stats Grid
            GlassContainer(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat('246', 'Posts'),
                  _buildStat('1.2k', 'Friends'),
                  _buildStat('342', 'Moments'),
                ],
              ),
            ),
            
            _buildSectionHeader('ACCOUNT'),
            _buildMenuItem(Icons.notifications, 'Notifications', Colors.orange),
            Divider(height: 1, indent: 56, color: Colors.black.withValues(alpha: 0.1)),
            _buildMenuItem(Icons.lock, 'Privacy', Colors.blue),
            Divider(height: 1, indent: 56, color: Colors.black.withValues(alpha: 0.1)),
            _buildMenuItem(Icons.palette, 'Appearance', Colors.purple),
            
            _buildSectionHeader('SUPPORT'),
            _buildMenuItem(Icons.help, 'Help Center', AppTheme.brandPrimary),
            Divider(height: 1, indent: 56, color: Colors.black.withValues(alpha: 0.1)),
            _buildMenuItem(Icons.settings, 'Settings', Colors.grey),
            
            const SizedBox(height: 32),
            
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GlassContainer(
                color: Colors.red.withValues(alpha: 0.1),
                onTap: () {},
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 20, color: Colors.redAccent),
                    SizedBox(width: 8),
                    Text('Log Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
      ],
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

  Widget _buildMenuItem(IconData icon, String label, Color color) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 16, color: Colors.black87))),
          const Icon(Icons.chevron_right, color: Colors.black54),
        ],
      ),
    );
  }
}
