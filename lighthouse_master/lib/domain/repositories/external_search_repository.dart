import '../entities/search_result_item.dart';

abstract class ExternalSearchRepository {
  Future<List<SearchResultItem>> searchWeb(String query);
  Future<List<SearchResultItem>> searchStore(String query);
}
