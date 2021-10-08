import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/models/sent_sms_data.dart';
import 'package:twilio_flutter/src/models/twilio_creds.dart';
import 'package:twilio_flutter/src/utils/utils.dart';
import 'package:twilio_flutter/src/models/exceptions.dart';
import 'package:twilio_flutter/src/models/responses.dart';

abstract class TwilioSmsRepository {
  Future<SendSmsResponse> sendSms({
    required String from,
    required String to,
    required String body,
    required TwilioCreds twilioCreds,
    String? statusCallback,
  });

  Future<SentSmsData> getSmsList({
    required String pageSize,
    required TwilioCreds twilioCreds,
  });

  Future<Message> getSmsData({
    required String messageSID,
    required TwilioCreds twilioCreds,
  });

  Future<int> deleteMessage({
    required String messageSID,
    required TwilioCreds twilioCreds,
  });

  Future<SentSmsData> smsListFilterByTimePeriod({
    required String pageSize,
    required TwilioCreds twilioCreds,
  });

  Future<SentSmsData> smsListFilterBySentBefore({
    required String pageSize,
    required TwilioCreds twilioCreds,
  });

  Future<SentSmsData> smsListFilterByDateAndNumbers({
    required String pageSize,
    required TwilioCreds twilioCreds,
  });
}

class TwilioSmsRepositoryImpl extends TwilioSmsRepository {
  final http.Client client = http.Client();
  @override
  Future<SentSmsData> getSmsList({
    required String pageSize,
    required TwilioCreds twilioCreds,
  }) async {
    var bytes = utf8.encode('${twilioCreds.accountSid}:${twilioCreds.authToken}');
    var base64Str = base64.encode(bytes);
    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json',
    };

    http.Response response = await http.get(
      Uri.parse(
          '${Utils.baseUri}/${Utils.version}/Accounts/${twilioCreds.accountSid}/Messages.json?PageSize=$pageSize'),
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
  Future<SendSmsResponse> sendSms({
    required String from,
    required String to,
    required String body,
    required TwilioCreds twilioCreds,
    String? statusCallback,
  }) async {
    var bytes = utf8.encode('${twilioCreds.accountSid}:${twilioCreds.authToken}');
    var base64Str = base64.encode(bytes);

    var headers = {
      'Authorization': 'Basic $base64Str',
      'Accept': 'application/json',
    };
    var messageBody = {
      'From': from,
      'To': to,
      'Body': body,
    };

    if (statusCallback != null) {
      messageBody['StatusCallback'] = statusCallback;
    }

    http.Response response = await http.post(
      Uri.parse(
          '${Utils.baseUri}/${Utils.version}/Accounts/${twilioCreds.accountSid}/Messages.json'),
      headers: headers,
      body: messageBody,
    );

    if (response.statusCode == 201) {
      return SendSmsResponse(jsonDecode(response.body));
    } else {
      throw SendSmsError(jsonDecode(response.body));
    }
  }

  @override
  Future<Message> getSmsData({
    required String messageSID,
    required TwilioCreds twilioCreds,
  }) async {
    var bytes = utf8.encode('${twilioCreds.accountSid}:${twilioCreds.authToken}');
    var base64Str = base64.encode(bytes);
    var headers = {'Authorization': 'Basic $base64Str', 'Accept': 'application/json'};
    http.Response response = await http.get(
      Uri.parse(
          '${Utils.baseUri}/${Utils.version}/Accounts/${twilioCreds.accountSid}/Messages/$messageSID.json'),
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
  Future<SentSmsData> smsListFilterByDateAndNumbers({String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterByDateAndNumbers
    throw UnimplementedError();
  }

  @override
  Future<SentSmsData> smsListFilterBySentBefore({String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterBySentBefore
    throw UnimplementedError();
  }

  @override
  Future<SentSmsData> smsListFilterByTimePeriod({String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterByTimePeriod
    throw UnimplementedError();
  }
}
