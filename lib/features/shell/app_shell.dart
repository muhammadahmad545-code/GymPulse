import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../actions/actions_screen.dart';
import '../analytics/analytics_screen.dart';
import '../home/home_screen.dart';
import '../members/members_screen.dart';
import '../search/search_screen.dart';
import '../settings/app_update_flow.dart';
import '../settings/settings_screen.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell>
    with WidgetsBindingObserver {
  int _index = 0;
  bool _startupCheckStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkForUpdatesQuietly(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    final pending = ref.read(pendingInstallProvider);
    if (pending == null) return;
    ref.read(pendingInstallProvider.notifier).state = null;
    final current = ref.read(appConfigProvider).versionCode;
    if (pending.versionCode <= current || !mounted) return;
    final s = ref.read(appStringsProvider);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(s.installerLaunched)));
  }

  Future<void> _checkForUpdatesQuietly() async {
    if (_startupCheckStarted) return;
    _startupCheckStarted = true;
    final config = ref.read(appConfigProvider);
    if (!config.hasGithubUpdateSource) return;
    try {
      final update = await ref.read(appUpdateServiceProvider).checkForUpdate();
      if (update == null || !mounted) return;
      ref.read(availableUpdateProvider.notifier).state = update;
      await ref
          .read(localNotificationServiceProvider)
          .show(
            id: 20,
            title: ref.read(appStringsProvider).updateAvailable,
            body: 'Mr. Gym ${update.versionName} is ready to install.',
          );
      if (!mounted) return;
      await showAppUpdateSheet(context: context, ref: ref, info: update);
    } catch (_) {
      // Optional network feature — core app stays usable offline.
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    final pages = const [
      HomeScreen(),
      MembersScreen(),
      ActionsScreen(),
      AnalyticsScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(s.appName),
        actions: [
          IconButton(
            tooltip: s.searchEverything,
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
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
