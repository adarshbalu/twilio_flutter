library twilio_flutter;

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TwilioFlutter {
  String _twilioNumber;
  String _toNumber, _messageBody;

  Map<String, String> _auth = Map<String, String>();
  String _url;
  final _baseUri = "api.twilio.com";

  TwilioFlutter(
      {@required String accountSid,
      @required String authToken,
      @required String twilioNumber}) {
    this._auth['accountSid'] = accountSid;
    this._auth['authToken'] = authToken;
    this._auth['twilioNumber'] = this._twilioNumber = twilioNumber;
    this._auth['baseUri'] = _baseUri;
    this._auth['cred'] = '$accountSid:$authToken';
    this._url =
        'https://$_baseUri/2010-04-01/Accounts/$accountSid/Messages.json';
  }

  Future sendSMS(
      {@required String toNumber, @required String messageBody}) async {
    String cred = this._auth['cred'];
    this._toNumber = toNumber;
    this._messageBody = messageBody;
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);

    var response = await http.post(
      _url,
      headers: {
        'Authorization': 'Basic $base64Str',
        'Accept': 'application/json'
      },
      body: {
        'From': this._twilioNumber,
        'To': this._toNumber,
        'Body': this._messageBody
      },
    );

    if (response.statusCode == 201) {
      print('Sms sent');
    } else {
      print('Sending Failed');
      var data = jsonDecode(response.body);
      print('Error Codde : ' + data['code']);
      print('Error Message : ' + data['message']);
      print("More info : " + data['more_info']);
    }
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

    var response = await http.post(
      _url,
      headers: {
        'Authorization': 'Basic $base64Str',
        'Accept': 'application/json'
      },
      body: {
        'From': 'whatsapp:' + this._twilioNumber,
        'To': 'whatsapp:' + this._toNumber,
        'Body': this._messageBody
      },
    );

    if (response.statusCode == 201) {
      print('WhatsApp message sent');
    } else {
      print('Sending Failed');
      var data = jsonDecode(response.body);
      print('Error Codde : ' + data['code']);
      print('Error Message : ' + data['message']);
      print("More info : " + data['more_info']);
    }
  }
}
