import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
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
}
