import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import 'recovery_screen.dart';

class UnlockScreen extends ConsumerStatefulWidget {
  const UnlockScreen({super.key});

  @override
  ConsumerState<UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends ConsumerState<UnlockScreen> {
  final _pinController = TextEditingController();
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _unlock() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final result = await ref
          .read(securityServiceProvider)
          .unlock(_pinController.text);
      if (result.success) {
        ref.read(sessionUnlockedProvider.notifier).state = true;
        return;
      }
      setState(() {
        if (result.errorCode == AppErrorCodes.authLockoutActive &&
            result.lockoutRemainingSeconds != null) {
          _error = ref
              .read(appStringsProvider)
              .lockoutCooldown(result.lockoutRemainingSeconds!);
        } else {
          _error = result.message ?? ref.read(appStringsProvider).incorrectPin;
        }
      });
    } catch (_) {
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(GpSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                s.appName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: GpSpacing.sm),
              Text(
                s.unlockTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: GpSpacing.lg),
              TextField(
                controller: _pinController,
                obscureText: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(labelText: s.unlockHint),
                onSubmitted: (_) => _unlock(),
              ),
              if (_error != null) ...[
                const SizedBox(height: GpSpacing.md),
                Text(_error!, style: const TextStyle(color: GpColors.danger)),
              ],
              const SizedBox(height: GpSpacing.lg),
              FilledButton(
                onPressed: _busy ? null : _unlock,
                child: Text(s.unlockAction),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RecoveryScreen()),
                  );
                },
                child: Text(s.forgotPin),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
