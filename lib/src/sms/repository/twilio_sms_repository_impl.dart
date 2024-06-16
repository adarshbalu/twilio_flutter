import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/enums/request_type.dart';
import 'package:twilio_flutter/src/shared/services/network.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/shared/utils/log_helper.dart';
import 'package:twilio_flutter/src/shared/utils/request_utils.dart';

import '../../shared/dto/twilio_creds.dart';
import 'twilio_sms_repository.dart';

class TwilioSMSRepositoryImpl extends TwilioSmsRepository {
  late http.Client client;

  TwilioSMSRepositoryImpl() {
    client = locator.get<http.Client>(instanceName: "http.client");
  }

  final logger = LogHelper(className: 'TwilioSMSRepositoryImpl');

  @override
  Future<TwilioResponse> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber}) async {
    final headers =
        RequestUtils.generateHeaderWithBase64(twilioCreds.authString);
    final body = {
      'From': fromNumber ?? twilioCreds.twilioNumber,
      'To': toNumber,
      'Body': messageBody
    };
    final String url = RequestUtils.generateMessagesUrl(twilioCreds.accountSid);
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, body: body, requestType: RequestType.POST);
    logger.info("SMS Sent to [$toNumber] - [$messageBody]");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<TwilioResponse> getSmsList(
      {required String pageSize, required TwilioCreds twilioCreds}) async {
    final String url =
        RequestUtils.generateSmsListUrl(twilioCreds.accountSid, pageSize);
    final headers =
        RequestUtils.generateHeaderWithBase64(twilioCreds.authString);
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, requestType: RequestType.GET);
    logger.info("Received SMS List Successfully");
    return handleRequest(response: response, requestType: RequestType.GET);
  }

  @override
  Future<TwilioResponse> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds}) async {
    String url =
        RequestUtils.generateSpecificSmsUrl(twilioCreds.accountSid, messageSID);
    final headers =
        RequestUtils.generateHeaderWithBase64(twilioCreds.authString);
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, requestType: RequestType.GET);
    logger.info("Received SMS Details Successfully");
    return handleRequest(response: response, requestType: RequestType.GET);
  }

  @override
  Future<TwilioResponse> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
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
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: twilioCreds.url,
        headers: headers,
        body: body,
        requestType: RequestType.POST);
    logger.info("SMS Scheduled at [$sendAt] to [$toNumber] - [$messageBody]");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<TwilioResponse> cancelScheduledSms(
      {required String messageSid,
      required TwilioMessagingServiceCreds twilioCreds}) async {
    final String url =
        RequestUtils.generateSpecificSmsUrl(twilioCreds.accountSid, messageSid);
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final body = {'Status': 'canceled'};
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, body: body, requestType: RequestType.POST);
    logger.info("Cancelled SMS [$messageSid] Successfully");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<TwilioResponse> sendSms(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      String? fromNumber}) async {
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final body = {
      'To': toNumber,
      'Body': messageBody,
      'MessagingServiceSid': twilioCreds.messagingServiceSid,
    };
    if (fromNumber != null) {
      body['From'] = fromNumber;
    }
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: twilioCreds.url,
        headers: headers,
        body: body,
        requestType: RequestType.POST);
    logger.info("SMS Sent to [$toNumber] - [$messageBody]");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<int> deleteMessage({String? messageSID, TwilioCreds? twilioCreds}) {
    // TODO: implement deleteMessage
    throw UnimplementedError();
  }

  @override
  Future<TwilioResponse> smsListFilterByDateAndNumbers(
      {String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterByDateAndNumbers
    throw UnimplementedError();
  }

  @override
  Future<TwilioResponse> smsListFilterBySentBefore(
      {String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterBySentBefore
    throw UnimplementedError();
  }

  @override
  Future<TwilioResponse> smsListFilterByTimePeriod(
      {String? pageSize, TwilioCreds? twilioCreds}) {
    // TODO: implement smsListFilterByTimePeriod
    throw UnimplementedError();
  }
}
