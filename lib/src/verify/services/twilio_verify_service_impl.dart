import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/enums/verification_channel.dart';
import 'package:twilio_flutter/src/shared/exceptions/http_exception.dart';
import 'package:twilio_flutter/src/shared/exceptions/twilio_flutter_exception.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/shared/utils/log_helper.dart';
import 'package:twilio_flutter/src/verify/repository/twilio_verify_repository.dart';
import 'package:twilio_flutter/src/verify/services/twilio_verify_service.dart';

class TwilioVerifyServiceImpl extends TwilioVerifyService {
  late TwilioVerifyRepository _twilioVerifyRepository;
  final logger = LogHelper(className: 'TwilioVerifyServiceImpl');

  TwilioVerifyServiceImpl() {
    _twilioVerifyRepository = locator.get<TwilioVerifyRepository>(
        instanceName: "TwilioVerifyRepositoryImpl");
  }

  @override
  Future<TwilioResponse> createVerificationService(
      {required TwilioCreds twilioCreds, required String serviceName}) async {
    try {
      logger.info("Create Verification Initiated for [$serviceName]");
      return await _twilioVerifyRepository.createVerificationService(
          twilioCreds: twilioCreds, serviceName: serviceName);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send SMS", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Send SMS", thrownException: e);
    }
  }

  @override
  Future<TwilioResponse> sendVerificationCode(
      {required TwilioCreds twilioCreds,
      required String verificationServiceId,
      required String recipient,
      required VerificationChannel verificationChannel}) async {
    try {
      logger.info("Verification code sending initiated: [$recipient]");
      return await _twilioVerifyRepository.sendVerificationCode(
          twilioCreds: twilioCreds,
          recipient: recipient,
          verificationChannel: verificationChannel.name.toLowerCase(),
          verificationServiceId: verificationServiceId);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send Verification code", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Send Verification code",
          thrownException: e);
    }
  }

  @override
  Future<TwilioResponse> verifyCode(
      {required TwilioCreds twilioCreds,
      required String verificationServiceId,
      required String recipient,
      required String code}) async {
    try {
      logger.info("Verification code checking initiated: [$recipient]");
      return await _twilioVerifyRepository.verifyCode(
          twilioCreds: twilioCreds,
          recipient: recipient,
          code: code,
          verificationServiceId: verificationServiceId);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send verify code", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to verify Verification code",
          thrownException: e);
    }
  }
}
