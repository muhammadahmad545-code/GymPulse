import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../data/db/app_database.dart';
import '../members/member_detail_screen.dart';

class ActionsScreen extends ConsumerStatefulWidget {
  const ActionsScreen({super.key});

  @override
  ConsumerState<ActionsScreen> createState() => _ActionsScreenState();
}

class _ActionsScreenState extends ConsumerState<ActionsScreen> {
  List<FollowUp> _items = [];
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final health = await ref
          .read(attendanceIngestServiceProvider)
          .importHealth(workspace);
      await ref
          .read(intelligenceServiceProvider)
          .dashboard(workspace: workspace, importHealth: health);
      await ref
          .read(retentionServiceProvider)
          .snapshot(workspace: workspace, importHealth: health);
      final rows = await ref
          .read(followUpRepositoryProvider)
          .listOpen(
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
          );
      if (!mounted) return;
      setState(() => _items = rows);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _setStatus(FollowUp item, String status) async {
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      await ref
          .read(followUpRepositoryProvider)
          .updateStatus(
            organizationId: workspace.organization.id,
            id: item.id,
            status: status,
          );
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(GpSpacing.lg),
          child: Text(
            s.navActions,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        if (_loading)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else if (_error != null)
          Expanded(child: Center(child: Text(_error!)))
        else if (_items.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                s.noActions,
                style: const TextStyle(color: GpColors.textSecondary),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: GpSpacing.lg),
              itemCount: _items.length,
              itemBuilder: (context, i) {
                final item = _items[i];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(GpSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.reason,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: GpSpacing.xs),
                        Text(
                          '${item.type} · ${item.status} · ${s.priority} ${item.priority}',
                          style: const TextStyle(color: GpColors.textSecondary),
                        ),
                        const SizedBox(height: GpSpacing.sm),
                        Wrap(
                          spacing: 8,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => MemberDetailScreen(
                                      memberId: item.memberId,
                                    ),
                                  ),
                                );
                              },
                              child: Text(s.contactMember),
                            ),
                            TextButton(
                              onPressed: () => _setStatus(item, 'contacted'),
                              child: Text(s.markContacted),
                            ),
                            TextButton(
                              onPressed: () => _setStatus(item, 'snoozed'),
                              child: Text(s.snooze),
                            ),
                            TextButton(
                              onPressed: () => _setStatus(item, 'resolved'),
                              child: Text(s.resolve),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
