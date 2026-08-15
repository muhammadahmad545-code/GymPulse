import 'package:flutter/foundation.dart';

import '../errors/app_exception.dart';

typedef AppLogSink =
    void Function(
      String level,
      String message, {
      Object? error,
      StackTrace? stackTrace,
    });

/// Structured logging with secret redaction. Never logs PINs, passwords, or keys.
class AppLogger {
  AppLogger({AppLogSink? sink}) : _sink = sink ?? _defaultSink;

  final AppLogSink _sink;

  static final _sensitivePair = RegExp(
    r'(pin|password|passphrase|secret|token|key|authorization)\s*[:=]\s*\S+',
    caseSensitive: false,
  );

  void info(String message) => _sink('INFO', _redact(message));

  void warn(String message, {Object? error}) =>
      _sink('WARN', _redact(message), error: _safeError(error));

  void error(String message, {Object? error, StackTrace? stackTrace}) => _sink(
    'ERROR',
    _redact(message),
    error: _safeError(error),
    stackTrace: stackTrace,
  );

  void exception(AppException exception, {StackTrace? stackTrace}) {
    _sink(
      'ERROR',
      '${exception.code}: ${_redact(exception.message)}'
          '${exception.requestId == null ? '' : ' requestId=${exception.requestId}'}',
      error: exception.cause == null ? null : _safeError(exception.cause),
      stackTrace: stackTrace,
    );
  }

  static Object? _safeError(Object? error) {
    if (error == null) return null;
    final text = error.toString();
    return _redact(text);
  }

  static String _redact(String input) {
    if (!_sensitivePair.hasMatch(input)) return input;
    return input.replaceAllMapped(_sensitivePair, (m) {
      final raw = m.group(0)!;
      final label = RegExp(
        r'^(pin|password|passphrase|secret|token|key|authorization)',
        caseSensitive: false,
      ).firstMatch(raw)?.group(1);
      return '${label ?? 'secret'}=[REDACTED]';
    });
  }

  static void _defaultSink(
    String level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    debugPrint('[$level] $message');
    if (error != null) debugPrint('  error=$error');
    // Never dump stack traces to end users; only debug console.
    if (stackTrace != null && kDebugMode) {
      debugPrint('$stackTrace');
    }
  }
}
