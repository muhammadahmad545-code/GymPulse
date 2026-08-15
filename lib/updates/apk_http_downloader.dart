import 'dart:io';

import '../core/errors/app_exception.dart';
import 'update_contracts.dart';

class HttpApkDownloader implements ApkDownloader {
  HttpApkDownloader({
    HttpClient? client,
    this.connectTimeout = const Duration(seconds: 20),
    this.idleTimeout = const Duration(minutes: 10),
  }) : _client = client;

  final HttpClient? _client;
  final Duration connectTimeout;
  final Duration idleTimeout;

  @override
  Future<File> download({
    required Uri uri,
    required File destination,
    required UpdateCancelToken cancelToken,
    void Function(DownloadProgress progress)? onProgress,
  }) async {
    if (uri.scheme.toLowerCase() != 'https') {
      throw AppException(
        code: AppErrorCodes.updateDownloadFailed,
        message: 'Updates can only be downloaded over HTTPS.',
      );
    }

    destination.parent.createSync(recursive: true);
    final part = File('${destination.path}.part');
    await _deleteIfExists(destination);
    await _deleteIfExists(part);

    final client = _client ?? HttpClient();
    client.connectionTimeout = connectTimeout;
    client.idleTimeout = idleTimeout;
    HttpClientRequest? request;
    IOSink? sink;

    try {
      if (cancelToken.isCancelled) {
        throw _cancelled();
      }
      request = await client.getUrl(uri);
      request.followRedirects = true;
      request.maxRedirects = 8;
      final response = await request.close();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw AppException(
          code: AppErrorCodes.updateDownloadFailed,
          message: 'Could not download the update. Try again.',
          retryable: true,
        );
      }

      final total = response.contentLength >= 0 ? response.contentLength : null;
      sink = part.openWrite();
      var received = 0;

      await for (final chunk in response) {
        if (cancelToken.isCancelled) {
          throw _cancelled();
        }
        received += chunk.length;
        sink.add(chunk);
        onProgress?.call(
          DownloadProgress(receivedBytes: received, totalBytes: total),
        );
      }
      await sink.flush();
      await sink.close();
      sink = null;

      if (received == 0) {
        throw AppException(
          code: AppErrorCodes.updateDownloadFailed,
          message: 'The update download was empty and was discarded.',
        );
      }
      if (total != null && received != total) {
        throw AppException(
          code: AppErrorCodes.updateIntegrityFailed,
          message:
              'The downloaded update was incomplete and was discarded. Try again.',
          retryable: true,
        );
      }

      await part.rename(destination.path);
      return destination;
    } on AppException {
      await _safeClose(sink);
      await _deleteIfExists(part);
      await _deleteIfExists(destination);
      rethrow;
    } on SocketException catch (error) {
      await _safeClose(sink);
      await _deleteIfExists(part);
      await _deleteIfExists(destination);
      if (_isNoSpace(error)) {
        throw AppException(
          code: AppErrorCodes.updateInsufficientStorage,
          message: 'Not enough storage to download this update.',
          cause: error,
        );
      }
      throw AppException(
        code: AppErrorCodes.updateDownloadFailed,
        message:
            'Could not download the update. Check your connection and try again.',
        retryable: true,
        cause: error,
      );
    } on IOException catch (error) {
      await _safeClose(sink);
      await _deleteIfExists(part);
      await _deleteIfExists(destination);
      if (_isNoSpace(error)) {
        throw AppException(
          code: AppErrorCodes.updateInsufficientStorage,
          message: 'Not enough storage to download this update.',
          cause: error,
        );
      }
      throw AppException(
        code: AppErrorCodes.updateDownloadFailed,
        message: 'Could not download the update. Try again.',
        retryable: true,
        cause: error,
      );
    } catch (error) {
      await _safeClose(sink);
      await _deleteIfExists(part);
      await _deleteIfExists(destination);
      if (error is AppException) rethrow;
      throw AppException(
        code: AppErrorCodes.updateDownloadFailed,
        message: 'Could not download the update. Try again.',
        retryable: true,
        cause: error,
      );
    } finally {
      if (_client == null) {
        client.close(force: true);
      }
    }
  }

  AppException _cancelled() => AppException(
    code: AppErrorCodes.updateCancelled,
    message: 'Update download cancelled.',
  );

  bool _isNoSpace(Object error) {
    final text = error.toString().toLowerCase();
    return text.contains('no space') ||
        text.contains('enospc') ||
        text.contains('not enough space');
  }

  Future<void> _deleteIfExists(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }

  Future<void> _safeClose(IOSink? sink) async {
    if (sink == null) return;
    try {
      await sink.close();
    } catch (_) {}
  }
}
