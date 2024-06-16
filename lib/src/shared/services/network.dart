import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/enums/request_type.dart';
import 'package:twilio_flutter/src/shared/exceptions/http_exception.dart';

import '../dto/error_data.dart';
import '../utils/log_helper.dart';

class NetworkHelper {
  static final logger = LogHelper(className: 'NetworkHelper');

  static Future<http.Response> handleNetworkRequest(
      {required String url,
      required Map<String, String> headers,
      Map<String, dynamic>? body,
      required RequestType requestType}) {
    if (requestType == RequestType.GET) {
      return getRequest(url, headers);
    } else if (requestType == RequestType.POST) {
      if (body != null) {
        return createRequest(url, headers, body);
      }
    }
    throw HttpCallException(
        message: 'Invalid request', errorData: ErrorData.getGenericErrorData());
  }

  static Future<http.Response> getRequest(
      String url, Map<String, String> headers) async {
    try {
      final http.Response response =
          await http.get(Uri.parse(url), headers: headers);
      return jsonDecode(response.body);
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
      return response;
    } on Exception catch (e) {
      throw HttpCallException(
          message: e.toString(), errorData: ErrorData.generateFromException(e));
    }
  }
}
