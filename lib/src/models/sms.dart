class SMS {
  String? messageSid;
  String? dateCreated;
  String? dateUpdated;
  String? dateSent;
  String? accountSid;
  String? to;
  String? from;
  String? body;
  String? status;
  String? direction;
  String? errorMessage;
  String? messageURL;
  int? segments;

  SMS({
    this.messageSid,
    this.dateCreated,
    this.dateUpdated,
    this.dateSent,
    this.accountSid,
    this.to,
    this.from,
    this.body,
    this.status,
    this.direction,
    this.errorMessage,
    this.messageURL,
    this.segments,
  });

  static SMS fromJson() {
    return SMS();
  }
}
