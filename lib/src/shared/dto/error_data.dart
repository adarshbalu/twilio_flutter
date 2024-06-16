/// [ErrorData] can be used to get the details of the exception caused
/// [message] [moreInfo] [code] [status] are used to know more details
class ErrorData {
  final String? message, moreInfo;
  final int? code, status;

  ErrorData(this.code, this.message, this.moreInfo, this.status);

  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return ErrorData(
        json['code'], json['message'], json['more_info'], json['status']);
  }

  factory ErrorData.getGenericErrorData() {
    return ErrorData(00, 'Unknown Error Occurred', 'Unknown Error', 500);
  }

  factory ErrorData.generateFromException(Exception e) {
    return ErrorData(00, e.toString(), e.runtimeType.toString(), 500);
  }

  @override
  String toString() {
    return '{message: $message, moreInfo: $moreInfo, code: $code, status: $status}';
  }
}
