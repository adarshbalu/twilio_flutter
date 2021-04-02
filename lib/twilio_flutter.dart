library twilio_flutter;

import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:twilio_flutter/src/models/sms.dart';
import 'package:twilio_flutter/src/models/twilio_creds.dart';
import 'package:twilio_flutter/src/repositories/twilio_sms_repository.dart';
import 'package:twilio_flutter/src/services/network.dart';
import 'package:twilio_flutter/src/utils/utils.dart';

class TwilioFlutter {
  TwilioSmsRepository _smsRepository;
  TwilioCreds _twilioCreds;

  List<SMS> _smsList = [];
  SMS _sms = SMS();
  SMS get sms => _sms;

  TwilioFlutter(
      {@required String accountSid,
      @required String authToken,
      @required String twilioNumber})
      : assert(
            accountSid != null && authToken != null && twilioNumber != null) {
    _smsRepository = TwilioSMSRepositoryImpl();

    String uri =
        '${Utils.baseUri}/${Utils.version}/Accounts/$accountSid/Messages.json';
    String creds = '$accountSid:$authToken';
    _twilioCreds = TwilioCreds(
        accountSid: accountSid,
        authToken: authToken,
        twilioNumber: twilioNumber,
        url: uri,
        cred: creds);
  }

//
//	sendSMS
//	@param toNumber : The number to which text message has to be sent.
//	@param messageBody : The content of the message to be sent.
//	@return status : Status of response from the server.
//
//	Method called to send text messages to the specified phone number with given content.
//
//	returns status code from the server response.
//	201 -> message sent successfully.
//
//	For more status codes refer https://www.twilio.com/docs/api/errors
//
  Future<int> sendSMS(
      {@required String toNumber, @required String messageBody}) async {
    String cred = _twilioCreds.cred;
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);

    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    var body = {
      'From': _twilioCreds.twilioNumber,
      'To': toNumber,
      'Body': messageBody
    };

    int status =
        await NetworkHelper.postMessageRequest(_twilioCreds.url, headers, body);
    return status;
  }

  changeTwilioNumber(String twilioNumber) {
    this._twilioCreds.twilioNumber = twilioNumber;
  }

  sendWhatsApp(
      {@required String toNumber, @required String messageBody}) async {
    String cred = _twilioCreds.cred;

    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);
    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    var body = {
      'From': 'whatsapp:' + _twilioCreds.twilioNumber,
      'To': 'whatsapp:' + toNumber,
      'Body': messageBody
    };

    NetworkHelper.postMessageRequest(_twilioCreds.url, headers, body);
  }

  getSmsList() async {
    // var getUri = 'https://' +
    //     this._auth['accountSid'] +
    //     ':' +
    //     this._auth['authToken'] +
    //     '@api.twilio.com/' +
    //     _version +
    //     '/Accounts/' +
    //     this._auth['accountSid'] +
    //     '/Messages.json';
    // print(getUri);
    //this._smsList = await getSMSList(getUri);
  }

  getSMS(var messageSid) {
    bool found = false;
    for (var sms in this._smsList) {
      if (sms.messageSid == messageSid) {
        print('Message body : ' + sms.body);
        print('To : ' + sms.to);
        print('Sms status : ' + sms.status);
        print('Message URL :' + 'https://api.twilio.com' + sms.messageURL);
        found = true;
      }
    }
    if (!found) print('Not Found');
  }

  Future getSMSList(String url) async {
    var data = await NetworkHelper.getRequest(url);
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
