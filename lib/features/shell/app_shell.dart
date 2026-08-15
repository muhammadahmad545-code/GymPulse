import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../actions/actions_screen.dart';
import '../analytics/analytics_screen.dart';
import '../home/home_screen.dart';
import '../members/members_screen.dart';
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
    final pages = const [
      HomeScreen(),
      MembersScreen(),
      ActionsScreen(),
      AnalyticsScreen(),
      SettingsScreen(),
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
