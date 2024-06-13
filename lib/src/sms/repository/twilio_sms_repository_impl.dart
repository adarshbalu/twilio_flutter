import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/services/network.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/shared/utils/log_helper.dart';
import 'package:twilio_flutter/src/shared/utils/request_utils.dart';

import '../../shared/dto/twilio_creds.dart';
import '../dto/message.dart';
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
      required TwilioCreds twilioCreds,
      String? fromNumber}) async {
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final body = {
      'From': fromNumber ?? twilioCreds.twilioNumber,
      'To': toNumber,
      'Body': messageBody
    };
    final http.Response response =
        await NetworkHelper.createRequest(twilioCreds.url, headers, body);
    logger.info("SMS Sent to [$toNumber] - [$messageBody]");
    return response.statusCode;
  }

  @override
  Future<SentSmsData> getSmsList(
      {required String pageSize, required TwilioCreds twilioCreds}) async {
    final String url =
        RequestUtils.generateSmsListUrl(twilioCreds.accountSid, pageSize);
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final response = await NetworkHelper.getRequest(url, headers);
    logger.info("Received SMS List Successfully");
    return SentSmsData.fromJson(response);
  }

  @override
  Future<Message> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds}) async {
    String url =
        RequestUtils.generateSpecificSmsUrl(twilioCreds.accountSid, messageSID);
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final response = await NetworkHelper.getRequest(url, headers);
    logger.info("Received SMS Details Successfully");
    return Message.fromJson(response);
  }

  @override
  Future<int> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      required String sendAt,
      String? fromNumber}) async {
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final body = {
      'To': toNumber,
      'Body': messageBody,
      'ScheduleType': 'fixed',
      'MessagingServiceSid': twilioCreds.messagingServiceSid,
      'SendAt': sendAt
    };
    final http.Response response =
        await NetworkHelper.createRequest(twilioCreds.url, headers, body);
    logger.info("SMS Scheduled at [$sendAt] to [$toNumber] - [$messageBody]");
    return response.statusCode;
  }

  @override
  Future<int> cancelScheduledSms(
      {required String messageSid, required TwilioCreds twilioCreds}) async {
    final String url =
        RequestUtils.generateSpecificSmsUrl(twilioCreds.accountSid, messageSid);
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final body = {'Status': 'canceled'};
    final http.Response response =
        await NetworkHelper.createRequest(url, headers, body);
    logger.info("Cancelled SMS [$messageSid] Successfully");
    return response.statusCode;
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
