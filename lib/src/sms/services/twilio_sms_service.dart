import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';

import '../../shared/dto/twilio_creds.dart';
import '../dto/twilio_message.dart';
import '../dto/twilio_message_list.dart';

abstract class TwilioSMSService {
  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber});

  Future<TwilioMessageList> getSmsList(
      {required String? pageSize, required TwilioCreds twilioCreds});

  Future<TwilioMessage> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds});

  Future<int> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt,
      String? fromNumber});

  Future<int> cancelScheduledSms({
    required String messageSid,
    required TwilioMessagingServiceCreds twilioCreds,
  });
}
