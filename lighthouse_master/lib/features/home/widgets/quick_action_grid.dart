import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../../presentation/widgets/glass_container.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  final List<QuickActionItem> _items = const [
    QuickActionItem(
      icon: Icons.chat_bubble, 
      label: 'Chats', 
      color1: Color(0xFF07C160), 
      color2: Color(0xFF05A050),
      imagePath: 'assets/images/chat_card_bg.png',
      route: '/chats',
    ),
    QuickActionItem(
      icon: Icons.group, 
      label: 'Contacts', 
      color1: Colors.blue, 
      color2: Colors.blueAccent, 
      imagePath: 'assets/images/contact_card_bg.png', // Added Image
      route: '/contacts',
    ),
    QuickActionItem(
      icon: Icons.explore, 
      label: 'Discover', 
      color1: Colors.purple, 
      color2: Colors.deepPurple,
      imagePath: 'assets/images/discover_card_bg.png', // Added Image
      route: '/discover',
    ),
    QuickActionItem(
      icon: Icons.camera_alt, 
      label: 'Moments', 
      color1: Colors.pink, 
      color2: Colors.pinkAccent,
      imagePath: 'assets/images/moments_card_bg.jpg',
    ),
    QuickActionItem(
      icon: Icons.account_balance_wallet, 
      label: 'Wallet', 
      color1: Colors.orange, 
      color2: Colors.deepOrange,
      imagePath: 'assets/images/wallet_card_bg.png', // Added Image
    ),
    QuickActionItem(
      icon: Icons.qr_code_scanner, 
      label: 'Scan QR', 
      color1: Colors.teal, 
      color2: Colors.tealAccent,
      imagePath: 'assets/images/scan_qr_card_bg.png',
    ),
    QuickActionItem(
      icon: Icons.location_on, 
      label: 'Nearby', 
      color1: Colors.indigo, 
      color2: Colors.indigoAccent,
      imagePath: 'assets/images/nearby_card_bg.png',
    ),
    QuickActionItem(
      icon: Icons.favorite, 
      label: 'Favorites', 
      color1: Colors.red, 
      color2: Colors.redAccent,
      imagePath: 'assets/images/favorites_card_bg.png',
    ),
    QuickActionItem(
      icon: Icons.shopping_bag, 
      label: 'Shopping', 
      color1: Colors.amber, 
      color2: Colors.amberAccent,
      imagePath: 'assets/images/shopping_card_bg.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'QUICK ACCESS',
            style: TextStyle(
              color: Theme.of(context).textTheme.labelSmall?.color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        GlassContainer(
          borderRadius: BorderRadius.circular(24),
          padding: const EdgeInsets.all(16),
          borderGradient: Theme.of(context).brightness == Brightness.dark
            ? LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.30), // Increased from 0.15
                  Colors.white.withValues(alpha: 0.10), // Increased from 0.05
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  AppTheme.brandPrimary.withValues(alpha: 0.5),
                  Colors.teal.withValues(alpha: 0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, 
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _buildServiceCard(context, _items[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, QuickActionItem item) {
    final bool hasImage = item.imagePath != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.black.withValues(alpha: 0.03)),
        // If image exists, apply it to the main container
        image: hasImage ? DecorationImage(
          image: AssetImage(item.imagePath!),
          fit: BoxFit.cover,
        ) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
             if (item.route != null) {
               GoRouter.of(context).go(item.route!);
             } else {
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                   content: Text("${item.label} coming soon!"),
                   duration: const Duration(seconds: 1),
                   backgroundColor: AppTheme.brandPrimary,
                 )
               );
             }
          },
          borderRadius: BorderRadius.circular(12),
          child: hasImage ? _buildContentWithImage(item) : _buildStandardContent(context, item),
        ),
      ),
    );
  }

  Widget _buildContentWithImage(QuickActionItem item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.7), // Scrim for text visibility
          ],
          stops: const [0.5, 1.0], // Adjusted gradient start for better visibility
        ),
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        item.label,
        style: const TextStyle(
          color: Colors.white, // White text on dark scrim
          fontSize: 18, // 50% Bigger (12 -> 18)
          fontWeight: FontWeight.w800, // Bolder
          shadows: [Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(0, 1))],
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildStandardContent(BuildContext context, QuickActionItem item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [item.color1.withValues(alpha: 0.8), item.color2.withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            item.icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.label,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18, // 50% Bigger (12 -> 18)
            fontWeight: FontWeight.w700, // Bolder
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class QuickActionItem {
  final IconData icon;
  final String label;
  final Color color1;
  final Color color2;
  final String? imagePath;
  final String? route;

  const QuickActionItem({
    required this.icon,
    required this.label,
    required this.color1,
    required this.color2,
    this.imagePath,
    this.route,
  });
}
