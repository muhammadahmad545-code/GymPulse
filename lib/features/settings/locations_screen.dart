import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../data/db/app_database.dart';

class LocationsScreen extends ConsumerStatefulWidget {
  const LocationsScreen({super.key});

  @override
  ConsumerState<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends ConsumerState<LocationsScreen> {
  List<Location> _locations = const [];
  String? _currentId;
  String? _error;
  final _name = TextEditingController();
  final _capacity = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _name.dispose();
    _capacity.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final workspace = await ref.read(workspaceProvider.future);
    if (workspace == null || !mounted) return;
    final rows = await ref.read(workspaceServiceProvider).listLocations();
    setState(() {
      _locations = rows;
      _currentId = workspace.location.id;
    });
  }

  Future<void> _switchTo(String id) async {
    try {
      await ref.read(workspaceServiceProvider).switchLocation(id);
      ref.read(workspaceRefreshProvider.notifier).state++;
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> _add() async {
    setState(() => _error = null);
    try {
      await ref
          .read(workspaceServiceProvider)
          .addLocation(
            name: _name.text,
            capacity: int.tryParse(_capacity.text),
          );
      _name.clear();
      _capacity.clear();
      ref.read(workspaceRefreshProvider.notifier).state++;
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(s.locations)),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          Text(s.addAnotherLocation),
          const SizedBox(height: GpSpacing.md),
          for (final location in _locations)
            Card(
              child: ListTile(
                title: Text(location.name),
                subtitle: Text(
                  [
                    location.timezone,
                    if (location.capacity != null)
                      'capacity ${location.capacity}',
                    if (location.id == _currentId) s.currentLocation,
                  ].join(' · '),
                ),
                trailing: location.id == _currentId
                    ? const Icon(Icons.check)
                    : TextButton(
                        onPressed: () => _switchTo(location.id),
                        child: Text(s.switchLocation),
                      ),
              ),
            ),
          const SizedBox(height: GpSpacing.lg),
          Text(s.addLocation, style: Theme.of(context).textTheme.titleMedium),
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: s.locationName),
          ),
          TextField(
            controller: _capacity,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: s.capacityOptional),
          ),
          if (_error != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_error!, style: const TextStyle(color: GpColors.danger)),
          ],
          const SizedBox(height: GpSpacing.md),
          FilledButton(onPressed: _add, child: Text(s.addLocation)),
        ],
      ),
    );
  }
}
