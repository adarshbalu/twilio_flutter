import 'dart:convert';

class RequestUtils {
  static const String _baseUri = "https://api.twilio.com";
  static const String _version = '2010-04-01';

  static String get baseUri => _baseUri;

  static String get version => _version;

  static String generateMessagesUrl(String accountSid) {
    return '${_baseUri}/${_version}/Accounts/$accountSid/Messages.json';
  }

  static String generateSmsListUrl(String accountSid, String pageSize) {
    return generateMessagesUrl(accountSid) + '?PageSize=$pageSize';
  }

  static String generateSmsDataUrl(String accountSid, String messageSid) {
    return '${_baseUri}/${_version}/Accounts/${accountSid}/Messages/${messageSid}' +
        '.json';
  }

  static String generateAuthString(String accountSid, String authToken) {
    return '$accountSid:$authToken';
  }

  static Map<String, String> generateHeaderWithBase64(String cred) {
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);
    return {'Authorization': 'Basic $base64Str', 'Accept': 'application/json'};
  }
}
