import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';

import '../../shared/dto/twilio_creds.dart';

abstract class TwilioSMSService {
  Future<TwilioResponse> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber});

  Future<TwilioResponse> getSmsList(
      {required String? pageSize, required TwilioCreds twilioCreds});

  Future<TwilioResponse> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds});

  Future<TwilioResponse> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt,
      String? fromNumber});

  Future<TwilioResponse> cancelScheduledSms({
    required String messageSid,
    required TwilioMessagingServiceCreds twilioCreds,
  });

  Future<TwilioResponse> sendSms({
    required String toNumber,
    required String messageBody,
    required TwilioMessagingServiceCreds twilioCreds,
  });
}
