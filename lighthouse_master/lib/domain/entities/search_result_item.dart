enum SearchResultType {
  app,
  web,
  aiGeneration
}

class SearchResultItem {
  final String title;
  final String description;
  final String navUrl; // URL or Route
  final SearchResultType type;
  final String source; // "Play Store", "Web", "AI"
  final String? iconUrl;

  SearchResultItem({
    required this.title,
    required this.description,
    required this.navUrl,
    required this.type,
    required this.source,
    this.iconUrl,
  });
}
