import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/operations_service.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  String? _message;
  bool _busy = false;

  Future<void> _share(String name, String csv) async {
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final dir = await getTemporaryDirectory();
      final file = File(p.join(dir.path, name));
      await file.writeAsString(csv);
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], text: name),
      );
    } on AppException catch (e) {
      setState(() => _message = e.message);
    } catch (_) {
      setState(
        () => _message = ref.read(appStringsProvider).somethingWentWrong,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _export(Future<String> Function() build, String filename) async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null) return;
    await _share(filename, await build());
  }

  Future<void> _exportOperations() async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null) return;
    final health = await ref
        .read(attendanceIngestServiceProvider)
        .importHealth(workspace);
    final snap = await ref
        .read(operationsServiceProvider)
        .snapshot(workspace: workspace, importHealth: health);
    final csv = ref
        .read(csvInteropServiceProvider)
        .exportOperations(
          locationName: workspace.location.name,
          explanation: snap.explanation,
          peakLines: [
            for (final peak in snap.peakHours.take(24))
              '${OperationsService.weekdayName(peak.weekday)},${peak.hour},${peak.visits},${peak.average.toStringAsFixed(1)},${peak.max},${peak.p90},${peak.rollingAverage.toStringAsFixed(1)},${peak.label}',
          ],
          locationLines: [
            for (final row in snap.locations)
              '${row.name},${row.visits ?? ''},${row.uniqueVisitors ?? ''},${row.unmatched},${row.activeMembers},${row.explanation}',
          ],
        );
    await _share('gympulse-operations.csv', csv);
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(s.exportReports)),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          Text(s.csvNotBackup),
          const SizedBox(height: GpSpacing.md),
          FilledButton(
            onPressed: _busy ? null : _exportOperations,
            child: Text(s.operationsReport),
          ),
          TextButton(
            onPressed: _busy
                ? null
                : () => _export(() async {
                    final workspace = await ref.read(workspaceProvider.future);
                    return ref
                        .read(csvInteropServiceProvider)
                        .exportAttendance(workspace!);
                  }, 'gympulse-attendance.csv'),
            child: Text(s.exportAttendance),
          ),
          TextButton(
            onPressed: _busy
                ? null
                : () => _export(() async {
                    final workspace = await ref.read(workspaceProvider.future);
                    return ref
                        .read(csvInteropServiceProvider)
                        .exportFollowUps(workspace!);
                  }, 'gympulse-followups.csv'),
            child: Text(s.exportFollowUps),
          ),
          TextButton(
            onPressed: _busy
                ? null
                : () => _export(() async {
                    final workspace = await ref.read(workspaceProvider.future);
                    return ref
                        .read(csvInteropServiceProvider)
                        .exportTrials(workspace!);
                  }, 'gympulse-trials.csv'),
            child: Text(s.exportTrials),
          ),
          TextButton(
            onPressed: _busy
                ? null
                : () => _export(() async {
                    final workspace = await ref.read(workspaceProvider.future);
                    return ref
                        .read(csvInteropServiceProvider)
                        .exportCancellations(workspace!);
                  }, 'gympulse-cancellations.csv'),
            child: Text(s.exportCancellations),
          ),
          if (_message != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_message!),
          ],
        ],
      ),
    );
  }
}
