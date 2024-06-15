import 'package:twilio_flutter/src/shared/utils/request_utils.dart';

class TwilioMessagingServiceCreds {
  /// [accountSid] : The SID of the Account that will create the resource.
  /// [authToken]: AuthToken associated with the Twilio account
  /// [messagingServiceSid]: Twilio messaging service sid
  /// [url] : Generated URL
  /// [cred]: Generated Auth String
  final String accountSid, authToken, messagingServiceSid;
  late String url, cred;

  TwilioMessagingServiceCreds(
      {required this.accountSid,
      required this.authToken,
      required this.messagingServiceSid}) {
    this.url = RequestUtils.generateMessagesUrl(accountSid);
    this.cred = RequestUtils.generateAuthString(accountSid, authToken);
  }
}
