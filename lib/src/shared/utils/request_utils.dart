import 'dart:convert';

class RequestUtils {
  static const String _messagesBaseUri = "https://api.twilio.com";
  static const String _messagesVersion = '2010-04-01';
  static const String _verifyVersion = 'v2';
  static const String _verifyBaseUri = "https://verify.twilio.com";

  static String get messagesBaseUri => _messagesBaseUri;

  static String get messagesVersion => _messagesVersion;

  static String generateMessagesUrl(String accountSid) {
    return '${_messagesBaseUri}/${_messagesVersion}/Accounts/$accountSid/Messages.json';
  }

  static String generateCreateVerifyServiceUrl() {
    return '${_verifyBaseUri}/${_verifyVersion}/Services';
  }

  static String generateSendVerifyCodeUrl(String verificationServiceId) {
    return '${_verifyBaseUri}/${_verifyVersion}/Services/$verificationServiceId/Verifications';
  }

  static String generateVerifyCodeUrl(String verificationServiceId) {
    return '${_verifyBaseUri}/${_verifyVersion}/Services/$verificationServiceId/VerificationCheck';
  }

  static String generateSmsListUrl(String accountSid, String pageSize) {
    return generateMessagesUrl(accountSid) + '?PageSize=$pageSize';
  }

  static String generateSpecificSmsUrl(String accountSid, String messageSid) {
    return '${_messagesBaseUri}/${_messagesVersion}/Accounts/${accountSid}/Messages/${messageSid}' +
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
