import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/services/network_repository.dart';

abstract class TwilioWhatsAppRepository extends NetworkRepository {
  Future<TwilioResponse> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber});

  Future<TwilioResponse> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt,
      String? fromNumber});

  Future<TwilioResponse> cancelScheduledWhatsAppMessage({
    required String messageSid,
    required TwilioMessagingServiceCreds twilioCreds,
  });

  Future<TwilioResponse> sendWhatsApp(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds});
}
