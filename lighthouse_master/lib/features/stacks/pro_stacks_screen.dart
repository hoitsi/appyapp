import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Added for LogicalKeyboardKey
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/widgets/glass_container.dart';
import '../../presentation/widgets/ambient_background.dart';
import '../../data/repositories/app_repository.dart';
import '../../theme/app_theme.dart';

// Simple provider for stacks
final proStacksProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = ref.read(appRepositoryProvider);
  return repo.getProStacks();
});

class ProStacksScreen extends ConsumerWidget {
  const ProStacksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stacksAsync = ref.watch(proStacksProvider);

    return FocusScope(
      autofocus: true,
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): () => Navigator.of(context).pop(),
        },
        child: Theme(
          data: AppTheme.glassTheme,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const BackButton(color: Colors.white),
              title: const Text("Pro Stacks", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            body: AmbientBackground(
              child: SafeArea(
                child: stacksAsync.when(
                  data: (stacks) => ListView.builder(
                    padding: const EdgeInsets.all(16), // Match standard list padding
                    itemCount: stacks.length,
                    itemBuilder: (context, index) {
                      final stack = stacks[index];
                      return _buildStackCard(context, stack);
                    },
                  ),
                  loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
                  error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStackCard(BuildContext context, Map<String, dynamic> stack) {
    final List<String> apps = List<String>.from(stack['apps'] ?? []);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12), // Standard list spacing
      child: GlassContainer(
        padding: const EdgeInsets.all(16), // Standard card padding
        child: Column(
          children: [
             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon (Standard Size 64px)
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppTheme.warningOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.warningOrange.withValues(alpha: 0.3), width: 0.5),
                  ),
                  child: Icon(Icons.layers, color: AppTheme.warningOrange, size: 32),
                ),
                const SizedBox(width: 16),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stack['title'] ?? 'Untitled Stack',
                        style: const TextStyle(
                          fontSize: 16, // Standard Title Size
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stack['description'] ?? '',
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13, // Standard Body Size
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),

            // App Chips (Refined)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: apps.map((app) => _buildAppChip(app)).toList(),
              ),
            ),
            
            const SizedBox(height: 16),

            // Action Button (Full Width, Standard Height)
            GlassContainer(
              color: AppTheme.accentBlue,
              opacity: 0.9,
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              showShadow: false,
              onTap: () {
                // Future: Install all functionality
              },
              child: const Center(
                child: Text(
                  "Install Stack",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppChip(String appName) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), // Compact chips
      decoration: BoxDecoration(
        color: AppTheme.textPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.1)),
      ),
      child: Text(
        appName,
        style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}
