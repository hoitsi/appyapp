import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/apk_safety_service.dart';
import '../../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class GuideView extends ConsumerStatefulWidget {
  final String downloadUrl;

  const GuideView({super.key, required this.downloadUrl});

  @override
  ConsumerState<GuideView> createState() => _GuideViewState();
}

class _GuideViewState extends ConsumerState<GuideView> {
  int _step = 0;
  bool _isSafetyCheckPassed = false;
  String _safetyMessage = "Checking...";

  @override
  void initState() {
    super.initState();
    _performSafetyCheck();
  }

  void _performSafetyCheck() {
    final safetyService = ref.read(apkSafetyProvider);
    final result = safetyService.validateDownloadUrl(widget.downloadUrl);
    
    setState(() {
      _isSafetyCheckPassed = result.isSafe;
      _safetyMessage = result.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 450,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, 
              height: 4, 
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'Smart Application Installer',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          Expanded(child: _buildStepContent()),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_step > 0)
                TextButton(
                  onPressed: () => setState(() => _step--),
                  child: const Text('Back'),
                )
              else
                const SizedBox(),
              
              ElevatedButton(
                onPressed: _handleNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSafetyCheckPassed || _step > 0 ? AppTheme.primaryBlue : Colors.grey,
                  foregroundColor: Colors.white,
                ),
                child: Text(_step == 2 ? 'Start Download' : 'Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleNext() {
    if (_step == 0 && !_isSafetyCheckPassed) return; // Block

    if (_step < 2) {
      setState(() => _step++);
    } else {
      _launchDownload();
    }
  }

  Future<void> _launchDownload() async {
     Navigator.pop(context);
     final uri = Uri.parse(widget.downloadUrl);
     if (await canLaunchUrl(uri)) {
       await launchUrl(uri, mode: LaunchMode.externalApplication);
     } else {
       if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not launch installer.')));
       }
     }
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _isSafetyCheckPassed ? Icons.security : Icons.warning, 
              size: 48, 
              color: _isSafetyCheckPassed ? AppTheme.trustGreen : AppTheme.riskRed
            ),
            const SizedBox(height: 16),
            Text(
              _isSafetyCheckPassed ? 'Security Check: Passed' : 'Security Alert',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _safetyMessage,
              style: TextStyle(color: Colors.grey[700]),
            ),
            if (!_isSafetyCheckPassed)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text("Download blocked for your safety.", style: TextStyle(color: AppTheme.riskRed, fontWeight: FontWeight.bold)),
              )
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.settings_applications, size: 48, color: AppTheme.primaryBlue),
            const SizedBox(height: 16),
            const Text(
              'Enable "Unknown Sources"',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Android requires special permission to install apps from outside the Play Store. \n\nGo to Settings > Security > Install Unknown Apps and allow your browser.',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.download_done, size: 48, color: AppTheme.trustGreen),
            const SizedBox(height: 16),
            const Text(
              'Ready to Install',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Click "Start Download" below. Once downloaded, tap the notification to install.',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }
}
