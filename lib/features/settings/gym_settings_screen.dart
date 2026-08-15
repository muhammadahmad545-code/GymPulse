import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';

class GymSettingsScreen extends ConsumerStatefulWidget {
  const GymSettingsScreen({super.key});

  @override
  ConsumerState<GymSettingsScreen> createState() => _GymSettingsScreenState();
}

class _GymSettingsScreenState extends ConsumerState<GymSettingsScreen> {
  final _phone = TextEditingController();
  final _staleHours = TextEditingController(text: '24');
  final _monitor = TextEditingController(text: '7');
  final _follow = TextEditingController(text: '14');
  final _high = TextEditingController(text: '21');
  final _critical = TextEditingController(text: '30');
  String? _message;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _phone.dispose();
    _staleHours.dispose();
    _monitor.dispose();
    _follow.dispose();
    _high.dispose();
    _critical.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null || !mounted) return;
    setState(() {
      _phone.text = workspace.settings.gymPhone ?? '';
      _staleHours.text = '${workspace.settings.staleImportHours}';
      _monitor.text = '${workspace.settings.inactivityMonitorDays}';
      _follow.text = '${workspace.settings.inactivityFollowUpDays}';
      _high.text = '${workspace.settings.inactivityHighRiskDays}';
      _critical.text = '${workspace.settings.inactivityCriticalDays}';
    });
  }

  Future<void> _save() async {
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      await ref
          .read(workspaceServiceProvider)
          .updateSettings(
            locationId: workspace.location.id,
            gymPhone: _phone.text,
            staleImportHours: int.tryParse(_staleHours.text),
            inactivityMonitorDays: int.tryParse(_monitor.text),
            inactivityFollowUpDays: int.tryParse(_follow.text),
            inactivityHighRiskDays: int.tryParse(_high.text),
            inactivityCriticalDays: int.tryParse(_critical.text),
          );
      ref.read(workspaceRefreshProvider.notifier).state++;
      setState(() => _message = ref.read(appStringsProvider).saved);
    } on AppException catch (e) {
      setState(() => _message = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(s.gymSettings)),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          TextField(
            controller: _phone,
            decoration: InputDecoration(labelText: s.gymPhoneOptional),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _staleHours,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.staleImportHours),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _monitor,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.inactivityMonitor),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _follow,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.inactivityFollowUp),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _high,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.inactivityHighRisk),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _critical,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.inactivityCritical),
          ),
          if (_message != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_message!),
          ],
          const SizedBox(height: GpSpacing.lg),
          FilledButton(onPressed: _save, child: Text(s.save)),
        ],
      ),
    );
  }
}
