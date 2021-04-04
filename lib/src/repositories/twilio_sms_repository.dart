import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/models/error.dart';
import 'package:twilio_flutter/src/models/sent_sms_data.dart';
import 'package:twilio_flutter/src/models/twilio_creds.dart';
import 'package:twilio_flutter/src/utils/utils.dart';

abstract class TwilioSmsRepository {
  Future<SentSmsData> getSmsList(
      {required String pageSize, required TwilioCreds? twilioCreds});
  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds? twilioCreds});
  Future<Message> getSmsData(
      {required String messageSID, required TwilioCreds? twilioCreds});
  Future<int> deleteMessage(
      {required String messageSID, required TwilioCreds twilioCreds});
  Future<SentSmsData> smsListFilterByTimePeriod(
      {required String pageSize, required TwilioCreds twilioCreds});
  Future<SentSmsData> smsListFilterBySentBefore(
      {required String pageSize, required TwilioCreds twilioCreds});
  Future<SentSmsData> smsListFilterByDateAndNumbers(
      {required String pageSize, required TwilioCreds twilioCreds});
}

class TwilioSMSRepositoryImpl extends TwilioSmsRepository {
  final http.Client client = http.Client();
  @override
  Future<SentSmsData> getSmsList(
      {required String pageSize, required TwilioCreds? twilioCreds}) async {
    String url = twilioCreds!.url + '?PageSize=$pageSize';
    String cred = twilioCreds.cred;
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);
    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final sentSmsData = sentSmsDataFromJson(response.body);
      return sentSmsData;
    } else {
      print('Request Failed');
      throw Exception();
    }
  }

  @override
  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds? twilioCreds}) async {
    String cred = twilioCreds!.cred;
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);

    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    var body = {
      'From': twilioCreds.twilioNumber,
      'To': toNumber,
      'Body': messageBody
    };
    http.Response response = await http.post(Uri.parse(twilioCreds.url),
        headers: headers, body: body);
    if (response.statusCode == 201) {
      print('Sms sent Success');
      return response.statusCode;
    } else {
      print('Sending Failed');
      ErrorData errorData = ErrorData.fromJson(jsonDecode(response.body));
      print('Error Code : ' + errorData.code.toString());
      print('Error Message : ' + errorData.message!);
      print("More info : " + errorData.moreInfo!);
      throw Exception();
    }
  }

  @override
  Future<Message> getSmsData(
      {required String messageSID, required TwilioCreds? twilioCreds}) async {
    String uri =
        '${Utils.baseUri}/${Utils.version}/Accounts/${twilioCreds!.accountSid}/Messages/$messageSID';
    uri = uri + '.json';
    String cred = twilioCreds.cred;
    var bytes = utf8.encode(cred);
    var base64Str = base64.encode(bytes);
    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json'
    };
    http.Response response = await http.get(
      Uri.parse(uri),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final messageData = Message.fromJson(jsonDecode(response.body));
      return messageData;
    } else {
      print('Request Failed');
      throw Exception();
    }
  }

  @override
  Future<int> deleteMessage({String? messageSID, TwilioCreds? twilioCreds}) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  Future<SentSmsData> smsListFilterByDateAndNumbers(
      {String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterByDateAndNumbers
    throw UnimplementedError();
  }

  @override
  Future<SentSmsData> smsListFilterBySentBefore(
      {String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterBySentBefore
    throw UnimplementedError();
  }

  @override
  Future<SentSmsData> smsListFilterByTimePeriod(
      {String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterByTimePeriod
    throw UnimplementedError();
  }
}
