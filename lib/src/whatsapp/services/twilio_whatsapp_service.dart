import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';

abstract class TwilioWhatsAppService {
  Future<int> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds});
}
