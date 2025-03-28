import 'package:url_launcher/url_launcher.dart';

class ContactUtilities {
  // Helper function to encode query parameters for URLs
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Function to make a phone call
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch phone call to $phoneNumber');
    }
  }

  // Function to send an email
  Future<void> sendEmail({required String path,}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: path,
      query: encodeQueryParameters(<String, String>{
        'subject': 'subject',
      }),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw Exception('Could not launch email to $emailUri');
    }
  }
}
