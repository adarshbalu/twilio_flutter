import 'dart:convert';

class RequestUtil {
  static Map<String, String> generateHeaderWithBase64(String cred) {
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);
    return {'Authorization': 'Basic $base64Str', 'Accept': 'application/json'};
  }
}
