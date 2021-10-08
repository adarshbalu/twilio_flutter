import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/models/twilio_creds.dart';
import 'package:twilio_flutter/src/utils/utils.dart';
import 'package:twilio_flutter/src/models/exceptions.dart';
import 'package:twilio_flutter/src/models/responses.dart';

abstract class TwilioMmsRepository {
  Future<SendMmsResponse> sendMms({
    required String from,
    required String to,
    String? body,
    required String mediaUrl,
    required TwilioCreds twilioCreds,
    String? statusCallback,
  });
}

class TwilioMmsRepositoryImpl extends TwilioMmsRepository {
  @override
  Future<SendMmsResponse> sendMms({
    required String from,
    required String to,
    String? body,
    required String mediaUrl,
    required TwilioCreds twilioCreds,
    String? statusCallback,
  }) async {
    var bytes = utf8.encode('${twilioCreds.accountSid}:${twilioCreds.authToken}');
    var base64Str = base64.encode(bytes);

    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json',
    };

    var messageBody = {
      'From': from,
      'To': to,
      'MediaUrl': mediaUrl,
    };

    if (body != null) {
      messageBody['Body'] = body;
    }

    if (statusCallback != null) {
      messageBody['StatusCallback'] = statusCallback;
    }

    http.Response response = await http.post(
      Uri.parse(
          '${Utils.baseUri}/${Utils.version}/Accounts/${twilioCreds.accountSid}/Messages.json'),
      headers: headers,
      body: messageBody,
    );

    if (response.statusCode == 201) {
      return SendMmsResponse(jsonDecode(response.body));
    } else {
      throw SendMmsError(jsonDecode(response.body));
    }
  }
}
