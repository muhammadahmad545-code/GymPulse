import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';
import '../core/theme/gp_theme.dart';
import '../features/security/pin_setup_screen.dart';
import '../features/security/unlock_screen.dart';
import '../features/setup/org_setup_screen.dart';
import '../features/shell/app_shell.dart';

class MrGymApp extends ConsumerStatefulWidget {
  const MrGymApp({super.key});

  @override
  ConsumerState<MrGymApp> createState() => _MrGymAppState();
}

class _MrGymAppState extends ConsumerState<MrGymApp>
    with WidgetsBindingObserver {
  DateTime? _pausedAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPinState();
    _loadTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadPinState() async {
    final configured = await ref
        .read(securityServiceProvider)
        .isPinConfigured();
    if (!mounted) return;
    ref.read(pinConfiguredProvider.notifier).state = configured;
    if (configured) {
      ref.read(sessionUnlockedProvider.notifier).state = false;
    }
  }

  Future<void> _loadTheme() async {
    final mode = await ref.read(appearanceServiceProvider).load();
    if (!mounted) return;
    ref.read(themeModeProvider.notifier).state = mode;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pausedAt = DateTime.now();
    }
    if (state == AppLifecycleState.resumed && _pausedAt != null) {
      final elapsed = DateTime.now().difference(_pausedAt!);
      if (elapsed.inSeconds >= 120 && ref.read(sessionUnlockedProvider)) {
        ref.read(securityServiceProvider).lock();
        ref.read(sessionUnlockedProvider.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final unlocked = ref.watch(sessionUnlockedProvider);
    final pinConfigured = ref.watch(pinConfiguredProvider);
    final themeMode = ref.watch(themeModeProvider);
    final s = ref.watch(appStringsProvider);

    Widget home;
    if (pinConfigured == null) {
      home = const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (pinConfigured == false) {
      home = const PinSetupScreen();
    } else if (!unlocked) {
      home = const UnlockScreen();
    } else {
      final workspace = ref.watch(workspaceProvider);
      home = workspace.when(
        data: (value) =>
            value == null ? const OrgSetupScreen() : const AppShell(),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (_, __) => const OrgSetupScreen(),
      );
    }

    return MaterialApp(
      title: s.appName,
      debugShowCheckedModeBanner: false,
      theme: buildMrGymLightTheme(),
      darkTheme: buildMrGymDarkTheme(),
      themeMode: themeMode,
      home: home,
    );
  }
}
