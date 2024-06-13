import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';

abstract class TwilioWhatsAppRepository {
  Future<int> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber});

  Future<int> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      required String sendAt,
      String? fromNumber});

  Future<int> cancelScheduledWhatsAppMessage({
    required String messageSid,
    required TwilioCreds twilioCreds,
  });
}
