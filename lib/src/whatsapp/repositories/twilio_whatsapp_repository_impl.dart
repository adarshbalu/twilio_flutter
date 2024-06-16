import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/enums/request_type.dart';
import 'package:twilio_flutter/src/whatsapp/repositories/twilio_whatsapp_repository.dart';

import '../../shared/services/network.dart';
import '../../shared/services/service_locator.dart';
import '../../shared/utils/log_helper.dart';
import '../../shared/utils/request_utils.dart';

class TwilioWhatsAppRepositoryImpl extends TwilioWhatsAppRepository {
  late http.Client client;

  TwilioWhatsAppRepositoryImpl() {
    client = locator.get<http.Client>(instanceName: "http.client");
  }

  final logger = LogHelper(className: 'TwilioWhatsAppRepositoryImpl');

  @override
  Future<TwilioResponse> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber}) async {
    final headers =
        RequestUtils.generateHeaderWithBase64(twilioCreds.authString);
    final String url = RequestUtils.generateMessagesUrl(twilioCreds.accountSid);
    final body = {
      'From': 'whatsapp:' + (fromNumber ?? twilioCreds.twilioNumber),
      'To': 'whatsapp:' + toNumber,
      'Body': messageBody
    };
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, body: body, requestType: RequestType.POST);
    logger.info("Whatsapp Message Sent to [$toNumber] - [$messageBody]");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<TwilioResponse> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt,
      String? fromNumber}) async {
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final body = {
      'To': 'whatsapp:' + toNumber,
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
    logger.info(
        "WhatsApp Message Scheduled at [$sendAt] to [$toNumber] - [$messageBody]");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<TwilioResponse> cancelScheduledWhatsAppMessage(
      {required String messageSid,
      required TwilioMessagingServiceCreds twilioCreds}) async {
    final String url =
        RequestUtils.generateSpecificSmsUrl(twilioCreds.accountSid, messageSid);
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final body = {'Status': 'canceled'};
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, body: body, requestType: RequestType.POST);
    logger.info("Cancelled Whatsapp Message [$messageSid] Successfully");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<TwilioResponse> sendWhatsApp(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds}) async {
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);
    final body = {
      'To': 'whatsapp:' + toNumber,
      'Body': messageBody,
      'MessagingServiceSid': twilioCreds.messagingServiceSid,
    };
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: twilioCreds.url,
        headers: headers,
        body: body,
        requestType: RequestType.POST);
    logger.info("WhatsApp Message to [$toNumber] - [$messageBody]");
    return handleRequest(response: response, requestType: RequestType.POST);
  }
}
