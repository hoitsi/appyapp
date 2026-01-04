import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/app_repository.dart';
import '../../domain/entities/app_model.dart';

// State Helper
abstract class SearchState {}
class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {
  final List<dynamic> results; // Mixed List<AppModel> and Ad Objects
  SearchLoaded(this.results);
}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

// Provider
final searchProvider = NotifierProvider<SearchNotifier, SearchState>(() {
  return SearchNotifier();
});

class SearchNotifier extends Notifier<SearchState> {
  late final AppRepository _repository;

  @override
  SearchState build() {
    // We can read providers in build()
    _repository = ref.read(appRepositoryProvider);
    return SearchInitial();
  }

  Future<void> search(String query) async {
    state = SearchLoading();
    try {
      final apps = await _repository.searchApps(query);
      final enrichedResults = _injectAds(apps);
      state = SearchLoaded(enrichedResults);
    } catch (e) {
      state = SearchError("Could not connect to Lighthouse Network. Please try again.");
    }
  }

  List<dynamic> _injectAds(List<AppModel> apps) {
    final List<dynamic> mixedList = [];
    for (int i = 0; i < apps.length; i++) {
      mixedList.add(apps[i]);
      // Inject Ad after every 3 items (so it appears as 4th)
      if ((i + 1) % 3 == 0) {
        mixedList.add(SponsoredAd());
      }
    }
    return mixedList;
  }
}

class SponsoredAd {
  final String title = "Sponsored Recommendation";
  // Placeholder logic
}
