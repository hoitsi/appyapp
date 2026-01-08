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
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(Icons.person, size: 40, color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.5)),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alex Johnson', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.displayMedium?.color)),
                      SizedBox(height: 4),
                      Text('ID: alexj_2024', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.qr_code, color: Theme.of(context).iconTheme.color),
          Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.5)),
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
                  _buildStat(context, '246', 'Posts'),
                  _buildStat(context, '1.2k', 'Friends'),
                  _buildStat(context, '342', 'Moments'),
                ],
              ),
            ),
            
            _buildSectionHeader(context, 'ACCOUNT'),
            _buildMenuItem(context, Icons.notifications, 'Notifications', Colors.orange),
            Divider(height: 1, indent: 56, color: Theme.of(context).dividerColor),
            _buildMenuItem(context, Icons.lock, 'Privacy', Colors.blue),
            Divider(height: 1, indent: 56, color: Theme.of(context).dividerColor),
            _buildMenuItem(context, Icons.palette, 'Appearance', Colors.purple),
            
            _buildSectionHeader(context, 'SUPPORT'),
            _buildMenuItem(context, Icons.help, 'Help Center', AppTheme.brandPrimary),
            Divider(height: 1, indent: 56, color: Theme.of(context).dividerColor),
            _buildMenuItem(context, Icons.settings, 'Settings', Colors.grey),
            
            const SizedBox(height: 32),
            
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GlassContainer(
                color: Theme.of(context).colorScheme.error.withValues(alpha: 0.8), // Solid Red (Glassy)
                onTap: () {},
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 20, color: Colors.white), // White Icon
                    SizedBox(width: 8),
                    Text('Log Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // White Text
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

  Widget _buildStat(BuildContext context, String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.displayMedium?.color)),
        Text(label, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 12)),
      ],
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

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, Color color) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color))),
          Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.5)),
        ],
      ),
    );
  }
}
