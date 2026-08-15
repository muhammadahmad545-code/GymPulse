import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme/gp_theme.dart';
import '../settings/backup_settings_screen.dart';
import '../settings/settings_screen.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    final pages = [
      const _HomePage(),
      const _PlaceholderPage(
        title: 'Members',
        body: 'Member management arrives in Phase 1.',
      ),
      const _PlaceholderPage(
        title: 'Actions',
        body: 'Follow-up queue arrives in Phase 1.',
      ),
      const _PlaceholderPage(
        title: 'Analytics',
        body: 'Analytics arrives after attendance ingestion.',
      ),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: s.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_outline),
            label: s.navMembers,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bolt_outlined),
            label: s.navActions,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.insights_outlined),
            label: s.navAnalytics,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: s.navSettings,
          ),
        ],
      ),
    );
  }
}

class _HomePage extends ConsumerWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(appStringsProvider);
    return ListView(
      padding: const EdgeInsets.all(GpSpacing.lg),
      children: [
        Text(s.appName, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: GpSpacing.xs),
        Text(s.tagline, style: const TextStyle(color: GpColors.textSecondary)),
        const SizedBox(height: GpSpacing.lg),
        const _BackupReminderCard(),
        const SizedBox(height: GpSpacing.md),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(GpSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.phase0HomeTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: GpSpacing.sm),
                Text(s.phase0HomeBody),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BackupReminderCard extends ConsumerStatefulWidget {
  const _BackupReminderCard();

  @override
  ConsumerState<_BackupReminderCard> createState() =>
      _BackupReminderCardState();
}

class _BackupReminderCardState extends ConsumerState<_BackupReminderCard> {
  String? _lastLabel;
  bool _stale = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final status = await ref.read(backupServiceProvider).status();
      if (!mounted) return;
      setState(() {
        _stale = status.isStale;
        _lastLabel = status.lastBackupAt?.toLocal().toString();
        _error = status.lastErrorMessage;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(GpSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.backupRestore,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: GpSpacing.sm),
            Text('${s.lastBackup}: ${_lastLabel ?? s.neverBackedUp}'),
            if (_stale) ...[
              const SizedBox(height: GpSpacing.sm),
              Text(
                s.backupStaleWarning,
                style: const TextStyle(color: GpColors.warning),
              ),
            ],
            if (_error != null) ...[
              const SizedBox(height: GpSpacing.sm),
              Text(_error!, style: const TextStyle(color: GpColors.danger)),
            ],
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const BackupSettingsScreen(),
                    ),
                  );
                },
                child: Text(s.backupNow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(GpSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: GpSpacing.md),
          Text(body, style: const TextStyle(color: GpColors.textSecondary)),
        ],
      ),
    );
  }
}
