class TwilioFlutterException implements Exception {
  final String message;
  final Exception? thrownException;

  TwilioFlutterException({required this.message, this.thrownException});

  @override
  String toString() {
    return '$message : ${thrownException.toString()}';
  }
}
