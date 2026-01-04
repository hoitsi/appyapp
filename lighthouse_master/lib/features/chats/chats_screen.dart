import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/glass_container.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
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
        title: Row(
          children: [
            const Expanded(
              child: Text('Chats', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppTheme.artDecoTeal)),
            ),
            TextButton(
              onPressed: () {}, 
              child: const Text('Invite friends +', style: TextStyle(color: AppTheme.artDecoTealLight, fontSize: 13))
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.edit_square, color: AppTheme.artDecoTeal), onPressed: () {}),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TextField(
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
                  prefixIcon: Icon(Icons.search, size: 20, color: Colors.black.withValues(alpha: 0.6)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Quick Action Buttons
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Unified Theme Colors with Image Backgrounds
                _buildQuickAction(
                  'GROUP CHAT', 
                  Icons.forum_rounded, 
                  'assets/images/chat_card_bg.png'
                ), 
                _buildQuickAction(
                  'ADD CONTACTS', 
                  Icons.person_add_rounded, 
                  'assets/images/contact_card_bg.png'
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.black.withValues(alpha: 0.1)),
          // ... rest of list ...
          // Chat List
          Expanded(
            child: ListView(
              children: [
                 _buildChatItem(
                   name: 'Mind Studios',
                   message: 'Albert Townsend: When I was a young man...',
                   time: '07:02PM',
                   avatarColor: Colors.redAccent,
                   isVerified: false,
                 ),
                 _buildChatItem(
                   name: 'WeChat Team',
                   message: 'Welcome to WeChat! Connect with the world...',
                   time: '07:17PM',
                   avatarColor: AppTheme.brandPrimary,
                   isVerified: true,
                 ),
                 _buildChatItem(
                   name: 'Darrell McCarthy',
                   message: '[Photo]',
                   time: 'Yesterday',
                   avatarColor: Colors.purpleAccent,
                   isVerified: false,
                 ),
                 _buildChatItem(
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

  Widget _buildQuickAction(String label, IconData icon, String imagePath) {
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
              child: Icon(icon, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem({
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
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                      if (isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.check_circle, color: AppTheme.artDecoTeal, size: 14),
                      ],
                      const Spacer(),
                      Text(time, style: TextStyle(color: Colors.black.withValues(alpha: 0.5), fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(color: Colors.black.withValues(alpha: 0.6), fontSize: 14),
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
