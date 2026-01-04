import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/glass_container.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent, // Glass background shows through
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.asset(
                    'assets/images/logo_full_header.jpg',
                    height: 104, // Increased by 30% (was 80)
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Search Bar in Glass
              GlassContainer(
                borderRadius: BorderRadius.circular(24), // More rounded
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // More internal space
                borderGradient: LinearGradient(
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
                      controller: _searchController,
                      style: const TextStyle(color: Colors.black87, fontSize: 18), // Larger text
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                         if (value.isNotEmpty) {
                           context.push('/search?q=${Uri.encodeComponent(value)}');
                         }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search apps, web, AI...',
                        hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.5), fontSize: 18),
                        prefixIcon: const Icon(Icons.search, color: AppTheme.artDecoTeal, size: 28),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                    // Feature Indicators
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSearchHint(Icons.language, 'Web'),
                          _buildSearchHint(Icons.shopping_bag, 'Store'),
                          _buildSearchHint(Icons.download, 'APKs'),
                          _buildSearchHint(Icons.auto_awesome, 'AI'),
                        ],
                      ),
                    ),
                  ],
                ),
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
