import 'package:url_launcher/url_launcher.dart';

import '../../core/errors/app_exception.dart';

class ContactService {
  Future<void> openWhatsApp({
    required String phone,
    required String message,
  }) async {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'This member does not have a phone number.',
      );
    }
    final uri = Uri.parse(
      'https://wa.me/$digits?text=${Uri.encodeComponent(message)}',
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw AppException(
        code: AppErrorCodes.internalUnexpected,
        message:
            'WhatsApp could not be opened. You can still copy the message.',
        retryable: true,
      );
    }
  }

  Future<void> call(String phone) async {
    final digits = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (digits.isEmpty) {
      throw AppException(
        code: AppErrorCodes.validationInvalidField,
        message: 'This member does not have a phone number.',
      );
    }
    final uri = Uri.parse('tel:$digits');
    if (!await launchUrl(uri)) {
      throw AppException(
        code: AppErrorCodes.internalUnexpected,
        message: 'The phone dialer could not be opened.',
        retryable: true,
      );
    }
  }
}
