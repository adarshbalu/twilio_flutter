import 'package:flutter/material.dart';

class TwilioCreds {
  String accountSid, authToken, twilioNumber, url, cred;

  TwilioCreds(
      {@required this.accountSid,
      @required this.authToken,
      @required this.twilioNumber,
      @required this.url,
      @required this.cred});
}
