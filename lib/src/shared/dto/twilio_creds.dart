class TwilioCreds {
  /// [accountSid] : The SID of the Account that will create the resource.
  /// [authToken]: AuthToken associated with the Twilio account
  /// [twilioNumber]: Twilio number from which the sms needs to be sent
  /// [url] : Generated URL
  /// [cred]: Generated Auth String
  final String accountSid, authToken, url, cred;
  String twilioNumber;

  TwilioCreds(
      {required this.accountSid,
      required this.authToken,
      required this.twilioNumber,
      required this.url,
      required this.cred}) {}
}
