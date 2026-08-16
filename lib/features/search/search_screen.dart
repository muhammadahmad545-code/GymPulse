import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/gym_ops_service.dart';
import '../members/member_detail_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _query = TextEditingController();
  List<SearchHit> _hits = const [];
  bool _loading = false;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<void> _search(String value) async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null) return;
    setState(() => _loading = true);
    try {
      final hits = await ref
          .read(gymOpsServiceProvider)
          .search(workspace: workspace, query: value);
      if (!mounted) return;
      setState(() => _hits = hits);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(s.searchEverything)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(GpSpacing.lg),
            child: TextField(
              controller: _query,
              autofocus: true,
              decoration: InputDecoration(labelText: s.searchEverything),
              onChanged: _search,
            ),
          ),
          if (_loading) const LinearProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: _hits.length,
              itemBuilder: (context, i) {
                final hit = _hits[i];
                return ListTile(
                  title: Text(hit.title),
                  subtitle: Text('${hit.kind} · ${hit.subtitle}'),
                  onTap: hit.memberId == null
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  MemberDetailScreen(memberId: hit.memberId!),
                            ),
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
