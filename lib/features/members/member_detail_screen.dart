import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../data/db/app_database.dart';
import '../../domain/models/workspace.dart';
import '../../domain/services/intelligence_service.dart';
import '../../domain/services/retention_service.dart';
import 'member_editor_screen.dart';

class MemberDetailScreen extends ConsumerStatefulWidget {
  const MemberDetailScreen({super.key, required this.memberId});

  final String memberId;

  @override
  ConsumerState<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends ConsumerState<MemberDetailScreen> {
  Member? _member;
  MemberInsight? _insight;
  Workspace? _workspace;
  MemberRisk? _risk;
  List<TimelineItem> _timeline = const [];
  Trial? _trial;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final workspace = await ref.read(workspaceProvider.future);
      if (workspace == null) return;
      final member = await ref
          .read(memberRepositoryProvider)
          .get(organizationId: workspace.organization.id, id: widget.memberId);
      final health = await ref
          .read(attendanceIngestServiceProvider)
          .importHealth(workspace);
      final insights = await ref
          .read(intelligenceServiceProvider)
          .memberInsights(workspace: workspace, importHealth: health);
      final snap = await ref
          .read(retentionServiceProvider)
          .snapshot(workspace: workspace, importHealth: health);
      final trial = await ref
          .read(retentionServiceProvider)
          .activeTrial(workspace: workspace, memberId: widget.memberId);
      final timeline = await ref
          .read(retentionServiceProvider)
          .timeline(workspace: workspace, memberId: widget.memberId);
      if (!mounted) return;
      setState(() {
        _workspace = workspace;
        _member = member;
        _insight = insights
            .where((i) => i.member.id == widget.memberId)
            .cast<MemberInsight?>()
            .firstWhere((e) => true, orElse: () => null);
        _risk = snap.risks
            .where((r) => r.memberId == widget.memberId)
            .cast<MemberRisk?>()
            .firstWhere((e) => true, orElse: () => null);
        _trial = trial;
        _timeline = timeline;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = ref.read(appStringsProvider).somethingWentWrong);
    }
  }

  Future<void> _addMembership() async {
    final workspace = _workspace;
    final member = _member;
    if (workspace == null || member == null) return;
    final start = DateTime.now().toUtc();
    try {
      await ref
          .read(membershipRepositoryProvider)
          .create(
            organizationId: workspace.organization.id,
            locationId: workspace.location.id,
            memberId: member.id,
            startAt: start,
            endAt: start.add(const Duration(days: 30)),
            status: 'active',
            currencyCode: workspace.location.currencyCode,
          );
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> _renew() async {
    final workspace = _workspace;
    final membership = _insight?.membership;
    if (workspace == null || membership == null) return;
    try {
      await ref
          .read(retentionServiceProvider)
          .renewExplicit(workspace: workspace, current: membership);
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> _startTrial() async {
    final workspace = _workspace;
    if (workspace == null) return;
    try {
      await ref
          .read(retentionServiceProvider)
          .startTrial(workspace: workspace, memberId: widget.memberId);
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> _convertTrial() async {
    final workspace = _workspace;
    final trial = _trial;
    if (workspace == null || trial == null) return;
    try {
      await ref
          .read(retentionServiceProvider)
          .convertTrial(workspace: workspace, trialId: trial.id);
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> _cancelMembership() async {
    final workspace = _workspace;
    if (workspace == null) return;
    String reason = 'other';
    final extra = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(ref.read(appStringsProvider).recordCancellation),
          content: StatefulBuilder(
            builder: (ctx, setLocal) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: reason,
                    isExpanded: true,
                    items: [
                      for (final e in CancellationReasons.defaults.entries)
                        DropdownMenuItem(value: e.key, child: Text(e.value)),
                    ],
                    onChanged: (v) {
                      if (v != null) setLocal(() => reason = v);
                    },
                  ),
                  TextField(
                    controller: extra,
                    decoration: const InputDecoration(
                      labelText: 'Note (optional)',
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(ref.read(appStringsProvider).cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(ref.read(appStringsProvider).save),
            ),
          ],
        );
      },
    );
    final note = extra.text;
    extra.dispose();
    if (confirmed != true) return;
    try {
      await ref
          .read(retentionServiceProvider)
          .recordCancellation(
            workspace: workspace,
            memberId: widget.memberId,
            reasonCode: reason,
            reasonText: note,
          );
      await _load();
    } on AppException catch (e) {
      setState(() => _error = e.message);
    }
  }

  Future<void> _contact() async {
    final member = _member;
    final workspace = _workspace;
    if (member == null || workspace == null) return;
    final templates = await ref
        .read(intelligenceServiceProvider)
        .templates(workspace.organization.id);
    final template = templates.isEmpty
        ? 'Hi {{member_name}}'
        : templates.first.body;
    final message = ref
        .read(intelligenceServiceProvider)
        .renderTemplate(
          body: template,
          member: member,
          workspace: workspace,
          daysSinceVisit: _insight?.daysSinceVisit,
          expiry: _insight?.membership?.endAt,
        );
    if (!mounted) return;
    final controller = TextEditingController(text: message);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: GpSpacing.lg,
            right: GpSpacing.lg,
            top: GpSpacing.lg,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + GpSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                ref.read(appStringsProvider).contactMember,
                style: Theme.of(ctx).textTheme.titleLarge,
              ),
              const SizedBox(height: GpSpacing.md),
              TextField(controller: controller, maxLines: 5),
              const SizedBox(height: GpSpacing.md),
              FilledButton(
                onPressed: () async {
                  try {
                    await ref
                        .read(contactServiceProvider)
                        .openWhatsApp(
                          phone: member.phone ?? '',
                          message: controller.text,
                        );
                  } on AppException catch (e) {
                    if (ctx.mounted) {
                      ScaffoldMessenger.of(
                        ctx,
                      ).showSnackBar(SnackBar(content: Text(e.message)));
                    }
                  }
                },
                child: Text(ref.read(appStringsProvider).whatsapp),
              ),
              TextButton(
                onPressed: () =>
                    ref.read(contactServiceProvider).call(member.phone ?? ''),
                child: Text(ref.read(appStringsProvider).call),
              ),
              TextButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: controller.text));
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: Text(ref.read(appStringsProvider).copyMessage),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    final member = _member;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          member == null
              ? s.navMembers
              : '${member.firstName} ${member.lastName}'.trim(),
        ),
        actions: [
          if (member != null)
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MemberEditorScreen(existing: member),
                  ),
                );
                await _load();
              },
              icon: const Icon(Icons.edit),
            ),
        ],
      ),
      body: member == null
          ? Center(child: Text(_error ?? s.somethingWentWrong))
          : ListView(
              padding: const EdgeInsets.all(GpSpacing.lg),
              children: [
                Text('${s.status}: ${member.status}'),
                Text(
                  '${s.externalMemberId}: ${member.externalMemberId ?? '—'}',
                ),
                Text('${s.phoneOptional}: ${member.phone ?? '—'}'),
                if (_insight?.membership != null)
                  Text(
                    '${s.membership}: ${_insight!.membership!.status} · ${s.expiresInDays(_insight!.daysUntilExpiry ?? 0)}',
                  )
                else
                  Text(s.noMembership),
                if (_insight?.daysSinceVisit != null)
                  Text(s.inactiveForDays(_insight!.daysSinceVisit!)),
                if (_trial != null) Text('${s.trials}: ${_trial!.status}'),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: GpColors.danger)),
                const SizedBox(height: GpSpacing.md),
                if (_risk != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(GpSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${s.riskScore}: ${_risk!.enoughData ? _risk!.score : '—'} (${_risk!.level})',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            _risk!.enoughData
                                ? s.notAnAiScore
                                : s.lowConfidence,
                            style: const TextStyle(
                              color: GpColors.textSecondary,
                            ),
                          ),
                          if (_risk!.decline != null) ...[
                            const SizedBox(height: GpSpacing.sm),
                            Text(
                              '${s.attendanceDecline}: ${_risk!.decline!.explanation}',
                            ),
                          ],
                          const SizedBox(height: GpSpacing.sm),
                          Text(s.riskFactors),
                          for (final f in _risk!.factors)
                            Text(
                              '${f.used ? f.points : '—'} · ${f.label}',
                              style: const TextStyle(
                                color: GpColors.textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: GpSpacing.md),
                FilledButton(onPressed: _contact, child: Text(s.contactMember)),
                TextButton(
                  onPressed: _insight?.membership == null
                      ? _addMembership
                      : _renew,
                  child: Text(
                    _insight?.membership == null
                        ? s.addMembership
                        : s.renewMembership,
                  ),
                ),
                if (_trial == null)
                  TextButton(onPressed: _startTrial, child: Text(s.startTrial))
                else
                  TextButton(
                    onPressed: _convertTrial,
                    child: Text(s.convertTrial),
                  ),
                TextButton(
                  onPressed: _cancelMembership,
                  child: Text(s.recordCancellation),
                ),
                const SizedBox(height: GpSpacing.lg),
                Text(
                  s.memberTimeline,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (_timeline.isEmpty)
                  Text(
                    s.noTimeline,
                    style: const TextStyle(color: GpColors.textSecondary),
                  )
                else
                  for (final item in _timeline.take(30))
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.title),
                      subtitle: Text(
                        [
                          item.at.toLocal().toIso8601String().split('T').first,
                          if (item.detail != null) item.detail!,
                        ].join(' · '),
                      ),
                    ),
              ],
            ),
    );
  }
}
