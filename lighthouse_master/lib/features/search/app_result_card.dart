import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/glass_container.dart';
import '../details/app_details_screen.dart';
import '../../domain/entities/app_model.dart';

class AppResultCard extends StatelessWidget {
  final AppModel appData;

  const AppResultCard({super.key, required this.appData});

  @override
  Widget build(BuildContext context) {
    final int trustScore = appData.humanTrustScore;
    final bool isApk = appData.isApk;
    final String source = appData.source;
    final String security = appData.securityReputation;
    
    // Determine color based on Trust Score
    Color scoreColor;
    if (trustScore >= 90) {
      scoreColor = AppTheme.trustGreen;
    } else if (trustScore >= 70) {
      scoreColor = AppTheme.communityAmber;
    } else {
      scoreColor = AppTheme.riskRed;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GlassContainer(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppDetailsScreen(appId: appData.id),
            ),
          );
        },
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppTheme.artDecoTeal.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.textSecondary.withValues(alpha: 0.1), width: 0.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: appData.iconUrl.isNotEmpty && appData.iconUrl.startsWith('http') 
                  ? CachedNetworkImage(
                      imageUrl: appData.iconUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(Icons.grid_view, size: 32, color: AppTheme.textSecondary),
                    )
                  : const Icon(Icons.grid_view, size: 32, color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(width: 16),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appData.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.artDecoTeal),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    appData.description,
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  
                  // Badges
                  Wrap(
                    spacing: 8,
                    children: [
                      _Badge(
                        text: source,
                        color: isApk ? AppTheme.communityAmber : AppTheme.primaryBlue,
                      ),
                      if (security != 'Safe')
                        _Badge(
                          text: security,
                          color: AppTheme.riskRed,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 8),

            // Trust Score Circle
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: scoreColor, width: 3),
                    color: scoreColor.withValues(alpha: 0.1), // Subtle glow inside
                  ),
                  child: Center(
                    child: Text(
                      '$trustScore',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        color: scoreColor,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Trust',
                  style: TextStyle(fontSize: 10, color: AppTheme.textSecondary.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}
