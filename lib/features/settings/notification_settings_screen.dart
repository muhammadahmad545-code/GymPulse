import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/operations_service.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen> {
  Map<String, bool> _prefs = {for (final key in OpsNotifyKeys.all) key: true};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null || !mounted) return;
    final prefs = await ref
        .read(operationsServiceProvider)
        .notificationPrefs(workspace.organization.id);
    setState(() => _prefs = prefs);
  }

  Future<void> _set(String key, bool enabled) async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null) return;
    await ref
        .read(operationsServiceProvider)
        .setNotificationPref(
          organizationId: workspace.organization.id,
          key: key,
          enabled: enabled,
        );
    setState(() => _prefs = {..._prefs, key: enabled});
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(s.notificationPrefs)),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          Text(
            'Local only. Mr. Gym does not use cloud push.',
            style: const TextStyle(color: GpColors.textSecondary),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(s.notifyDailySummary),
            value: _prefs[OpsNotifyKeys.dailySummary] ?? true,
            onChanged: (v) => _set(OpsNotifyKeys.dailySummary, v),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(s.notifyFeeReminders),
            value: _prefs[OpsNotifyKeys.feeReminders] ?? true,
            onChanged: (v) => _set(OpsNotifyKeys.feeReminders, v),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(s.notifyHighRisk),
            value: _prefs[OpsNotifyKeys.highRisk] ?? true,
            onChanged: (v) => _set(OpsNotifyKeys.highRisk, v),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(s.notifyExpiryQueue),
            value: _prefs[OpsNotifyKeys.expiryQueue] ?? true,
            onChanged: (v) => _set(OpsNotifyKeys.expiryQueue, v),
          ),
        ],
      ),
    );
  }
}
