import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../domain/services/retention_service.dart';

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
  final _trialDays = TextEditingController(text: '7');
  final _wDecline = TextEditingController(text: '30');
  final _wInactivity = TextEditingController(text: '25');
  final _wExpiry = TextEditingController(text: '20');
  final _wEngagement = TextEditingController(text: '15');
  final _wHistory = TextEditingController(text: '10');
  final _capacity = TextEditingController();
  final _peakThreshold = TextEditingController();
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
    _trialDays.dispose();
    _wDecline.dispose();
    _wInactivity.dispose();
    _wExpiry.dispose();
    _wEngagement.dispose();
    _wHistory.dispose();
    _capacity.dispose();
    _peakThreshold.dispose();
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
      _trialDays.text = '${workspace.settings.trialDefaultDays}';
      final weights = RiskWeights.fromJson(workspace.settings.riskWeightsJson);
      _wDecline.text = '${weights.decline}';
      _wInactivity.text = '${weights.inactivity}';
      _wExpiry.text = '${weights.expiry}';
      _wEngagement.text = '${weights.engagement}';
      _wHistory.text = '${weights.history}';
      _capacity.text = workspace.location.capacity?.toString() ?? '';
      _peakThreshold.text =
          workspace.settings.peakHighAttendance?.toString() ?? '';
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
            trialDefaultDays: int.tryParse(_trialDays.text),
            peakHighAttendance: int.tryParse(_peakThreshold.text),
            riskWeightsJson: RiskWeights(
              decline: int.tryParse(_wDecline.text) ?? 30,
              inactivity: int.tryParse(_wInactivity.text) ?? 25,
              expiry: int.tryParse(_wExpiry.text) ?? 20,
              engagement: int.tryParse(_wEngagement.text) ?? 15,
              history: int.tryParse(_wHistory.text) ?? 10,
            ).toJson(),
          );
      await ref
          .read(workspaceServiceProvider)
          .updateLocationCapacity(
            locationId: workspace.location.id,
            capacity: int.tryParse(_capacity.text),
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
            controller: _capacity,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.capacityOptional),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _peakThreshold,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.peakHighAttendance),
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
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _trialDays,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.trialDefaultDays),
          ),
          const SizedBox(height: GpSpacing.lg),
          Text(s.riskWeights, style: Theme.of(context).textTheme.titleMedium),
          Text(
            s.notAnAiScore,
            style: const TextStyle(color: GpColors.textSecondary),
          ),
          const SizedBox(height: GpSpacing.sm),
          TextField(
            controller: _wDecline,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: 'Decline weight'),
          ),
          TextField(
            controller: _wInactivity,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: 'Inactivity weight'),
          ),
          TextField(
            controller: _wExpiry,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: 'Expiry weight'),
          ),
          TextField(
            controller: _wEngagement,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: 'Engagement weight'),
          ),
          TextField(
            controller: _wHistory,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: 'History weight'),
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
