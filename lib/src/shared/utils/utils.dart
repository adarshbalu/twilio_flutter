class Utils {
  static const String _baseUri = "https://api.twilio.com";
  static const String _version = '2010-04-01';

  static String get baseUri => _baseUri;

  static String get version => _version;

  static String generateMessagesUrl(String accountSid) {
    return '${baseUri}/${version}/Accounts/$accountSid/Messages.json';
  }

  static String generateAuthString(String accountSid, String authToken) {
    return '$accountSid:$authToken';
  }
}
