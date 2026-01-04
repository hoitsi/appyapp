import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/app_model.dart';

final appRepositoryProvider = Provider<AppRepository>((ref) {
  return AppRepository();
});

class AppRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:8000',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // Linux/Android localhost handling
  AppRepository() {
    // If running on Android Emulator, switch to 10.0.2.2
    // For now we assume Linux Desktop environment (127.0.0.1) as per task.
  }

  Future<List<AppModel>> searchApps(String query) async {
    try {
      final response = await _dio.get('/search', queryParameters: {
        'q': query,
      });

      final List<dynamic> data = response.data;
      return data.map((json) => AppModel.fromJson(json)).toList();
    } catch (e) {
      // In production, log to Crashlytics
      rethrow;
    }
  }

  Future<AppModel> getAppDetails(String appId) async {
    try {
      final response = await _dio.get('/app/$appId');
      return AppModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getProStacks() async {
    try {
      final response = await _dio.get('/pro-stacks');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
        // Fallback mock data if server fails
        return [
            {
                "title": "Essential Dev Tools",
                "description": "The best coding tools for Android.",
                "apps": ["Termux", "Acode", "GitHub"]
            },
            {
                "title": "Privacy Shield",
                "description": "Go dark with these privacy tools.",
                "apps": ["Tor", "Signal", "Orbot"]
            }
        ];
    }
  }
}
