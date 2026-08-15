import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/gp_theme.dart';
import '../../data/db/app_database.dart';
import 'member_detail_screen.dart';
import 'member_editor_screen.dart';

class MembersScreen extends ConsumerStatefulWidget {
  const MembersScreen({super.key});

  @override
  ConsumerState<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends ConsumerState<MembersScreen> {
  final _query = TextEditingController();
  List<Member> _members = [];
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final rows = await ref
          .read(memberRepositoryProvider)
          .list(
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
          );
      if (!mounted) return;
      setState(() => _members = rows);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    final q = _query.text.trim().toLowerCase();
    final filtered = _members.where((m) {
      if (q.isEmpty) return true;
      return '${m.firstName} ${m.lastName} ${m.phone ?? ''} ${m.externalMemberId ?? ''}'
          .toLowerCase()
          .contains(q);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            GpSpacing.lg,
            GpSpacing.lg,
            GpSpacing.lg,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  s.navMembers,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const MemberEditorScreen(),
                    ),
                  );
                  await _load();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(GpSpacing.lg),
          child: TextField(
            controller: _query,
            decoration: InputDecoration(labelText: s.searchMembers),
            onChanged: (_) => setState(() {}),
          ),
        ),
        if (_loading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (_error != null)
          Expanded(child: Center(child: Text(_error!)))
        else if (filtered.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                s.noMembers,
                style: const TextStyle(color: GpColors.textSecondary),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final m = filtered[i];
                return ListTile(
                  title: Text('${m.firstName} ${m.lastName}'.trim()),
                  subtitle: Text(
                    [
                      m.status,
                      if (m.externalMemberId != null) m.externalMemberId!,
                      if (m.phone != null) m.phone!,
                    ].join(' · '),
                  ),
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MemberDetailScreen(memberId: m.id),
                      ),
                    );
                    await _load();
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
