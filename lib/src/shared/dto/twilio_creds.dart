class TwilioCreds {
  ///[accountSid] : The SID of the Account that will create the resource.
  String accountSid, authToken, twilioNumber, url, cred;

  TwilioCreds(
      {required this.accountSid,
      required this.authToken,
      required this.twilioNumber,
      required this.url,
      required this.cred});
}
