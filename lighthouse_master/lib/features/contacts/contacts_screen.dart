import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/glass_container.dart';
import '../../presentation/widgets/unified_search_bar.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Contacts', style: TextStyle(color: Theme.of(context).textTheme.headlineMedium?.color, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: UnifiedSearchBar(
              hintText: 'Search contacts',
              showFeatureIndicators: true, // Exact match to Home
            ),
          ),
          
          // Quick Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: _buildActionButton(context, 'Add Friend', Icons.person_add, AppTheme.artDecoGold)), // Gold CTA
                const SizedBox(width: 12),
                Expanded(child: _buildActionButton(context, 'QR Code', Icons.qr_code, AppTheme.artDecoTeal)), // Teal Secondary
              ],
            ),
          ),
          
          // Groups Item - Converted to Glass Style
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              borderGradient: LinearGradient(
                colors: [
                  AppTheme.artDecoGold.withValues(alpha: 0.3),
                  AppTheme.artDecoTeal.withValues(alpha: 0.2),
                ],
              ),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppTheme.brandPrimary, Colors.teal]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.group, color: Colors.white),
                ),
                title: Text('Group Chats', style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge?.color)),
                subtitle: Text('5 groups', style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color)),
                trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.transparent, 
            width: double.infinity,
            child: Text('ALL CONTACTS', style: TextStyle(color: Theme.of(context).textTheme.labelSmall?.color, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          
          Expanded(
            child: ListView(
              children: [
                 _buildContactItem(context, 'Sarah Chen', 'Product Designer'),
                 _buildContactItem(context, 'Michael Park', 'Software Engineer'),
                 _buildContactItem(context, 'Emily Watson', 'Marketing Manager'),
                 _buildContactItem(context, 'James Liu', 'Creative Director'),
                 _buildContactItem(context, 'Alex Kim', 'UX Researcher'),
                 _buildContactItem(context, 'Lisa Zhang', 'Data Analyst'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, String name, String status) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.all(12),
        borderGradient: LinearGradient(
          colors: [
            AppTheme.artDecoGold.withValues(alpha: 0.2),
            AppTheme.artDecoTeal.withValues(alpha: 0.1), // Subtler for contacts
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.artDecoTeal.withValues(alpha: 0.1),
              child: Text(name[0], style: const TextStyle(color: AppTheme.artDecoTeal, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).textTheme.bodyLarge?.color)),
                Text(status, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
