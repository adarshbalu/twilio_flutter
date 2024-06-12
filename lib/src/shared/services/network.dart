import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/exceptions/http_exception.dart';

import '../dto/error_data.dart';
import '../utils/log_helper.dart';

class NetworkHelper {
  static final logger = LogHelper(className: 'NetworkHelper');

  static Future<dynamic> getRequest(
      String url, Map<String, String> headers) async {
    try {
      final http.Response response =
          await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        final errorData = ErrorData.fromJson(jsonDecode(response.body));
        throw HttpCallException(
            message: '(Twilio API) Error in GET request', errorData: errorData);
      }
      logger.info('(Twilio API) GET Request Success');
      return jsonDecode(response.body);
    } on HttpCallException catch (e) {
      throw e;
    } on Exception catch (e) {
      throw HttpCallException(
          message: '(Twilio API) Error in GET request',
          errorData: ErrorData.generateFromException(e));
    }
  }

  static Future<http.Response> createRequest(String url,
      Map<String, String> headers, Map<String, dynamic> body) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        logger.info('(Twilio API) POST Request Success');
      } else {
        final errorData = ErrorData.fromJson(jsonDecode(response.body));
        throw HttpCallException(
            message: '(Twilio API) Error in POST request',
            errorData: errorData);
      }
      return response;
    } on HttpCallException catch (e) {
      throw e;
    } on Exception catch (e) {
      throw HttpCallException(
          message: e.toString(), errorData: ErrorData.generateFromException(e));
    }
  }
}
