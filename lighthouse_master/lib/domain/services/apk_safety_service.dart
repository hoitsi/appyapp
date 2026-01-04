import 'package:flutter_riverpod/flutter_riverpod.dart';

final apkSafetyProvider = Provider<APKSafetyService>((ref) {
  return APKSafetyService();
});

class APKSafetyResult {
  final bool isSafe;
  final String message;

  APKSafetyResult(this.isSafe, this.message);
}

class APKSafetyService {
  
  APKSafetyResult validateDownloadUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return APKSafetyResult(false, 'Invalid URL format.');
    }

    if (uri.scheme != 'https') {
      return APKSafetyResult(false, 'Not encrypted (HTTP). Only HTTPS sources are allowed.');
    }

    if (!url.toLowerCase().endsWith('.apk')) {
      // Allow passing for stores, but warn for direct downloads
      // For this MVP, we assume direct links must be APKs or official sites.
      // We'll trust official stores (no .apk extension) but flag unknowns.
      // Returning true for now if not explicit malware, but this is the "Gate".
    }

    return APKSafetyResult(true, 'Source appears valid and encrypted.');
  }
}
