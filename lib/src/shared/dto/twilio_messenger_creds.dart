import 'package:twilio_flutter/src/shared/utils/request_utils.dart';

class TwilioMessengerCreds {
  /// [accountSid] : The SID of the Account that will create the resource.
  /// [authToken]: AuthToken associated with the Twilio account
  /// [messengerId]: Facebook page ID from which the message needs to be sent
  /// [url] : Generated URL
  /// [cred]: Generated Auth String
  final String accountSid, authToken;
  late String url, cred;
  String messengerId;

  TwilioMessengerCreds(
      {required this.accountSid,
      required this.authToken,
      required this.messengerId}) {
    this.url = RequestUtils.generateMessagesUrl(accountSid);
    this.cred = RequestUtils.generateAuthString(accountSid, authToken);
  }
}
