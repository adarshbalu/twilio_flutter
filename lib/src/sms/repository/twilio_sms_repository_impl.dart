import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/services/network.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/shared/utils/log_helper.dart';
import 'package:twilio_flutter/src/shared/utils/request_util.dart';
import 'package:twilio_flutter/src/shared/utils/utils.dart';

import '../../shared/dto/twilio_creds.dart';
import '../dto/sent_sms_data.dart';
import 'twilio_sms_repository.dart';

class TwilioSMSRepositoryImpl extends TwilioSmsRepository {
  late http.Client client;

  TwilioSMSRepositoryImpl() {
    client = locator.get<http.Client>(instanceName: "http.client");
  }

  final logger = LogHelper(className: 'TwilioSMSRepositoryImpl');

  @override
  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds}) async {
    var headers = RequestUtil.generateHeaderWithBase64(twilioCreds.cred);
    var body = {
      'From': twilioCreds.twilioNumber,
      'To': toNumber,
      'Body': messageBody
    };
    http.Response response =
        await NetworkHelper.createRequest(twilioCreds.url, headers, body);
    logger.info("SMS Sent to [$toNumber] - [$messageBody]");
    return response.statusCode;
  }

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
