import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper to handle external URL launching, email creation, and resume downloads.
class UrlLauncherHelper {
  UrlLauncherHelper._();

  /// Launches any web URL safely.
  static Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
      }
    } catch (e) {
      debugPrint('Error launching URL $url: $e');
    }
    return false;
  }

  /// Opens mail client with prefilled email, subject, and body.
  static Future<bool> sendEmail({
    required String recipient,
    String subject = 'Portfolio Inquiry / Collaboration',
    String body = '',
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: recipient,
      queryParameters: {
        'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );

    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Error opening email client: $e');
    }
    return false;
  }

  /// Opens telephone dialer.
  static Future<bool> callPhone(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Error launching tel: $e');
    }
    return false;
  }

  /// Initiates resume download or opens in new tab for Flutter Web.
  static Future<void> downloadResume(String assetPath) async {
    // On Flutter web, assets are served relative to root or base-href
    // In web, opening the asset URL opens/downloads the file in a browser tab.
    final webAssetUrl = assetPath;
    await openUrl(webAssetUrl);
  }
}
