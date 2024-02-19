import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';

abstract class TwilioWhatsAppRepository {
  Future<int> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds});

  Future<int> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      required String sendAt});
}
