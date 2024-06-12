import '../dto/error_data.dart';

class HttpCallException implements Exception {
  final String message;
  final ErrorData errorData;

  HttpCallException({required this.message, required this.errorData});

  @override
  String toString() {
    return '$message: ${errorData.toString()}';
  }
}
