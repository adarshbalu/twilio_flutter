import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/services/network_repository.dart';

abstract class TwilioVerifyRepository extends NetworkRepository {
  Future<TwilioResponse> createVerificationService(
      {required TwilioCreds twilioCreds, required String serviceName});

  Future<TwilioResponse> sendVerificationCode(
      {required TwilioCreds twilioCreds,
      required String verificationServiceId,
      required String recipient,
      required String verificationChannel});

  Future<TwilioResponse> verifyCode(
      {required TwilioCreds twilioCreds,
      required String verificationServiceId,
      required String recipient,
      required String code});
}
