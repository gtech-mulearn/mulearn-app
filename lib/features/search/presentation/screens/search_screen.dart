import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/search/presentation/providers/search_controller.dart';
import 'package:mulearn_app/features/search/presentation/widgets/user_search_result_tile.dart';

/// Find users or mentors by name/MUID — mirrors the reference dashboard's
/// search page.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this)
    ..addListener(_onTabChanged);
  final _queryController = TextEditingController();
  final _scrollController = ScrollController();

  String get _role => _tabController.index == 1 ? 'mentor' : '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    _runSearch();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchControllerProvider.notifier).loadMore();
    }
  }

  void _runSearch() {
    ref
        .read(searchControllerProvider.notifier)
        .search(_queryController.text, role: _role.isEmpty ? null : _role);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _queryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultsState = ref.watch(searchControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Users'),
            Tab(text: 'Mentors'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _queryController,
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by name or MUID…',
              ),
              onSubmitted: (_) => _runSearch(),
              textInputAction: TextInputAction.search,
            ),
          ),
          Expanded(
            child: resultsState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) =>
                  Center(child: Text(ApiException.messageFor(error))),
              data: (results) {
                if (_queryController.text.trim().isEmpty) {
                  return const Center(child: Text('Search for someone.'));
                }
                if (results.isEmpty) {
                  return const Center(child: Text('No results found.'));
                }
                final hasMore =
                    ref.read(searchControllerProvider.notifier).hasMore;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: results.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= results.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    final result = results[index];
                    return UserSearchResultTile(
                      result: result,
                      onTap: () => context
                          .push(RoutePaths.publicProfilePath(result.muid)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
