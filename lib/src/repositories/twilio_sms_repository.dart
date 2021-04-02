import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:twilio_flutter/src/models/twilio_creds.dart';
import 'package:twilio_flutter/src/services/network.dart';

abstract class TwilioSmsRepository {
  Future getSmsList();
  Future<int> sendSMS(
      {@required String toNumber,
      @required String messageBody,
      @required TwilioCreds twilioCreds});
}

class TwilioSMSRepositoryImpl extends TwilioSmsRepository {
  @override
  Future getSmsList() {
    // TODO: implement getSmsList
    throw UnimplementedError();
  }

  @override
  Future<int> sendSMS(
      {@required String toNumber,
      @required String messageBody,
      @required TwilioCreds twilioCreds}) async {
    String cred = twilioCreds.cred;
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);

    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    var body = {
      'From': twilioCreds.twilioNumber,
      'To': toNumber,
      'Body': messageBody
    };

    int status =
        await NetworkHelper.postMessageRequest(twilioCreds.url, headers, body);
    return status;
  }
}
