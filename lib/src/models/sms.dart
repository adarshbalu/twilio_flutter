class SMS {
  String? body,
      from,
      to,
      status,
      messageSid,
      direction,
      dateSent,
      dateCreated,
      errorMessage,
      messageURL;

  SMS(
      {this.body,
      this.from,
      this.to,
      this.status,
      this.messageSid,
      this.direction,
      this.dateSent,
      this.dateCreated,
      this.errorMessage,
      this.messageURL});
}
