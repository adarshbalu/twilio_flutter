import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/dto/error_data.dart';
import 'package:twilio_flutter/src/shared/http_exception.dart';

import '../utils/log_helper.dart';

class NetworkHelper {
  static final logger = LogHelper(className: 'NetworkHelper');

  static Future<int> postMessageRequest(String url, Map<String, String> headers,
      Map<String, dynamic> body) async {
    http.Response response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 201) {
      print('Sms sent');
    } else {
      print('Sending Failed');
      var data = jsonDecode(response.body);
      print('Error Code : ' + data['code'].toString());
      print('Error Message : ' + data['message']);
      print("More info : " + data['more_info']);
    }
    return response.statusCode;
  }

  static Future getRequest(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  static Future<http.Response> createRequest(String url,
      Map<String, String> headers, Map<String, dynamic> body) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 201) {
        logger.info('(Twilio API) Request Success');
      } else {
        final errorData = ErrorData.fromJson(jsonDecode(response.body));
        throw HttpCallException(
          message: '(Twilio API) Error in POST request',
        );
      }
      return response;
    } catch (e) {
      final exception = e as Exception;
      throw HttpCallException(
          message: e.toString(), thrownException: exception);
    }
  }
}
