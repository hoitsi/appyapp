import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/widgets/glass_container.dart';
import '../../presentation/widgets/ambient_background.dart'; // Added Import
import '../../presentation/providers/search_provider.dart';
import '../../domain/entities/app_model.dart';
import 'app_result_card.dart';
import '../../theme/app_theme.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  ConsumerState<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger search on init
    Future.microtask(() => 
      ref.read(searchProvider.notifier).search(widget.query)
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return Theme(
      data: AppTheme.glassTheme, // Enforce dark/glass theme
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: AppTheme.artDecoTeal),
          title: Hero(
            tag: 'searchBar',
            child: Material(
              color: Colors.transparent,
              child: Text(
                widget.query.isEmpty ? 'Top Recommendations' : widget.query,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.artDecoTeal),
              ),
            ),
          ),
        ),
        body: AmbientBackground( // Use new background
          child: SafeArea(
            child: _buildBody(state),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(SearchState state) {
    if (state is SearchLoading) {
      return const Center(child: CircularProgressIndicator(color: AppTheme.artDecoTeal));
    } else if (state is SearchError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_rounded, size: 48, color: Colors.black.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(state.message, style: TextStyle(color: Colors.black.withValues(alpha: 0.7))),
          ],
        ),
      );
    } else if (state is SearchLoaded) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.results.length,
        itemBuilder: (context, index) {
          final item = state.results[index];
          
          if (item is AppModel) {
            return AppResultCard(appData: item);
          } else if (item is SponsoredAd) {
            return _buildAdCard();
          }
          return const SizedBox.shrink();
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildAdCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        color: Colors.amber.withValues(alpha: 0.1), // Golden tint for Ads
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Icon(Icons.star, color: Colors.amber[300]),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sponsored Recommendation", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                  Text("Check out our partner tools.", style: TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(4)
              ),
              child: const Text("Ad", style: TextStyle(fontSize: 10, color: Colors.black87)),
            )
          ],
        ),
      ),
    );
  }
}
