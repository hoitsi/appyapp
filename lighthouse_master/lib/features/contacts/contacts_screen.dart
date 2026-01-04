import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../presentation/widgets/glass_container.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Contacts', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              borderRadius: BorderRadius.circular(10),
              showShadow: false,
              child: const SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Search', style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ),
          ),
          
          // Quick Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(child: _buildActionButton('Add Friend', Icons.person_add, AppTheme.artDecoGold)), // Gold CTA
                const SizedBox(width: 12),
                Expanded(child: _buildActionButton('QR Code', Icons.qr_code, AppTheme.artDecoTeal)), // Teal Secondary
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
                title: const Text('Group Chats', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                subtitle: const Text('5 groups', style: TextStyle(fontSize: 12, color: Colors.black54)),
                trailing: const Icon(Icons.chevron_right, color: Colors.black54),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.transparent, 
            width: double.infinity,
            child: const Text('ALL CONTACTS', style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          
          Expanded(
            child: ListView(
              children: [
                _buildContactItem('Sarah Chen', 'Product Designer'),
                _buildContactItem('Michael Park', 'Software Engineer'),
                _buildContactItem('Emily Watson', 'Marketing Manager'),
                _buildContactItem('James Liu', 'Creative Director'),
                _buildContactItem('Alex Kim', 'UX Researcher'),
                _buildContactItem('Lisa Zhang', 'Data Analyst'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
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

  Widget _buildContactItem(String name, String status) {
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
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                Text(status, style: const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
