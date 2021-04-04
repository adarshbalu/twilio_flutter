import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/models/error.dart';
import 'package:twilio_flutter/src/models/twilio_creds.dart';

abstract class TwilioWhatsAppRepository {
  Future<int> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds? twilioCreds});
}

class TwilioWhatsAppRepositoryImpl extends TwilioWhatsAppRepository {
  @override
  Future<int> sendWhatsAppMessage(
      {required String toNumber,
      required String? messageBody,
      required TwilioCreds? twilioCreds}) async {
    String cred = twilioCreds!.cred;

    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);
    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    var body = {
      'From': 'whatsapp:' + twilioCreds.twilioNumber,
      'To': 'whatsapp:' + toNumber,
      'Body': messageBody
    };
    http.Response response = await http.post(Uri.parse(twilioCreds.url),
        headers: headers, body: body);
    if (response.statusCode == 201) {
      print('Sms sent Success');
      return response.statusCode;
    } else {
      print('Sending Failed');
      ErrorData errorData = ErrorData.fromJson(jsonDecode(response.body));
      print('Error Code : ' + errorData.code.toString());
      print('Error Message : ' + errorData.message!);
      print("More info : " + errorData.moreInfo!);
      throw Exception();
    }
  }
}
