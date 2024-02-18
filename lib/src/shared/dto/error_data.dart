class ErrorData {
  final String? message, moreInfo;
  final int? code;

  ErrorData(this.code, this.message, this.moreInfo);

  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return ErrorData(json['code'], json['message'], json['more_info']);
  }
}
