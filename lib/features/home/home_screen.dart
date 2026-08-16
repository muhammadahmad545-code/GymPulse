import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/gp_logo.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/gym_ops_service.dart';
import '../../domain/services/operations_service.dart';
import '../../domain/services/retention_service.dart';
import '../members/member_detail_screen.dart';
import '../settings/app_update_flow.dart';
import '../settings/backup_settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  GymDashboard? _dash;
  RetentionSnapshot? _retention;
  OperationsSnapshot? _ops;
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
      final ops = ref.read(gymOpsServiceProvider);
      await ops.seedDefaultReasons(workspace.organization.id);
      final created = await ops.generateDueReminders(workspace: workspace);
      final prefs = await ref
          .read(operationsServiceProvider)
          .notificationPrefs(workspace.organization.id);
      if (prefs[OpsNotifyKeys.feeReminders] ?? true) {
        for (final reminder in created) {
          final member = await ref
              .read(memberRepositoryProvider)
              .get(
                organizationId: workspace.organization.id,
                id: reminder.memberId,
              );
          final name = member == null
              ? 'A member'
              : '${member.firstName} ${member.lastName}'.trim();
          final dueToday =
              reminder.reminderType == GymOpsService.reminderDueToday;
          await ref
              .read(localNotificationServiceProvider)
              .show(
                id: 200 + reminder.id.hashCode.abs() % 1000,
                title: dueToday ? 'Fee due today' : 'Fee due in 3 days',
                body: dueToday
                    ? "$name's gym fee is due today."
                    : "$name's gym fee is due in 3 days.",
              );
        }
      }
      final dash = await ops.dashboard(workspace: workspace);
      final health = await ref
          .read(attendanceIngestServiceProvider)
          .importHealth(workspace);
      final backup = await ref.read(backupServiceProvider).status();
      if (backup.isStale) {
        await ref
            .read(localNotificationServiceProvider)
            .show(
              id: 11,
              title: 'Backup reminder',
              body: 'Your Mr. Gym backup is stale. Create an encrypted backup.',
            );
      }
      final retention = await ref
          .read(retentionServiceProvider)
          .snapshot(workspace: workspace, importHealth: health);
      final opsSnap = await ref
          .read(operationsServiceProvider)
          .snapshot(workspace: workspace, importHealth: health);
      await ref
          .read(opsNotifierProvider)
          .maybeNotify(
            workspace: workspace,
            importHealth: health,
            snapshot: opsSnap,
          );
      if (!mounted) return;
      setState(() {
        _dash = dash;
        _retention = retention;
        _ops = opsSnap;
      });
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
    final workspace = ref.watch(workspaceProvider).valueOrNull;
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _Message(text: _error!, action: s.retry, onTap: _load);
    }
    final dash = _dash;
    if (workspace == null || dash == null) {
      return _Message(
        text: s.somethingWentWrong,
        action: s.retry,
        onTap: _load,
      );
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          Row(
            children: [
              const GpLogo(size: 40),
              const SizedBox(width: GpSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workspace.organization.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      s.tagline,
                      style: const TextStyle(color: GpColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: GpSpacing.lg),
          const UpdateAvailableBanner(),
          const SizedBox(height: GpSpacing.md),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: s.todaysAttendance,
                  value: '${dash.todayAttendance}',
                ),
              ),
              const SizedBox(width: GpSpacing.md),
              Expanded(
                child: _StatCard(
                  label: s.activeMembers,
                  value: '${dash.activeMembers}',
                ),
              ),
            ],
          ),
          const SizedBox(height: GpSpacing.md),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: s.feesDueToday,
                  value: '${dash.feesDueToday.length}',
                ),
              ),
              const SizedBox(width: GpSpacing.md),
              Expanded(
                child: _StatCard(
                  label: s.feesDueIn3Days,
                  value: '${dash.feesDueIn3Days.length}',
                ),
              ),
            ],
          ),
          const SizedBox(height: GpSpacing.md),
          _StatCard(label: s.overdueMembers, value: '${dash.overdue.length}'),
          if (_ops != null) ...[
            const SizedBox(height: GpSpacing.md),
            Card(
              child: ListTile(
                title: Text(s.capacityUtilization),
                subtitle: Text(_ops!.capacity.explanation),
              ),
            ),
          ],
          const SizedBox(height: GpSpacing.md),
          _BackupBanner(),
          const SizedBox(height: GpSpacing.md),
          _MemberListCard(
            title: s.feesDueToday,
            empty: 'No fees due today.',
            rows: dash.feesDueToday,
          ),
          const SizedBox(height: GpSpacing.md),
          _MemberListCard(
            title: s.feesDueIn3Days,
            empty: 'No fees due in the next 3 days.',
            rows: dash.feesDueIn3Days,
          ),
          const SizedBox(height: GpSpacing.md),
          _MemberListCard(
            title: s.overdueMembers,
            empty: 'No overdue members.',
            rows: dash.overdue,
          ),
          const SizedBox(height: GpSpacing.md),
          _MemberListCard(
            title: s.notAttendedRecently,
            empty: 'Everyone has attended recently.',
            rows: dash.inactive.take(8).toList(),
          ),
          const SizedBox(height: GpSpacing.md),
          if (_retention != null)
            _ListCard(
              title: s.highRiskMembers,
              empty: s.noHighRisk,
              children: [
                for (final risk
                    in _retention!.risks
                        .where(
                          (r) =>
                              r.enoughData &&
                              (r.level == 'high' || r.level == 'critical'),
                        )
                        .take(5))
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(risk.memberName),
                    subtitle: Text(
                      '${s.riskScore} ${risk.score} · ${risk.level}',
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            MemberDetailScreen(memberId: risk.memberId),
                      ),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: GpSpacing.md),
          _ListCard(
            title: s.recentAttendance,
            empty: 'No attendance recorded yet.',
            children: [
              for (final event in dash.recentAttendance)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(event.externalMemberId),
                  subtitle: Text(
                    DateFormat.yMMMd().add_jm().format(event.occurredAtLocal),
                  ),
                  onTap: event.memberId == null
                      ? null
                      : () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                MemberDetailScreen(memberId: event.memberId!),
                          ),
                        ),
                ),
            ],
          ),
          const SizedBox(height: GpSpacing.md),
          Text(
            '${s.openActions}: ${dash.openFollowUps} · ${s.reminderHistory}: ${dash.pendingReminders.length} pending',
            style: const TextStyle(color: GpColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(GpSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: GpColors.textSecondary)),
            const SizedBox(height: GpSpacing.xs),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class _MemberListCard extends StatelessWidget {
  const _MemberListCard({
    required this.title,
    required this.empty,
    required this.rows,
  });
  final String title;
  final String empty;
  final List<MemberDirectoryRow> rows;

  @override
  Widget build(BuildContext context) {
    return _ListCard(
      title: title,
      empty: empty,
      children: [
        for (final row in rows.take(8))
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(row.displayName),
            subtitle: Text(
              [
                row.fee.label,
                if (row.member.phone != null) row.member.phone!,
              ].join(' · '),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MemberDetailScreen(memberId: row.member.id),
              ),
            ),
          ),
      ],
    );
  }
}

class _BackupBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(backupServiceProvider).status(),
      builder: (context, snapshot) {
        final status = snapshot.data;
        if (status == null || !status.isStale) return const SizedBox.shrink();
        final s = ref.watch(appStringsProvider);
        return Card(
          child: ListTile(
            title: Text(s.backupStaleWarning),
            trailing: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BackupSettingsScreen(),
                  ),
                );
              },
              child: Text(s.backupNow),
            ),
          ),
        );
      },
    );
  }
}

class _ListCard extends StatelessWidget {
  const _ListCard({
    required this.title,
    required this.empty,
    required this.children,
  });
  final String title;
  final String empty;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(GpSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            if (children.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: GpSpacing.sm),
                child: Text(
                  empty,
                  style: const TextStyle(color: GpColors.textSecondary),
                ),
              )
            else
              ...children,
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    required this.text,
    required this.action,
    required this.onTap,
  });
  final String text;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(GpSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text),
            TextButton(onPressed: onTap, child: Text(action)),
          ],
        ),
      ),
    );
  }
}
