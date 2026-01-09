import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/app_repository.dart';
import '../../data/repositories/mock_external_search_repository.dart';
import '../../domain/repositories/external_search_repository.dart';

// State Helper
abstract class SearchState {}
class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {
  final List<dynamic> results; // Mixed List<AppModel>, SearchResultItem, and Ad Objects
  SearchLoaded(this.results);
}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

// Repositories
final externalSearchRepositoryProvider = Provider<ExternalSearchRepository>((ref) {
  return MockExternalSearchRepository();
});

// Provider
final searchProvider = NotifierProvider<SearchNotifier, SearchState>(() {
  return SearchNotifier();
});

class SearchNotifier extends Notifier<SearchState> {
  late final AppRepository _repository;
  late final ExternalSearchRepository _externalRepo;

  @override
  SearchState build() {
    _repository = ref.read(appRepositoryProvider);
    _externalRepo = ref.read(externalSearchRepositoryProvider);
    return SearchInitial();
  }

  Future<void> search(String query) async {
    state = SearchLoading();
    try {
      // 1. Local Apps (Fail gracefully if server is down)
      List<dynamic> localApps = [];
      try {
        localApps = await _repository.searchApps(query);
      } catch (e) {
        // Local server likely down or unreachable. Ignore and proceed with External.
        debugPrint("Local Search Failed: $e"); 
      }
      
      // 2. External (Store & Web & AI)
      final storeResults = await _externalRepo.searchStore(query);
      final webResults = await _externalRepo.searchWeb(query);

      // 3. Combine
      final List<dynamic> combined = [
        ...localApps,
         // Prioritize AI Generation if present (it's usually in storeResults)
        ...storeResults, 
        ...webResults
      ];

      final enrichedResults = _injectAds(combined);
      state = SearchLoaded(enrichedResults);
    } catch (e) {
      // Only reach here if External Repo also fails
      state = SearchError("Could not connect to 'appyapp Network. Please try again.");
    }
  }

  List<dynamic> _injectAds(List<dynamic> items) {
    final List<dynamic> mixedList = [];
    for (int i = 0; i < items.length; i++) {
      mixedList.add(items[i]);
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
}
