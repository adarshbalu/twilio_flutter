import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/models/error.dart';
import 'package:twilio_flutter/src/models/twilio_creds.dart';
import 'package:twilio_flutter/src/utils/utils.dart';

abstract class TwilioWhatsAppRepository {
  Future<int> sendWhatsAppMessage({
    required String from,
    required String to,
    required String body,
    required TwilioCreds twilioCreds,
    String? mediaUrl,
  });
}

class TwilioWhatsAppRepositoryImpl extends TwilioWhatsAppRepository {
  @override
  Future<int> sendWhatsAppMessage({
    required String from,
    required String to,
    required String body,
    required TwilioCreds twilioCreds,
    String? mediaUrl,
  }) async {
    var bytes = utf8.encode('${twilioCreds.accountSid}:${twilioCreds.authToken}');
    var base64Str = base64.encode(bytes);

    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json',
    };
    var messageBody = {
      'From': 'whatsapp:$from',
      'To': 'whatsapp:$to',
      'Body': '$body',
    };

    if (mediaUrl != null) {
      messageBody['MediaUrl'] = mediaUrl;
    }

    http.Response response = await http.post(
      Uri.parse(
          '${Utils.baseUri}/${Utils.version}/Accounts/${twilioCreds.accountSid}/Messages.json'),
      headers: headers,
      body: messageBody,
    );

    if (response.statusCode == 201) {
      //print(response.body);
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
