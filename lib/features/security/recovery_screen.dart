import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';

class RecoveryScreen extends ConsumerStatefulWidget {
  const RecoveryScreen({super.key});

  @override
  ConsumerState<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends ConsumerState<RecoveryScreen> {
  final _backupPassword = TextEditingController();
  final _resetConfirm = TextEditingController();
  String? _error;
  String? _info;
  bool _busy = false;

  @override
  void dispose() {
    _backupPassword.dispose();
    _resetConfirm.dispose();
    super.dispose();
  }

  Future<void> _restore() async {
    setState(() {
      _busy = true;
      _error = null;
      _info = null;
    });
    try {
      final picked = await FilePicker.platform.pickFiles(
        type: FileType.any,
        withData: false,
      );
      final path = picked?.files.single.path;
      if (path == null) {
        setState(() => _error = 'No backup file was selected.');
        return;
      }
      await ref
          .read(backupServiceProvider)
          .restoreEncryptedBackup(
            backupFile: File(path),
            password: _backupPassword.text,
          );
      await ref.read(securityServiceProvider).syncRestoredPinToSecureStore();
      _backupPassword.clear();
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

  Future<void> _factoryReset() async {
    setState(() {
      _busy = true;
      _error = null;
      _info = null;
    });
    try {
      await ref
          .read(securityServiceProvider)
          .factoryReset(confirmation: _resetConfirm.text);
      ref.read(sessionUnlockedProvider.notifier).state = false;
      ref.read(pinConfiguredProvider.notifier).state = false;
      if (mounted) Navigator.of(context).pop();
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
      appBar: AppBar(title: Text(s.forgotPin)),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          Text(s.restoreBackup, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: GpSpacing.sm),
          Text(
            s.restoreBackupSubtitle,
            style: const TextStyle(color: GpColors.textSecondary),
          ),
          const SizedBox(height: GpSpacing.md),
          Text(
            s.forgottenBackupPasswordWarning,
            style: const TextStyle(color: GpColors.warning),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _backupPassword,
            obscureText: true,
            decoration: InputDecoration(labelText: s.backupPasswordLabel),
          ),
          const SizedBox(height: GpSpacing.md),
          FilledButton(
            onPressed: _busy ? null : _restore,
            child: Text(s.restoreBackup),
          ),
          const SizedBox(height: GpSpacing.xl),
          const Divider(),
          const SizedBox(height: GpSpacing.lg),
          Text(s.factoryReset, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: GpSpacing.sm),
          Text(
            s.factoryResetWarning,
            style: const TextStyle(color: GpColors.danger),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _resetConfirm,
            decoration: InputDecoration(labelText: s.factoryResetConfirmLabel),
          ),
          const SizedBox(height: GpSpacing.md),
          OutlinedButton(
            onPressed: _busy ? null : _factoryReset,
            child: Text(s.factoryReset),
          ),
          if (_error != null) ...[
            const SizedBox(height: GpSpacing.lg),
            Text(_error!, style: const TextStyle(color: GpColors.danger)),
          ],
          if (_info != null) ...[
            const SizedBox(height: GpSpacing.lg),
            Text(_info!, style: const TextStyle(color: GpColors.success)),
          ],
        ],
      ),
    );
  }
}
