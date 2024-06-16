import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/enums/request_type.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

abstract class NetworkRepository {
  TwilioResponse handleRequest(
      {required http.Response response, required RequestType requestType}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TwilioResponse.fromJson(
          metadata: jsonDecode(response.body),
          responseCode: response.statusCode);
    } else {
      final jsonData = jsonDecode(response.body);
      return TwilioResponse.fromJson(
          metadata: jsonData,
          responseCode: response.statusCode,
          errorData: ErrorData.fromJson(jsonData));
    }
  }
}
