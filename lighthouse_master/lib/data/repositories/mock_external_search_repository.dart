import '../../domain/entities/search_result_item.dart';
import '../../domain/repositories/external_search_repository.dart';

class MockExternalSearchRepository implements ExternalSearchRepository {
  @override
  Future<List<SearchResultItem>> searchWeb(String query) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate latency
    return [
      SearchResultItem(
        title: 'Top 10 Apps like $query',
        description: 'Check out these amazing alternatives on TechBlog...',
        navUrl: 'https://techblog.com/apps-like-$query',
        type: SearchResultType.web,
        source: 'Web',
      ),
      SearchResultItem(
        title: '$query - Wikipedia',
        description: 'Encyclopedia entry for $query.',
        navUrl: 'https://wikipedia.org/wiki/$query',
        type: SearchResultType.web,
        source: 'Wikipedia',
      ),
    ];
  }

  @override
  Future<List<SearchResultItem>> searchStore(String query) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final List<SearchResultItem> results = [];

    // AI Trigger Check
    final q = query.toLowerCase();
    if (q.contains('create') || q.contains('generate') || q.contains('make') || q.contains('build')) {
      results.add(SearchResultItem(
        title: 'Generate "$query" with AI',
        description: 'Tap to instantly generate this app using \'appyapp AI.',
        navUrl: 'ai://generate?prompt=$query',
        type: SearchResultType.aiGeneration,
        source: "'appyapp AI",
        iconUrl: null, // UI will handle icon
      ));
    }

    // Mock APK Results
    results.add(SearchResultItem(
      title: '$query Pro - APK Download',
      description: 'Latest version 2.4.5. Premium unlocked.',
      navUrl: 'https://apkpure.com/$query',
      type: SearchResultType.app,
      source: 'APKMirror',
    ));

     results.add(SearchResultItem(
      title: '$query Official App',
      description: 'The official app for $query.',
      navUrl: 'market://details?id=com.$query',
      type: SearchResultType.app,
      source: 'Play Store',
    ));

    return results;
  }
}
