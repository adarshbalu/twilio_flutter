class SendSmsError implements Exception {
  late int _errorCode;
  late String _errorMessage;

  SendSmsError(
    Map<String, dynamic> responseBodyAsMap,
  ) {
    _errorCode = responseBodyAsMap['code'];
    _errorMessage = responseBodyAsMap['message'];
  }

  int get errorCode => _errorCode;
  String get errorMessage => _errorMessage;

  @override
  String toString() {
    return '$_errorCode: $_errorMessage';
  }
}

class SendMmsError implements Exception {
  late int _errorCode;
  late String _errorMessage;

  SendMmsError(
    Map<String, dynamic> responseBodyAsMap,
  ) {
    _errorCode = responseBodyAsMap['code'];
    _errorMessage = responseBodyAsMap['message'];
  }

  int get errorCode => _errorCode;
  String get errorMessage => _errorMessage;

  @override
  String toString() {
    return '$_errorCode: $_errorMessage';
  }
}

class SendWhatsAppError implements Exception {
  late int _errorCode;
  late String _errorMessage;

  SendWhatsAppError(
    Map<String, dynamic> responseBodyAsMap,
  ) {
    _errorCode = responseBodyAsMap['code'];
    _errorMessage = responseBodyAsMap['message'];
  }

  int get errorCode => _errorCode;
  String get errorMessage => _errorMessage;

  @override
  String toString() {
    return '$_errorCode: $_errorMessage';
  }
}
