import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_logo.dart';
import '../../core/theme/gp_theme.dart';
import 'app_update_flow.dart';
import 'backup_settings_screen.dart';
import 'cancellation_reasons_screen.dart';
import 'gym_settings_screen.dart';
import 'notification_settings_screen.dart';
import 'reports_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  String? _message;
  String? _updateMessage;
  bool _checkingUpdate = false;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _checkForUpdates() async {
    final s = ref.read(appStringsProvider);
    setState(() {
      _checkingUpdate = true;
      _updateMessage = s.checkingForUpdates;
    });
    try {
      final update = await ref.read(appUpdateServiceProvider).checkForUpdate();
      if (!mounted) return;
      if (update == null) {
        setState(() => _updateMessage = s.upToDate);
        return;
      }
      ref.read(availableUpdateProvider.notifier).state = update;
      setState(() => _updateMessage = s.updateAvailable);
      await showAppUpdateSheet(context: context, ref: ref, info: update);
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() => _updateMessage = e.message);
    } catch (_) {
      if (!mounted) return;
      setState(() => _updateMessage = s.updateCheckFailed);
    } finally {
      if (mounted) setState(() => _checkingUpdate = false);
    }
  }

  Future<void> _changePin() async {
    setState(() => _message = null);
    try {
      await ref
          .read(securityServiceProvider)
          .changePin(
            currentPin: _current.text,
            newPin: _next.text,
            confirmNewPin: _confirm.text,
          );
      _current.clear();
      _next.clear();
      _confirm.clear();
      setState(() => _message = 'PIN updated.');
    } on AppException catch (e) {
      setState(() => _message = e.message);
    } catch (_) {
      setState(
        () => _message = ref.read(appStringsProvider).somethingWentWrong,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    final config = ref.watch(appConfigProvider);
    return ListView(
      padding: const EdgeInsets.all(GpSpacing.lg),
      children: [
        GpBrandHeader(logoSize: 48, compact: true, subtitle: s.settingsTitle),
        const SizedBox(height: GpSpacing.lg),
        Text(s.appearanceTitle, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: GpSpacing.sm),
        SegmentedButton<ThemeMode>(
          segments: [
            ButtonSegment(
              value: ThemeMode.dark,
              label: Text(s.themeDark),
              icon: const Icon(Icons.dark_mode_outlined),
            ),
            ButtonSegment(
              value: ThemeMode.light,
              label: Text(s.themeLight),
              icon: const Icon(Icons.light_mode_outlined),
            ),
            ButtonSegment(
              value: ThemeMode.system,
              label: Text(s.themeSystem),
              icon: const Icon(Icons.phone_android_outlined),
            ),
          ],
          selected: {ref.watch(themeModeProvider)},
          onSelectionChanged: (value) async {
            final mode = value.first;
            ref.read(themeModeProvider.notifier).state = mode;
            await ref.read(appearanceServiceProvider).save(mode);
          },
        ),
        const SizedBox(height: GpSpacing.lg),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(s.backupRestore),
          subtitle: Text(s.backupEducation),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BackupSettingsScreen()),
            );
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(s.gymSettings),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GymSettingsScreen()),
            );
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(s.cancellationReasons),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CancellationReasonsScreen(),
              ),
            );
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(s.exportReports),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ReportsScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(s.notificationPrefs),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const NotificationSettingsScreen(),
              ),
            );
          },
        ),
        const Divider(),
        Text(s.securityTitle, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: GpSpacing.sm),
        TextField(
          controller: _current,
          obscureText: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(labelText: 'Current PIN'),
        ),
        const SizedBox(height: GpSpacing.sm),
        TextField(
          controller: _next,
          obscureText: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(labelText: s.pinLabel),
        ),
        const SizedBox(height: GpSpacing.sm),
        TextField(
          controller: _confirm,
          obscureText: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(labelText: s.pinConfirmLabel),
        ),
        if (_message != null) ...[
          const SizedBox(height: GpSpacing.sm),
          Text(_message!),
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(onPressed: _changePin, child: Text(s.changePin)),
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(s.lockApp),
          onTap: () {
            ref.read(securityServiceProvider).lock();
            ref.read(sessionUnlockedProvider.notifier).state = false;
          },
        ),
        const Divider(),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(s.checkForUpdates),
          subtitle: Text(
            _updateMessage ??
                'v${config.versionName} (${config.versionCode}) · ${config.applicationId}',
          ),
          trailing: _checkingUpdate
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.system_update_alt),
          onTap: _checkingUpdate ? null : _checkForUpdates,
        ),
        Text(
          s.updatesNeedNetwork,
          style: const TextStyle(color: GpColors.textSecondary),
        ),
        const SizedBox(height: GpSpacing.lg),
        Text(
          'v${config.versionName} (${config.versionCode}) · ${config.applicationId}',
          style: const TextStyle(color: GpColors.textSecondary),
        ),
      ],
    );
  }
}
