import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/repositories/app_repository.dart';
import '../../domain/entities/app_model.dart';
import 'guide_view.dart';
import '../../theme/app_theme.dart';

// Simple FutureProvider for details
final appDetailsProvider = FutureProvider.family<AppModel, String>((ref, appId) async {
  final repo = ref.watch(appRepositoryProvider);
  return repo.getAppDetails(appId);
});

class AppDetailsScreen extends ConsumerWidget {
  final String appId;

  const AppDetailsScreen({super.key, required this.appId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetails = ref.watch(appDetailsProvider(appId));

    return Scaffold(
      appBar: AppBar(title: const Text("App Details")),
      body: asyncDetails.when(
        data: (app) => _buildContent(context, app),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppModel app) {
    final isApk = app.isApk;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: app.iconUrl.isNotEmpty
                      ? CachedNetworkImage(imageUrl: app.iconUrl, fit: BoxFit.cover, errorWidget: (_, _, _) => const SizedBox())
                      : const Icon(Icons.apps),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.shield, color: AppTheme.trustGreen, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Trust Score: ${app.humanTrustScore}',
                          style: const TextStyle(color: AppTheme.trustGreen, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 32),

          // Description
          Text('About this app', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(app.description, style: TextStyle(color: Colors.grey[700], height: 1.5)),
          const SizedBox(height: 32),

          // Main Call to Action
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (isApk) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => GuideView(downloadUrl: app.downloadUrl),
                  );
                } else {
                  // Open URL for Official Store
                   // For now mock
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening Official Store...')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isApk ? 'Download APK (Secure)' : 'Get from Store',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          
          if (isApk) ...[
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Community Vetted • Scanned for Malware',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
