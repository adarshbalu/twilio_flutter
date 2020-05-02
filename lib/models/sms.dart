import 'package:twilio_flutter/services/network.dart';

class SMS {
  String body,
      from,
      to,
      status,
      messageSid,
      direction,
      dateSent,
      dateCreated,
      errorMessage,
      messageURL;

  SMS();

  Future getSMSList(String url) async {
    NetworkHelper networkHelper = NetworkHelper();
    var data = await networkHelper.getRequest(url);
    List<SMS> smsList = [];
    var messages = data['messages'];
    for (var message in messages) {
      SMS sms = SMS();
      sms.body = message['body'];
      sms.dateCreated = message['date_created'];
      sms.dateSent = message['date_sent'];
      sms.direction = message['direction'];
      sms.errorMessage = message['error_message'];
      sms.from = message['from'];
      sms.to = message['to'];
      sms.messageSid = message['sid'];
      sms.messageURL = message['uri'];
      sms.status = message['status'];
      smsList.add(sms);
    }
    if (smsList.isEmpty) print('Failed');
    return smsList;
  }
}
