import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/attendance/adapter_catalog.dart';
import '../../domain/services/attendance_ingest_service.dart';
import '../../domain/services/operations_service.dart';

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  ImportReport? _report;
  ReconciliationReport? _reconcile;
  String? _error;
  bool _busy = false;
  final _expected = TextEditingController();
  final _from = TextEditingController();
  final _to = TextEditingController();

  @override
  void dispose() {
    _expected.dispose();
    _from.dispose();
    _to.dispose();
    super.dispose();
  }

  Future<void> _importFile({required bool json}) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: json ? const ['json', 'txt'] : const ['csv', 'txt'],
      );
      final path = picked?.files.single.path;
      if (path == null) {
        setState(() => _error = 'No file was selected.');
        return;
      }
      final body = await File(path).readAsString();
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final ingest = ref.read(attendanceIngestServiceProvider);
      final report = json
          ? await ingest.importJson(workspace: workspace, json: body)
          : await ingest.importCsv(workspace: workspace, csv: body);
      setState(() => _report = report);
    } on AppException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _importMock() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final report = await ref
          .read(attendanceIngestServiceProvider)
          .importMock(workspace);
      setState(() => _report = report);
    } on AppException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _reconcileNow() async {
    setState(() => _error = null);
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final expected = int.tryParse(_expected.text);
      final from = DateTime.tryParse(_from.text);
      final to = DateTime.tryParse(_to.text);
      if (expected == null || from == null || to == null) {
        setState(
          () => _error =
              'Enter an expected count and from/to dates (YYYY-MM-DD).',
        );
        return;
      }
      final events = await ref
          .read(attendanceRepositoryProvider)
          .list(
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
          );
      setState(() {
        _reconcile = ref
            .read(operationsServiceProvider)
            .reconcile(
              events: events,
              fromUtc: from.toUtc(),
              toUtc: to.toUtc().add(const Duration(hours: 23, minutes: 59)),
              expected: expected,
            );
      });
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(s.importAttendance)),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          Text(s.csvFormatHelp),
          const SizedBox(height: GpSpacing.lg),
          FilledButton(
            onPressed: _busy ? null : () => _importFile(json: false),
            child: Text(s.importCsv),
          ),
          TextButton(
            onPressed: _busy ? null : () => _importFile(json: true),
            child: Text(s.importJson),
          ),
          TextButton(
            onPressed: _busy ? null : _importMock,
            child: Text(s.loadMockAttendance),
          ),
          const SizedBox(height: GpSpacing.lg),
          Text(
            s.reconcileAttendance,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextField(
            controller: _expected,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.expectedCount),
          ),
          TextField(
            controller: _from,
            decoration: const InputDecoration(labelText: 'From (YYYY-MM-DD)'),
          ),
          TextField(
            controller: _to,
            decoration: const InputDecoration(labelText: 'To (YYYY-MM-DD)'),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: _reconcileNow,
              child: Text(s.reconcileAttendance),
            ),
          ),
          if (_reconcile != null)
            Text(
              '${_reconcile!.explanation} Source ${_reconcile!.expected} · GymPulse ${_reconcile!.actual} · unmatched ${_reconcile!.unmatched}.',
            ),
          const SizedBox(height: GpSpacing.lg),
          Text(s.adapters, style: Theme.of(context).textTheme.titleMedium),
          Text(
            s.windowsConnectorHelp,
            style: const TextStyle(color: GpColors.textSecondary),
          ),
          for (final adapter in const AdapterCatalog().descriptors)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(adapter.displayName),
              subtitle: Text('${adapter.status} · ${adapter.summary}'),
            ),
          if (_error != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_error!, style: const TextStyle(color: GpColors.danger)),
          ],
          if (_report != null) ...[
            const SizedBox(height: GpSpacing.lg),
            Text(
              '${s.imported}: ${_report!.created} · ${s.skipped}: ${_report!.skipped} · ${s.unmatched}: ${_report!.unmatched} · ${s.errors}: ${_report!.errors}',
            ),
            if (_report!.errorLines.isNotEmpty)
              Text(
                _report!.errorLines.join('\n'),
                style: const TextStyle(color: GpColors.warning),
              ),
            if (!_report!.sourceHealth.isDataReliable)
              Text(
                _report!.sourceHealth.message ?? s.attendanceUnavailable,
                style: const TextStyle(color: GpColors.warning),
              ),
          ],
        ],
      ),
    );
  }
}
