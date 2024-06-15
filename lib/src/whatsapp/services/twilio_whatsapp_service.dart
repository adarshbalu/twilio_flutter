import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';

abstract class TwilioWhatsAppService {
  Future<int> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds});

  Future<int> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt});

  Future<int> cancelScheduledWhatsAppMessage({
    required String messageSid,
    required TwilioMessagingServiceCreds twilioCreds,
  });
}
