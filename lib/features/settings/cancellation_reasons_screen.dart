import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../data/db/app_database.dart';

class CancellationReasonsScreen extends ConsumerStatefulWidget {
  const CancellationReasonsScreen({super.key});

  @override
  ConsumerState<CancellationReasonsScreen> createState() =>
      _CancellationReasonsScreenState();
}

class _CancellationReasonsScreenState
    extends ConsumerState<CancellationReasonsScreen> {
  List<CancellationReason> _rows = const [];
  String? _error;
  final _label = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null) return;
    await ref
        .read(gymOpsServiceProvider)
        .seedDefaultReasons(workspace.organization.id);
    final rows = await ref
        .read(gymOpsServiceProvider)
        .listReasons(workspace.organization.id);
    if (!mounted) return;
    setState(() => _rows = rows);
  }

  Future<void> _add() async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null) return;
    try {
      await ref
          .read(gymOpsServiceProvider)
          .addReason(
            organizationId: workspace.organization.id,
            label: _label.text,
          );
      _label.clear();
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(s.cancellationReasons)),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          Text(
            'Deactivating a reason keeps historical cancellations intact.',
            style: const TextStyle(color: GpColors.textSecondary),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _label,
            decoration: const InputDecoration(labelText: 'New reason'),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(onPressed: _add, child: const Text('Add reason')),
          ),
          if (_error != null)
            Text(_error!, style: const TextStyle(color: GpColors.danger)),
          for (final row in _rows)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(row.label),
              subtitle: Text(row.code),
              value: row.active,
              onChanged: (v) async {
                final workspace = await ref.read(workspaceProvider.future);
                if (workspace == null) return;
                await ref
                    .read(gymOpsServiceProvider)
                    .setReasonActive(
                      organizationId: workspace.organization.id,
                      id: row.id,
                      active: v,
                    );
                await _load();
              },
            ),
        ],
      ),
    );
  }
}
