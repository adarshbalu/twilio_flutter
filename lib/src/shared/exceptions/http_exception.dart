class HttpCallException implements Exception {
  final String message;
  final Exception? thrownException;

  HttpCallException({required this.message, this.thrownException});

  @override
  String toString() {
    return '$message : ${thrownException.toString()}';
  }
}
