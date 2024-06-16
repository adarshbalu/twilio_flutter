import 'package:twilio_flutter/src/shared/dto/twilio_messenger_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';

abstract class TwilioMessengerService {
  Future<TwilioResponse> sendMessenger(
      {required String recipientIdentifier,
      required String messageBody,
      required TwilioMessengerCreds twilioCreds,
      String? senderIdentifier});
}
