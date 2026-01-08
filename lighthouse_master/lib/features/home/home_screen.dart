import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/theme_provider.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/glass_container.dart';
import '../../presentation/widgets/app_logo.dart';
import '../../presentation/widgets/unified_search_bar.dart';
import 'widgets/quick_action_grid.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Colors.transparent, // Glass background shows through
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 24.0), // Less top padding to move up
                  child: AppLogo(size: 110), // Increased size (80 * 1.375 = 110)
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Search Bar in Glass
              // Unified Glass Search Bar
              UnifiedSearchBar(
                controller: _searchController,
                hintText: 'Search apps, web, AI...',
                showFeatureIndicators: true,
                onSubmitted: (value) {
                   if (value.isNotEmpty) {
                     context.push('/search?q=${Uri.encodeComponent(value)}');
                   }
                },
              ),
              
              const SizedBox(height: 32),
              
              // Quick Access Grid
              const QuickActionGrid(),
              
              const SizedBox(height: 32),
              
              // Recent Activity Section
              Text(
                'RECENT ACTIVITY',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 16),
              
              GlassContainer(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppTheme.brandPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.mark_chat_unread, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                '3 unread messages',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                              ),
                              Text(
                                'Sarah Chen, Mind Studios, +1',
                                style: TextStyle(color: Colors.black54, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.brandPrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          context.go('/chats');
                        },
                        child: const Text('View Chats', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            
              const SizedBox(height: 80), // Bottom padding for floating nav bar
            ],
          ),
        ),
            // Dark Mode Toggle (Local to Home Screen)
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {
                    ref.read(themeProvider.notifier).toggle();
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSearchHint(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.black54),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
