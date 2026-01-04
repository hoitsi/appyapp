import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/secure_storage_service.dart';

// State
class UserState {
  final bool isPro;
  final bool isLoading;
  
  UserState({this.isPro = false, this.isLoading = true});
  
  UserState copyWith({bool? isPro, bool? isLoading}) {
    return UserState(
      isPro: isPro ?? this.isPro,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Provider
final userProvider = NotifierProvider<UserNotifier, UserState>(() {
  return UserNotifier();
});

class UserNotifier extends Notifier<UserState> {
  late final SecureStorageService _storage;

  @override
  UserState build() {
    _storage = ref.read(secureStorageProvider);
    _loadState();
    return UserState();
  }

  Future<void> _loadState() async {
    final isPro = await _storage.getProStatus();
    state = state.copyWith(isPro: isPro, isLoading: false);
  }

  Future<void> upgradeToPro() async {
    await _storage.setProStatus(true);
    state = state.copyWith(isPro: true);
  }
  
  Future<void> downgrade() async {
    await _storage.setProStatus(false);
    state = state.copyWith(isPro: false);
  }
}
