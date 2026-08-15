import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/attendance_ingest_service.dart';

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  ImportReport? _report;
  String? _error;
  bool _busy = false;

  Future<void> _importFile() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['csv', 'txt'],
      );
      final path = picked?.files.single.path;
      if (path == null) {
        setState(() => _error = 'No file was selected.');
        return;
      }
      final csv = await File(path).readAsString();
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final report = await ref
          .read(attendanceIngestServiceProvider)
          .importCsv(workspace: workspace, csv: csv);
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
            onPressed: _busy ? null : _importFile,
            child: Text(s.importCsv),
          ),
          TextButton(
            onPressed: _busy ? null : _importMock,
            child: Text(s.loadMockAttendance),
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
