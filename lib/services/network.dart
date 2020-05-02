import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper();

  Future postMessageRequest(var url, var headers, var body) async {
    http.Response response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      print('Sms sent');
    } else {
      print('Sending Failed');
      var data = jsonDecode(response.body);
      print('Error Codde : ' + data['code'].toString());
      print('Error Message : ' + data['message']);
      print("More info : " + data['more_info']);
    }
  }

  Future getRequest(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
