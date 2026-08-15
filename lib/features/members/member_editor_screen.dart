import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../data/db/app_database.dart';

class MemberEditorScreen extends ConsumerStatefulWidget {
  const MemberEditorScreen({super.key, this.existing});

  final Member? existing;

  @override
  ConsumerState<MemberEditorScreen> createState() => _MemberEditorScreenState();
}

class _MemberEditorScreenState extends ConsumerState<MemberEditorScreen> {
  late final _first = TextEditingController(text: widget.existing?.firstName);
  late final _last = TextEditingController(text: widget.existing?.lastName);
  late final _phone = TextEditingController(text: widget.existing?.phone);
  late final _email = TextEditingController(text: widget.existing?.email);
  late final _external = TextEditingController(
    text: widget.existing?.externalMemberId,
  );
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _phone.dispose();
    _email.dispose();
    _external.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final repo = ref.read(memberRepositoryProvider);
      if (widget.existing == null) {
        await repo.create(
          organizationId: workspace.organization.id,
          locationId: workspace.location.id,
          firstName: _first.text,
          lastName: _last.text,
          phone: _phone.text,
          email: _email.text,
          externalMemberId: _external.text,
        );
      } else {
        await repo.update(
          organizationId: workspace.organization.id,
          id: widget.existing!.id,
          firstName: _first.text,
          lastName: _last.text,
          phone: _phone.text,
          email: _email.text,
          externalMemberId: _external.text,
        );
      }
      if (mounted) Navigator.of(context).pop();
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
      appBar: AppBar(
        title: Text(widget.existing == null ? s.addMember : s.editMember),
      ),
      body: ListView(
        padding: const EdgeInsets.all(GpSpacing.lg),
        children: [
          TextField(
            controller: _first,
            decoration: InputDecoration(labelText: s.firstName),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _last,
            decoration: InputDecoration(labelText: s.lastName),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: s.phoneOptional),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: s.emailOptional),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _external,
            decoration: InputDecoration(labelText: s.externalMemberId),
          ),
          if (_error != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_error!, style: const TextStyle(color: GpColors.danger)),
          ],
          const SizedBox(height: GpSpacing.lg),
          FilledButton(onPressed: _busy ? null : _save, child: Text(s.save)),
        ],
      ),
    );
  }
}
