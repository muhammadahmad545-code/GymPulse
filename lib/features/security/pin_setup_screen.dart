import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_logo.dart';
import '../../core/theme/gp_theme.dart';

class PinSetupScreen extends ConsumerStatefulWidget {
  const PinSetupScreen({super.key});

  @override
  ConsumerState<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends ConsumerState<PinSetupScreen> {
  final _pinController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _pinController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(securityServiceProvider)
          .setupPin(
            pin: _pinController.text,
            confirmPin: _confirmController.text,
          );
      ref.read(pinConfiguredProvider.notifier).state = true;
      ref.read(sessionUnlockedProvider.notifier).state = true;
    } on AppException catch (e) {
      setState(() => _error = e.message);
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
        child: ListView(
          padding: const EdgeInsets.all(GpSpacing.lg),
          children: [
            GpBrandHeader(subtitle: s.setupPinTitle),
            const SizedBox(height: GpSpacing.sm),
            Text(
              s.setupPinSubtitle,
              style: const TextStyle(color: GpColors.textSecondary),
            ),
            const SizedBox(height: GpSpacing.lg),
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: s.pinLabel),
            ),
            const SizedBox(height: GpSpacing.md),
            TextField(
              controller: _confirmController,
              obscureText: true,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: s.pinConfirmLabel),
            ),
            const SizedBox(height: GpSpacing.md),
            Container(
              padding: const EdgeInsets.all(GpSpacing.md),
              decoration: BoxDecoration(
                color: GpColors.surfaceElevated,
                borderRadius: BorderRadius.circular(GpRadii.sm),
                border: Border.all(color: GpColors.border),
              ),
              child: Text(
                s.backupEducation,
                style: const TextStyle(color: GpColors.textSecondary),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: GpSpacing.md),
              Text(_error!, style: const TextStyle(color: GpColors.danger)),
            ],
            const SizedBox(height: GpSpacing.lg),
            FilledButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(s.continueAction),
            ),
          ],
        ),
      ),
    );
  }
}
