import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/providers.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/intelligence_service.dart';
import '../../domain/services/retention_service.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  DashboardSnapshot? _snap;
  RetentionSnapshot? _retention;
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
      final retention = await ref
          .read(retentionServiceProvider)
          .snapshot(workspace: workspace, importHealth: health);
      if (!mounted) return;
      setState(() {
        _snap = snap;
        _retention = retention;
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
    final snap = _snap;
    return ListView(
      padding: const EdgeInsets.all(GpSpacing.lg),
      children: [
        Text(s.navAnalytics, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: GpSpacing.lg),
        if (_loading)
          const Center(child: CircularProgressIndicator())
        else if (_error != null)
          Text(_error!)
        else if (snap == null)
          Text(s.somethingWentWrong)
        else ...[
          Card(
            child: ListTile(
              title: Text(s.healthScore),
              subtitle: Text(
                snap.healthScore.hasEnoughData
                    ? '${snap.healthScore.score} · ${snap.healthScore.explanation}'
                    : snap.healthScore.explanation,
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(s.attendance),
              subtitle: Text(
                snap.attendance.reliable
                    ? '${snap.attendance.visits} ${s.visits} · ${snap.attendance.uniqueVisitors} unique'
                    : (snap.attendance.health.message ??
                          'Attendance is stale or unavailable. This is not zero attendance.'),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(GpSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.peakHours,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (snap.peakHours.isEmpty)
                    Text(
                      s.noPeakHours,
                      style: const TextStyle(color: GpColors.textSecondary),
                    )
                  else
                    for (final p in snap.peakHours)
                      Text(
                        '${p.hour.toString().padLeft(2, '0')}:00 — ${p.visits} ${s.visits} (${p.label})',
                      ),
                ],
              ),
            ),
          ),
          if (_retention != null) ...[
            Card(
              child: ListTile(
                title: Text(s.renewalAnalytics),
                subtitle: Text(
                  _retention!.renewal.hasEnoughData
                      ? '7d ${_retention!.renewal.expiring7} · 30d ${_retention!.renewal.expiring30} expiring · ${_retention!.renewal.explanation}'
                      : _retention!.renewal.explanation,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(s.trialConversion),
                subtitle: Text(
                  _retention!.trials.conversionPercent == null
                      ? _retention!.trials.explanation
                      : '${_retention!.trials.conversionPercent}% · ${_retention!.trials.explanation}',
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(GpSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.cancellations,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(_retention!.cancellations.explanation),
                    for (final e in _retention!.cancellations.byReason.entries)
                      Text(
                        '${e.key}: ${e.value} (${((_retention!.cancellations.total == 0 ? 0 : e.value / _retention!.cancellations.total) * 100).round()}%)',
                      ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(s.highRiskMembers),
                subtitle: Text(
                  _retention!.risks
                          .where(
                            (r) => r.level == 'high' || r.level == 'critical',
                          )
                          .isEmpty
                      ? s.noHighRisk
                      : '${_retention!.risks.where((r) => r.level == 'high' || r.level == 'critical').length} members',
                ),
              ),
            ),
          ],
          if (snap.attendance.health.lastSuccessAt != null)
            Text(
              '${s.lastImport}: ${DateFormat.yMMMd().add_Hm().format(snap.attendance.health.lastSuccessAt!.toLocal())}',
              style: const TextStyle(color: GpColors.textSecondary),
            ),
        ],
      ],
    );
  }
}
