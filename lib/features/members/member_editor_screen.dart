import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
  late final _name = TextEditingController(
    text: widget.existing == null
        ? ''
        : '${widget.existing!.firstName} ${widget.existing!.lastName}'.trim(),
  );
  late final _phone = TextEditingController(text: widget.existing?.phone);
  late final _notes = TextEditingController(text: widget.existing?.notes);
  late DateTime _joined =
      widget.existing?.joinedAt?.toLocal() ??
      widget.existing?.createdAt.toLocal() ??
      DateTime.now();
  late String _status = widget.existing?.status ?? 'active';
  late String? _gender = widget.existing?.gender;
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _notes.dispose();
    super.dispose();
  }

  (String, String) _splitName(String raw) {
    final parts = raw.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return ('', '');
    if (parts.length == 1) return (parts.first, '');
    return (parts.first, parts.sublist(1).join(' '));
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
      final names = _splitName(_name.text);
      if (names.$1.isEmpty) {
        throw AppException(
          code: AppErrorCodes.validationInvalidField,
          message: 'Full name is required.',
        );
      }
      if (widget.existing == null) {
        await repo.create(
          organizationId: workspace.organization.id,
          locationId: workspace.location.id,
          firstName: names.$1,
          lastName: names.$2,
          phone: _phone.text,
          joinedAt: _joined,
          feeDay: _joined.day,
          gender: _gender,
          notes: _notes.text,
          status: _status,
        );
      } else {
        await repo.update(
          organizationId: workspace.organization.id,
          id: widget.existing!.id,
          firstName: names.$1,
          lastName: names.$2,
          phone: _phone.text,
          joinedAt: _joined,
          feeDay: _joined.day,
          gender: _gender,
          notes: _notes.text,
          status: _status,
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
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: s.fullName),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: s.whatsappNumber),
          ),
          const SizedBox(height: GpSpacing.md),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(s.joiningFeeDate),
            subtitle: Text(
              '${DateFormat.yMMMMd().format(_joined)}\n${s.joiningFeeDateHelp}',
            ),
            isThreeLine: true,
            trailing: const Icon(Icons.calendar_today_outlined),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _joined,
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _joined = picked);
            },
          ),
          const SizedBox(height: GpSpacing.md),
          DropdownButtonFormField<String>(
            // ignore: deprecated_member_use
            value: _status,
            decoration: InputDecoration(labelText: s.status),
            items: const [
              DropdownMenuItem(value: 'active', child: Text('Active')),
              DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _status = v);
            },
          ),
          const SizedBox(height: GpSpacing.md),
          DropdownButtonFormField<String?>(
            // ignore: deprecated_member_use
            value: _gender,
            decoration: InputDecoration(labelText: s.genderOptional),
            items: const [
              DropdownMenuItem(value: null, child: Text('Not specified')),
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
              DropdownMenuItem(value: 'other', child: Text('Other')),
            ],
            onChanged: (v) => setState(() => _gender = v),
          ),
          const SizedBox(height: GpSpacing.md),
          TextField(
            controller: _notes,
            maxLines: 3,
            decoration: InputDecoration(labelText: s.notesOptional),
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
