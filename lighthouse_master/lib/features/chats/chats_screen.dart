import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/glass_container.dart';
import '../../presentation/widgets/unified_search_bar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppTheme.artDecoTeal),
          onPressed: () {},
        ),
            title: const Text('Chats', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppTheme.artDecoTeal)),
          actions: [
            IconButton(icon: const Icon(Icons.edit_square, color: AppTheme.artDecoTeal), onPressed: () {}),
          ],
        ),
        body: Column(
          children: [
            // Search Bar (Moved to body for better spacing)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: UnifiedSearchBar(
                hintText: 'Search',
                showFeatureIndicators: true, // Exact match to Home
              ),
            ),
            // Quick Action Buttons
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [
                  // Unified Theme Colors with Image Backgrounds
                  _buildQuickAction(
                    context,
                    'GROUP CHAT', 
                    Icons.forum_rounded, 
                    'assets/images/chat_card_bg.png'
                  ),
                  _buildQuickAction(
                    context,
                    'ADD CONTACTS', 
                    Icons.person_add_rounded, 
                    'assets/images/contact_card_bg.png'
                  ),
                  _buildQuickAction(
                    context,
                    'START CHAT', 
                    Icons.chat_bubble_rounded, 
                    'assets/images/favorites_card_bg.png'
                  ),
                ],
              ),
            ),
          Divider(height: 1, color: Theme.of(context).dividerColor),
          // ... rest of list ...
          // Chat List
          Expanded(
            child: ListView(
              children: [
                 _buildChatItem(
                   context: context,
                   name: 'Mind Studios',
                   message: 'Albert Townsend: When I was a young man...',
                   time: '07:02PM',
                   avatarColor: Colors.redAccent,
                   isVerified: false,
                 ),
                 _buildChatItem(
                   context: context,
                   name: 'WeChat Team',
                   message: 'Welcome to WeChat! Connect with the world...',
                   time: '07:17PM',
                   avatarColor: AppTheme.brandPrimary,
                   isVerified: true,
                 ),
                 _buildChatItem(
                   context: context,
                   name: 'Darrell McCarthy',
                   message: '[Photo]',
                   time: 'Yesterday',
                   avatarColor: Colors.purpleAccent,
                   isVerified: false,
                 ),
                 _buildChatItem(
                   context: context,
                   name: 'Anthony Mullins',
                   message: 'Great, see you then!',
                   time: 'Yesterday',
                   avatarColor: Colors.blueAccent,
                   isVerified: false,
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String label, IconData icon, String imagePath) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 56, // Slightly larger for better image visibility
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Container( // Scrim + Icon
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withValues(alpha: 0.1), Colors.black.withValues(alpha: 0.4)],
                ),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: AppTheme.artDecoGold, size: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.labelSmall?.color),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem({
    required BuildContext context,
    required String name,
    required String message,
    required String time,
    required Color avatarColor,
    required bool isVerified,
  }) {
    // Immersive Glass List Item
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // Spacing between items
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.all(12),
        // Gradient Border like Search Bar
        borderGradient: LinearGradient(
          colors: [
            AppTheme.artDecoGold.withValues(alpha: 0.3),
            AppTheme.artDecoTeal.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: avatarColor.withValues(alpha: 0.1), // Subtle background
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: avatarColor.withValues(alpha: 0.3)),
              ),
              child: Icon(Icons.person, color: avatarColor, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color)),
                      if (isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.check_circle, color: AppTheme.artDecoTeal, size: 14),
                      ],
                      const Spacer(),
                      Text(time, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7), fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.8), fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
