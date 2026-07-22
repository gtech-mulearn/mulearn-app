import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/mu_empty_state.dart';
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
      backgroundColor: MuColors.canvas,
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
            padding: const EdgeInsets.all(MuSpace.screenH),
            child: TextField(
              controller: _queryController,
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(LucideIcons.search, size: 20),
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
                  return const MuEmptyState(
                    icon: LucideIcons.search,
                    title: 'Search for someone',
                    message: 'Find users and mentors by name or MUID.',
                  );
                }
                if (results.isEmpty) {
                  return const MuEmptyState(
                    icon: LucideIcons.userX,
                    title: 'No results found',
                    message: 'Try a different name or MUID.',
                  );
                }
                final hasMore =
                    ref.read(searchControllerProvider.notifier).hasMore;
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(
                    MuSpace.screenH,
                    0,
                    MuSpace.screenH,
                    MuSpace.l,
                  ),
                  itemCount: results.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= results.length) {
                      return const Padding(
                        padding: EdgeInsets.all(MuSpace.l),
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
