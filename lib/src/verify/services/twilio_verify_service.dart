import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/enums/verification_channel.dart';

abstract class TwilioVerifyService {
  Future<TwilioResponse> createVerificationService(
      {required TwilioCreds twilioCreds, required String serviceName});

  Future<TwilioResponse> sendVerificationCode(
      {required TwilioCreds twilioCreds,
      required String verificationServiceId,
      required String recipient,
      required VerificationChannel verificationChannel});

  Future<TwilioResponse> verifyCode(
      {required TwilioCreds twilioCreds,
      required String verificationServiceId,
      required String recipient,
      required String code});
}
