import 'package:twilio_flutter/src/shared/dto/twilio_messenger_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/services/network_repository.dart';

abstract class TwilioMessengerRepository extends NetworkRepository {
  Future<TwilioResponse> sendMessenger(
      {required String recipientIdentifier,
      required String messageBody,
      required TwilioMessengerCreds twilioCreds,
      String? senderIdentifier});
}
