import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';

abstract class TwilioWhatsAppService {
  Future<TwilioResponse> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds});

  Future<TwilioResponse> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt});

  Future<TwilioResponse> cancelScheduledWhatsAppMessage({
    required String messageSid,
    required TwilioMessagingServiceCreds twilioCreds,
  });

  Future<TwilioResponse> sendWhatsApp(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      String? fromNumber});
}
