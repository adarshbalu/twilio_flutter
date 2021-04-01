library twilio_flutter;

import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:twilio_flutter/src/models/sms.dart';
import 'package:twilio_flutter/src/services/network.dart';

class TwilioFlutter {
  String _twilioNumber;
  String _toNumber, _messageBody;
  Map<String, String> _auth = Map<String, String>();
  String _url;
  final _baseUri = "https://api.twilio.com";
  String _version = '2010-04-01';
  List<SMS> _smsList = [];
  SMS _sms = SMS();

  SMS get sms => _sms;

  TwilioFlutter(
      {@required String accountSid,
      @required String authToken,
      @required String twilioNumber}) {
    this._auth['accountSid'] = accountSid;
    this._auth['authToken'] = authToken;
    this._auth['twilioNumber'] = this._twilioNumber = twilioNumber;
    this._auth['baseUri'] = _baseUri;
    this._auth['cred'] = '$accountSid:$authToken';
    this._url = '$_baseUri/$_version/Accounts/$accountSid/Messages.json';
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
    String cred = this._auth['cred'];
    this._toNumber = toNumber;
    this._messageBody = messageBody;
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);

    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    var body = {
      'From': this._twilioNumber,
      'To': this._toNumber,
      'Body': this._messageBody
    };

    int status = await NetworkHelper.postMessageRequest(_url, headers, body);
    return status;
  }

  changeTwilioNumber(String twilioNumber) {
    this._twilioNumber = twilioNumber;
  }

  sendWhatsApp(
      {@required String toNumber, @required String messageBody}) async {
    String cred = this._auth['cred'];
    this._toNumber = toNumber;
    this._messageBody = messageBody;
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);
    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    var body = {
      'From': 'whatsapp:' + this._twilioNumber,
      'To': 'whatsapp:' + this._toNumber,
      'Body': this._messageBody
    };

    NetworkHelper.postMessageRequest(_url, headers, body);
  }

  getSmsList() async {
    var getUri = 'https://' +
        this._auth['accountSid'] +
        ':' +
        this._auth['authToken'] +
        '@api.twilio.com/' +
        _version +
        '/Accounts/' +
        this._auth['accountSid'] +
        '/Messages.json';
    print(getUri);
    this._smsList = await getSMSList(getUri);
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
