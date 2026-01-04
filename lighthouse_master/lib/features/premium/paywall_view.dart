import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/user_provider.dart';

class PaywallView extends ConsumerWidget {
  const PaywallView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey[900]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Close
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              
              const Spacer(),
              
              // Branding
              const Icon(Icons.diamond_outlined, size: 80, color: Colors.amber),
              const SizedBox(height: 16),
              const Text(
                'Lighthouse Pro',
                style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (userState.isPro) 
                const Text('You are a Pro Member!', style: TextStyle(color: Colors.green, fontSize: 18))
              else
                const Text('Unlock the full power of high-trust discovery.', style: TextStyle(color: Colors.grey, fontSize: 16)),

              const SizedBox(height: 48),

               // Features
              _buildFeatureRow(Icons.layers, 'Access Pro Stacks (Expert Bundles)'),
              const SizedBox(height: 16),
              _buildFeatureRow(Icons.security, 'Advanced Deep-Scan for APKs'),
              const SizedBox(height: 16),
              _buildFeatureRow(Icons.speed, 'Priority Support & Ad-Free'),

              const Spacer(),
              
              // Action
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    if (!userState.isPro) ...[
                       const Text(
                        '7 Day Free Trial, then \$4.99/mo',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ref.read(userProvider.notifier).upgradeToPro();
                            if (context.mounted) {
                               ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Welcome to Lighthouse Pro!')),
                              );
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          ),
                          child: const Text('Start Free Trial', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ] else
                       const Center(child: Text("Subscription Active", style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Icon(icon, color: Colors.amber, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
