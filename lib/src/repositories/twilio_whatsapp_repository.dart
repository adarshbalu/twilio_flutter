import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/models/twilio_creds.dart';
import 'package:twilio_flutter/src/utils/utils.dart';
import 'package:twilio_flutter/src/models/exceptions.dart';
import 'package:twilio_flutter/src/models/responses.dart';

abstract class TwilioWhatsAppRepository {
  Future<SendWhatsAppResponse> sendWhatsApp({
    required String from,
    required String to,
    required String body,
    required TwilioCreds twilioCreds,
    String? mediaUrl,
  });
}

class TwilioWhatsAppRepositoryImpl extends TwilioWhatsAppRepository {
  @override
  Future<SendWhatsAppResponse> sendWhatsApp({
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
      return SendWhatsAppResponse(jsonDecode(response.body));
    } else {
      throw SendWhatsAppError(jsonDecode(response.body));
    }
  }
}
