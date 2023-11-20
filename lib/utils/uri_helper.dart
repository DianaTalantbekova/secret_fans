import 'package:url_launcher/url_launcher.dart';

class UriHelper {
  static void tel(String phone) {
    final Uri telLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );

    launchUrl(telLaunchUri);
  }

  static void sms(String phone) {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phone,
    );

    launchUrl(smsLaunchUri);
  }
}
