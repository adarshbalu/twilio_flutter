import 'package:twilio_flutter/src/shared/utils/request_utils.dart';

class TwilioCreds {
  /// [accountSid] : The SID of the Account that will create the resource.
  /// [authToken]: AuthToken associated with the Twilio account
  /// [twilioNumber]: Twilio number from which the message needs to be sent
  /// [messengerId]: Facebook page ID from which the message needs to be sent
  /// [authString]: Generated Auth String
  final String accountSid, authToken;
  late String authString;
  String twilioNumber;

  TwilioCreds(
      {required this.accountSid,
      required this.authToken,
      required this.twilioNumber}) {
    this.authString = RequestUtils.generateAuthString(accountSid, authToken);
  }
}
