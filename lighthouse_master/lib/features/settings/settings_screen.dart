import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/widgets/glass_container.dart';
import '../../presentation/providers/user_provider.dart';
import '../../theme/app_theme.dart';
import '../premium/paywall_view.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Theme(
      data: AppTheme.glassTheme,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          decoration: AppTheme.premiumBackground,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Pro Status Card
                if (!userState.isPro)
                  GlassContainer(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PaywallView()),
                      );
                    },
                    padding: const EdgeInsets.all(20),
                    color: AppTheme.accentBlue,
                    opacity: 0.15,
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.accentBlue.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.diamond,
                            color: AppTheme.accentBlue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upgrade to Pro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Unlock all features',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: AppTheme.accentBlue,
                        ),
                      ],
                    ),
                  ),
                
                if (!userState.isPro) const SizedBox(height: 24),
                
                // Account Section
                _buildSectionTitle(context, 'Account'),
                const SizedBox(height: 12),
                _buildSettingsTile(
                  context,
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildSettingsTile(
                  context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {},
                ),
                
                const SizedBox(height: 24),
                
                // Preferences Section
                _buildSectionTitle(context, 'Preferences'),
                const SizedBox(height: 12),
                _buildSettingsTile(
                  context,
                  icon: Icons.palette_outlined,
                  title: 'Appearance',
                  subtitle: 'Dark',
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildSettingsTile(
                  context,
                  icon: Icons.security_outlined,
                  title: 'Privacy',
                  onTap: () {},
                ),
                
                const SizedBox(height: 24),
                
                // About Section
                _buildSectionTitle(context, 'About'),
                const SizedBox(height: 12),
                _buildSettingsTile(
                  context,
                  icon: Icons.info_outline,
                  title: 'Version',
                  subtitle: '1.0.0',
                  showChevron: false,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildSettingsTile(
                  context,
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _buildSettingsTile(
                  context,
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool showChevron = true,
  }) {
    return GlassContainer(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 14,
              ),
            ),
          if (showChevron) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.3),
              size: 20,
            ),
          ],
        ],
      ),
    );
  }
}
