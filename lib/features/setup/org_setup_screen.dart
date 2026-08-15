import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/i18n/locale_catalogs.dart';
import '../../core/theme/gp_logo.dart';
import '../../core/theme/gp_theme.dart';

class OrgSetupScreen extends ConsumerStatefulWidget {
  const OrgSetupScreen({super.key});

  @override
  ConsumerState<OrgSetupScreen> createState() => _OrgSetupScreenState();
}

class _OrgSetupScreenState extends ConsumerState<OrgSetupScreen> {
  final _org = TextEditingController();
  final _location = TextEditingController();
  final _phone = TextEditingController();
  final _capacity = TextEditingController();
  CountryOption _country = LocaleCatalogs.countries.firstWhere(
    (c) => c.code == 'US',
  );
  late String _timezone = _country.timezone;
  late String _currency = _country.currency;
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _org.dispose();
    _location.dispose();
    _phone.dispose();
    _capacity.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(workspaceServiceProvider)
          .setup(
            organizationName: _org.text,
            locationName: _location.text,
            countryCode: _country.code,
            timezone: _timezone,
            currencyCode: _currency,
            capacity: int.tryParse(_capacity.text),
            gymPhone: _phone.text,
          );
      ref.read(workspaceRefreshProvider.notifier).state++;
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
            const GpBrandHeader(subtitle: null),
            const SizedBox(height: GpSpacing.sm),
            Text(
              s.setupGymTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: GpSpacing.sm),
            Text(
              s.setupGymSubtitle,
              style: const TextStyle(color: GpColors.textSecondary),
            ),
            const SizedBox(height: GpSpacing.lg),
            TextField(
              controller: _org,
              decoration: InputDecoration(labelText: s.gymName),
            ),
            const SizedBox(height: GpSpacing.md),
            TextField(
              controller: _location,
              decoration: InputDecoration(labelText: s.locationName),
            ),
            const SizedBox(height: GpSpacing.md),
            DropdownButtonFormField<CountryOption>(
              // ignore: deprecated_member_use
              value: _country,
              decoration: InputDecoration(labelText: s.country),
              items: [
                for (final c in LocaleCatalogs.countries)
                  DropdownMenuItem(
                    value: c,
                    child: Text('${c.name} (${c.code})'),
                  ),
              ],
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  _country = v;
                  _timezone = v.timezone;
                  _currency = v.currency;
                });
              },
            ),
            const SizedBox(height: GpSpacing.md),
            DropdownButtonFormField<String>(
              // ignore: deprecated_member_use
              value: _timezone,
              decoration: InputDecoration(labelText: s.timezone),
              items: [
                for (final t in LocaleCatalogs.timezones)
                  DropdownMenuItem(value: t.id, child: Text(t.label)),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _timezone = v);
              },
            ),
            const SizedBox(height: GpSpacing.md),
            DropdownButtonFormField<String>(
              // ignore: deprecated_member_use
              value: _currency,
              decoration: InputDecoration(labelText: s.currency),
              items: [
                for (final c in LocaleCatalogs.currencies)
                  DropdownMenuItem(value: c.code, child: Text(c.label)),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _currency = v);
              },
            ),
            const SizedBox(height: GpSpacing.md),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: s.gymPhoneOptional),
            ),
            const SizedBox(height: GpSpacing.md),
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
            const SizedBox(height: GpSpacing.lg),
            FilledButton(
              onPressed: _busy ? null : _submit,
              child: Text(s.continueAction),
            ),
          ],
        ),
      ),
    );
  }
}
