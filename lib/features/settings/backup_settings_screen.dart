import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/backup_service.dart';

class BackupSettingsScreen extends ConsumerStatefulWidget {
  const BackupSettingsScreen({super.key});

  @override
  ConsumerState<BackupSettingsScreen> createState() =>
      _BackupSettingsScreenState();
}

class _BackupSettingsScreenState extends ConsumerState<BackupSettingsScreen> {
  BackupStatus? _status;
  String? _error;
  String? _info;
  bool _busy = false;
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _restorePassword = TextEditingController();
  int _intervalDays = 7;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    _restorePassword.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final status = await ref.read(backupServiceProvider).status();
      if (!mounted) return;
      setState(() {
        _status = status;
        _intervalDays = status.intervalDays;
        _error = status.lastErrorMessage;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    }
  }

  Future<void> _backupNow() async {
    setState(() {
      _busy = true;
      _error = null;
      _info = null;
    });
    try {
      final file = await ref
          .read(backupServiceProvider)
          .createEncryptedBackup(
            password: _password.text,
            confirmPassword: _confirm.text,
          );
      _password.clear();
      _confirm.clear();
      await _load();
      if (!mounted) return;
      setState(
        () => _info =
            '${ref.read(appStringsProvider).backupCreated} ${file.path}',
      );
    } on AppException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _shareLast() async {
    final path = _status?.lastBackupPath;
    if (path == null || !File(path).existsSync()) {
      setState(() => _error = ref.read(appStringsProvider).noBackupToShare);
      return;
    }
    try {
      await SharePlus.instance.share(ShareParams(files: [XFile(path)]));
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    }
  }

  Future<void> _restore() async {
    setState(() {
      _busy = true;
      _error = null;
      _info = null;
    });
    try {
      final picked = await FilePicker.platform.pickFiles(type: FileType.any);
      final path = picked?.files.single.path;
      if (path == null) {
        setState(() => _error = 'No backup file was selected.');
        return;
      }
      await ref
          .read(backupServiceProvider)
          .restoreEncryptedBackup(
            backupFile: File(path),
            password: _restorePassword.text,
          );
      await ref.read(securityServiceProvider).syncRestoredPinToSecureStore();
      _restorePassword.clear();
      ref.read(sessionUnlockedProvider.notifier).state = false;
      if (!mounted) return;
      setState(() => _info = ref.read(appStringsProvider).restoreSucceeded);
    } on AppException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _exportMembers() async {
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final csv = await ref
          .read(csvInteropServiceProvider)
          .exportMembers(workspace);
      await SharePlus.instance.share(ShareParams(text: csv));
    } on AppException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    }
  }

  Future<void> _importMembers() async {
    try {
      final picked = await FilePicker.platform.pickFiles(type: FileType.any);
      final path = picked?.files.single.path;
      if (path == null) return;
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final created = await ref
          .read(csvInteropServiceProvider)
          .importMembers(
            workspace: workspace,
            csv: await File(path).readAsString(),
          );
      setState(
        () => _info = '${ref.read(appStringsProvider).imported}: $created',
      );
    } on AppException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    }
  }

  Future<void> _saveReminder() async {
    try {
      await ref
          .read(backupServiceProvider)
          .updateReminderSettings(intervalDays: _intervalDays, enabled: true);
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    final last = _status?.lastBackupAt;
    final lastLabel = last == null
        ? s.neverBackedUp
        : DateFormat.yMMMd().add_Hm().format(last.toLocal());

    return Scaffold(
      appBar: AppBar(title: Text(s.backupRestore)),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          Text('${s.lastBackup}: $lastLabel'),
          if (_status?.isStale == true) ...[
            const SizedBox(height: GpSpacing.sm),
            Text(
              s.backupStaleWarning,
              style: const TextStyle(color: GpColors.warning),
            ),
          ],
          const SizedBox(height: GpSpacing.lg),
          Text(
            s.backupReminder,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: GpSpacing.sm),
          DropdownButtonFormField<int>(
            // ignore: deprecated_member_use
            value: _intervalDays,
            items: [
              DropdownMenuItem(value: 7, child: Text(s.interval7)),
              DropdownMenuItem(value: 14, child: Text(s.interval14)),
              DropdownMenuItem(value: 30, child: Text(s.interval30)),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _intervalDays = v);
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(onPressed: _saveReminder, child: Text(s.save)),
          ),
          const SizedBox(height: GpSpacing.lg),
          Text(
            s.forgottenBackupPasswordWarning,
            style: const TextStyle(color: GpColors.warning),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(labelText: s.backupPasswordLabel),
          ),
          const SizedBox(height: GpSpacing.sm),
          TextField(
            controller: _confirm,
            obscureText: true,
            decoration: InputDecoration(
              labelText: s.backupPasswordConfirmLabel,
            ),
          ),
          const SizedBox(height: GpSpacing.lg),
          FilledButton(
            onPressed: _busy ? null : _backupNow,
            child: Text(s.backupNow),
          ),
          TextButton(
            onPressed: _busy ? null : _shareLast,
            child: Text(s.shareBackup),
          ),
          const Divider(),
          Text(s.restoreBackup, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: GpSpacing.sm),
          Text(
            s.restoreBackupSubtitle,
            style: const TextStyle(color: GpColors.textSecondary),
          ),
          const SizedBox(height: GpSpacing.sm),
          TextField(
            controller: _restorePassword,
            obscureText: true,
            decoration: InputDecoration(labelText: s.backupPasswordLabel),
          ),
          const SizedBox(height: GpSpacing.md),
          OutlinedButton(
            onPressed: _busy ? null : _restore,
            child: Text(s.restoreBackup),
          ),
          const Divider(),
          Text(s.exportCsv, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: GpSpacing.sm),
          Text(s.csvNotBackup, style: const TextStyle(color: GpColors.warning)),
          TextButton(
            onPressed: _busy ? null : _exportMembers,
            child: Text(s.exportCsv),
          ),
          TextButton(
            onPressed: _busy ? null : _importMembers,
            child: Text(s.importMembersCsv),
          ),
          if (_error != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_error!, style: const TextStyle(color: GpColors.danger)),
          ],
          if (_info != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_info!, style: const TextStyle(color: GpColors.success)),
          ],
        ],
      ),
    );
  }
}
