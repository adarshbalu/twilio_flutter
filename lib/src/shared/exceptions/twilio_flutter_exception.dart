/// [TwilioFlutterException] is exposed to know about any exceptions that may have occurred
/// [message] and [thrownException] can be used to find details
class TwilioFlutterException implements Exception {
  final String message;
  final Exception? thrownException;

  TwilioFlutterException({required this.message, this.thrownException});

  @override
  String toString() {
    return '$message';
  }
}
