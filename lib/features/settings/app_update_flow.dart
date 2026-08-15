import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/errors/app_exception.dart';
import '../../core/theme/gp_theme.dart';
import '../../updates/app_release_info.dart';
import '../../updates/update_contracts.dart';

Future<void> showAppUpdateSheet({
  required BuildContext context,
  required WidgetRef ref,
  required AppReleaseInfo info,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: GpColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(GpRadii.lg)),
    ),
    builder: (_) => AppUpdateSheet(info: info),
  );
}

class AppUpdateSheet extends ConsumerStatefulWidget {
  const AppUpdateSheet({super.key, required this.info});

  final AppReleaseInfo info;

  @override
  ConsumerState<AppUpdateSheet> createState() => _AppUpdateSheetState();
}

class _AppUpdateSheetState extends ConsumerState<AppUpdateSheet> {
  UpdateCancelToken? _token;
  bool _busy = false;
  String? _status;
  double? _progress;
  String? _error;

  @override
  void dispose() {
    _token?.cancel();
    super.dispose();
  }

  Future<void> _startUpdate() async {
    final s = ref.read(appStringsProvider);
    setState(() {
      _busy = true;
      _error = null;
      _status = s.downloadingUpdate;
      _progress = null;
    });
    final token = UpdateCancelToken();
    _token = token;
    try {
      await ref
          .read(appUpdateServiceProvider)
          .downloadAndInstall(
            widget.info,
            cancelToken: token,
            onProgress: (progress) {
              if (!mounted) return;
              setState(() {
                _progress = progress.fraction;
                _status = s.downloadingUpdate;
              });
            },
          );
      if (!mounted) return;
      ref.read(pendingInstallProvider.notifier).state = widget.info;
      setState(() {
        _busy = false;
        _status = s.installerLaunched;
        _progress = 1;
      });
    } on AppException catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _progress = null;
        _status = null;
        _error = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _progress = null;
        _status = null;
        _error = s.somethingWentWrong;
      });
    }
  }

  void _cancel() {
    _token?.cancel();
    if (mounted) {
      setState(() {
        _busy = false;
        _status = null;
        _progress = null;
        _error = ref.read(appStringsProvider).updateCancelled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStringsProvider);
    final info = widget.info;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        GpSpacing.lg,
        GpSpacing.md,
        GpSpacing.lg,
        GpSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.updateAvailable,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: GpSpacing.sm),
          Text(
            'v${info.versionName} (${info.versionCode})',
            style: const TextStyle(color: GpColors.primary),
          ),
          if (info.releaseNotes.isNotEmpty) ...[
            const SizedBox(height: GpSpacing.md),
            Text(info.releaseNotes),
          ],
          if (_status != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_status!),
            const SizedBox(height: GpSpacing.sm),
            LinearProgressIndicator(value: _progress),
          ],
          if (_error != null) ...[
            const SizedBox(height: GpSpacing.md),
            Text(_error!, style: const TextStyle(color: GpColors.danger)),
          ],
          const SizedBox(height: GpSpacing.lg),
          Row(
            children: [
              if (_busy)
                TextButton(onPressed: _cancel, child: Text(s.cancel))
              else
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(s.later),
                ),
              const Spacer(),
              FilledButton(
                onPressed: _busy ? null : _startUpdate,
                child: Text(_error == null ? s.updateNow : s.retry),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UpdateAvailableBanner extends ConsumerWidget {
  const UpdateAvailableBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final update = ref.watch(availableUpdateProvider);
    if (update == null) return const SizedBox.shrink();
    final s = ref.watch(appStringsProvider);
    return Card(
      color: GpColors.surfaceElevated,
      child: ListTile(
        title: Text(s.updateAvailable),
        subtitle: Text('v${update.versionName} (${update.versionCode})'),
        trailing: TextButton(
          onPressed: () =>
              showAppUpdateSheet(context: context, ref: ref, info: update),
          child: Text(s.updateNow),
        ),
      ),
    );
  }
}
