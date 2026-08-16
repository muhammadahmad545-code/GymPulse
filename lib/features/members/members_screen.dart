import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/gym_ops_service.dart';
import 'member_detail_screen.dart';
import 'member_editor_screen.dart';

class MembersScreen extends ConsumerStatefulWidget {
  const MembersScreen({super.key});

  @override
  ConsumerState<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends ConsumerState<MembersScreen> {
  final _query = TextEditingController();
  List<MemberDirectoryRow> _rows = [];
  String _statusFilter = 'active';
  String _feeFilter = 'all';
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
          .read(gymOpsServiceProvider)
          .directory(workspace: workspace);
      if (!mounted) return;
      setState(() => _rows = rows);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _mark(MemberDirectoryRow row) async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null) return;
    final s = ref.read(appStringsProvider);
    try {
      await ref
          .read(gymOpsServiceProvider)
          .markAttendance(workspace: workspace, memberId: row.member.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${s.markAttendance}: ${row.displayName}')),
      );
      await _load();
    } on AppException catch (e) {
      if (e.code != AppErrorCodes.attendanceDuplicateEvent) {
        if (mounted) setState(() => _error = e.message);
        return;
      }
      final existing = await ref
          .read(gymOpsServiceProvider)
          .todaysAttendance(workspace: workspace, memberId: row.member.id);
      if (!mounted) return;
      final again = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(s.attendanceAlreadyMarked),
          content: Text(
            [
              row.displayName,
              if (existing != null)
                DateFormat.jm().format(existing.occurredAtLocal),
            ].join('\n'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(s.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(s.recordAnotherVisit),
            ),
          ],
        ),
      );
      if (again != true) return;
      await ref
          .read(gymOpsServiceProvider)
          .markAttendance(
            workspace: workspace,
            memberId: row.member.id,
            allowDuplicate: true,
          );
      await _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    final q = _query.text.trim().toLowerCase();
    final filtered = _rows.where((row) {
      if (_statusFilter == 'active' && row.member.status != 'active') {
        return false;
      }
      if (_statusFilter == 'inactive' && row.member.status == 'active') {
        return false;
      }
      if (_feeFilter == 'due' && !(row.fee.dueToday || row.fee.dueIn3Days)) {
        return false;
      }
      if (_feeFilter == 'overdue' && !row.fee.overdue) return false;
      if (q.isEmpty) return true;
      return '${row.displayName} ${row.member.phone ?? ''}'
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: GpSpacing.lg),
          child: Row(
            children: [
              FilterChip(
                label: Text(s.filterActive),
                selected: _statusFilter == 'active',
                onSelected: (_) => setState(() => _statusFilter = 'active'),
              ),
              const SizedBox(width: GpSpacing.sm),
              FilterChip(
                label: Text(s.filterInactive),
                selected: _statusFilter == 'inactive',
                onSelected: (_) => setState(() => _statusFilter = 'inactive'),
              ),
              const SizedBox(width: GpSpacing.sm),
              FilterChip(
                label: Text(s.filterDueSoon),
                selected: _feeFilter == 'due',
                onSelected: (_) => setState(
                  () => _feeFilter = _feeFilter == 'due' ? 'all' : 'due',
                ),
              ),
              const SizedBox(width: GpSpacing.sm),
              FilterChip(
                label: Text(s.filterOverdue),
                selected: _feeFilter == 'overdue',
                onSelected: (_) => setState(
                  () =>
                      _feeFilter = _feeFilter == 'overdue' ? 'all' : 'overdue',
                ),
              ),
            ],
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
                final row = filtered[i];
                final last = row.lastVisit;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: GpSpacing.lg,
                    vertical: GpSpacing.xs,
                  ),
                  child: ListTile(
                    title: Text(row.displayName),
                    subtitle: Text(
                      [
                        row.member.phone ?? 'No WhatsApp',
                        row.fee.label,
                        row.member.status,
                        if (last != null)
                          'Last ${DateFormat.MMMd().format(last.toLocal())}',
                        '${row.visitCount} visits',
                      ].join(' · '),
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      tooltip: s.markAttendance,
                      onPressed: row.member.status == 'active'
                          ? () => _mark(row)
                          : null,
                      icon: const Icon(Icons.how_to_reg_outlined),
                    ),
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              MemberDetailScreen(memberId: row.member.id),
                        ),
                      );
                      await _load();
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
