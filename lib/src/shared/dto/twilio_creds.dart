import 'package:twilio_flutter/src/shared/utils/request_utils.dart';

class TwilioCreds {
  /// [accountSid] : The SID of the Account that will create the resource.
  /// [authToken]: AuthToken associated with the Twilio account
  /// [twilioNumber]: Twilio number from which the sms needs to be sent
  /// [url] : Generated URL
  /// [cred]: Generated Auth String
  final String accountSid, authToken;
  late String url, cred;
  String twilioNumber;
  String? messagingServiceSid;

  TwilioCreds(
      {required this.accountSid,
      required this.authToken,
      required this.twilioNumber,
      this.messagingServiceSid}) {
    String uri = RequestUtils.generateMessagesUrl(accountSid);
    String creds = RequestUtils.generateAuthString(accountSid, authToken);
    this.url = uri;
    this.cred = creds;
  }
}
