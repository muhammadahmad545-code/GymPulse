import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/intelligence_service.dart';
import '../members/member_detail_screen.dart';
import '../settings/app_update_flow.dart';
import '../settings/backup_settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DashboardSnapshot? _snap;
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
      final snap = await ref
          .read(intelligenceServiceProvider)
          .dashboard(workspace: workspace, importHealth: health);
      final backup = await ref.read(backupServiceProvider).status();
      if (backup.isStale) {
        await ref
            .read(localNotificationServiceProvider)
            .show(
              id: 11,
              title: 'Backup reminder',
              body:
                  'Your GymPulse backup is stale. Create an encrypted backup.',
            );
      }
      if (!health.isDataReliable) {
        await ref
            .read(localNotificationServiceProvider)
            .show(
              id: 12,
              title: 'Attendance import',
              body: health.message ?? 'Attendance data may be delayed.',
            );
      }
      if (!mounted) return;
      setState(() => _snap = snap);
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
    final snap = _snap;
    if (workspace == null || snap == null) {
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
          Text(
            workspace.organization.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            '${workspace.location.name} · ${workspace.location.timezone} · ${workspace.location.currencyCode}',
            style: const TextStyle(color: GpColors.textSecondary),
          ),
          const SizedBox(height: GpSpacing.lg),
          const UpdateAvailableBanner(),
          const SizedBox(height: GpSpacing.md),
          _HealthCard(score: snap.healthScore),
          const SizedBox(height: GpSpacing.md),
          _AttendanceCard(summary: snap.attendance),
          const SizedBox(height: GpSpacing.md),
          _BackupBanner(),
          const SizedBox(height: GpSpacing.md),
          _ListCard(
            title: s.needsAttention,
            empty: s.noAttention,
            children: [
              for (final item in snap.expiring.take(5))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${item.member.firstName} ${item.member.lastName}'.trim(),
                  ),
                  subtitle: Text(s.expiresInDays(item.daysUntilExpiry ?? 0)),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          MemberDetailScreen(memberId: item.member.id),
                    ),
                  ),
                ),
              for (final item in snap.inactive.take(5))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${item.member.firstName} ${item.member.lastName}'.trim(),
                  ),
                  subtitle: Text(s.inactiveForDays(item.daysSinceVisit ?? 0)),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          MemberDetailScreen(memberId: item.member.id),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: GpSpacing.md),
          _ListCard(
            title: s.peakHours,
            empty: s.noPeakHours,
            children: [
              for (final peak in snap.peakHours)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${peak.hour.toString().padLeft(2, '0')}:00'),
                  subtitle: Text('${peak.visits} ${s.visits} · ${peak.label}'),
                ),
            ],
          ),
          const SizedBox(height: GpSpacing.md),
          Text(
            '${s.activeMembers}: ${snap.activeMembers} · ${s.openActions}: ${snap.openFollowUps} · ${s.unmatched}: ${snap.unmatchedEvents}',
            style: const TextStyle(color: GpColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _HealthCard extends StatelessWidget {
  const _HealthCard({required this.score});
  final HealthScore score;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(GpSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gym Health', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: GpSpacing.sm),
            Text(
              score.hasEnoughData ? '${score.score}' : 'Not enough data',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: score.hasEnoughData
                    ? GpColors.primary
                    : GpColors.warning,
              ),
            ),
            const SizedBox(height: GpSpacing.sm),
            Text(score.explanation),
          ],
        ),
      ),
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  const _AttendanceCard({required this.summary});
  final AttendanceSummary summary;

  @override
  Widget build(BuildContext context) {
    final last = summary.health.lastSuccessAt;
    final lastLabel = last == null
        ? 'Never'
        : DateFormat.yMMMd().add_Hm().format(last.toLocal());
    final stale = !summary.reliable;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(GpSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance (7 days)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: GpSpacing.sm),
            if (stale)
              Text(
                summary.health.message ??
                    'Attendance data is stale or unavailable. Counts are not treated as zero.',
                style: const TextStyle(color: GpColors.warning),
              )
            else
              Text(
                '${summary.visits} visits · ${summary.uniqueVisitors} unique',
              ),
            const SizedBox(height: GpSpacing.sm),
            Text(
              'Last successful import: $lastLabel',
              style: const TextStyle(color: GpColors.textSecondary),
            ),
          ],
        ),
      ),
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
