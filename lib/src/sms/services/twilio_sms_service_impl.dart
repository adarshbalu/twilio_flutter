import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/exceptions/http_exception.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';

import '../../shared/exceptions/twilio_flutter_exception.dart';
import '../../shared/utils/log_helper.dart';
import '../repository/twilio_sms_repository.dart';
import '../validation/twilio_sms_validator.dart';

class TwilioSMSServiceImpl extends TwilioSMSService {
  late TwilioSmsRepository _smsRepository;
  final TwilioSmsValidator _smsValidator = TwilioSmsValidator();

  TwilioSMSServiceImpl() {
    _smsRepository = locator.get<TwilioSmsRepository>(
        instanceName: "TwilioSMSRepositoryImpl");
  }

  final logger = LogHelper(className: 'TwilioSMSServiceImpl');

  @override
  Future<TwilioResponse> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber}) async {
    try {
      logger.info("SMS Initiated from [${twilioCreds.twilioNumber}]");
      return await _smsRepository.sendSMS(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds,
          fromNumber: fromNumber);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send SMS", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Send SMS", thrownException: e);
    }
  }

  @override
  Future<TwilioResponse> getSmsList(
      {required String? pageSize, required TwilioCreds twilioCreds}) async {
    try {
      logger
          .info("Get SMS List Initiated with Page Size: [${pageSize ?? '20'}]");
      return await _smsRepository.getSmsList(
          pageSize: pageSize ?? '20', twilioCreds: twilioCreds);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Get SMS list", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Get SMS List", thrownException: e);
    }
  }

  @override
  Future<TwilioResponse> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds}) async {
    try {
      logger.info("Get SMS Details Initiated for message: [${messageSID}]");
      return await _smsRepository.getSmsData(
          messageSID: messageSID, twilioCreds: twilioCreds);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Get SMS data", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Get SMS data", thrownException: e);
    }
  }

  @override
  Future<TwilioResponse> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt,
      String? fromNumber}) async {
    try {
      _smsValidator.validateDateTime(sendAt);
      logger.info(
          "Scheduled SMS Initiated from [${twilioCreds.messagingServiceSid}]");
      return await _smsRepository.sendScheduledSms(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds,
          sendAt: sendAt,
          fromNumber: fromNumber);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send scheduled SMS", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Send scheduled SMS",
          thrownException: e);
    }
  }

  @override
  Future<TwilioResponse> cancelScheduledSms(
      {required String messageSid,
      required TwilioMessagingServiceCreds twilioCreds}) async {
    try {
      logger.info("Cancel Scheduled SMS initiated for : [${messageSid}]");
      return await _smsRepository.cancelScheduledSms(
          messageSid: messageSid, twilioCreds: twilioCreds);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to cancel scheduled SMS", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to cancel scheduled SMS",
          thrownException: e);
    }
  }

  @override
  Future<TwilioResponse> sendSms(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      String? fromNumber}) async {
    try {
      logger.info(
          "Scheduled SMS Initiated from [${twilioCreds.messagingServiceSid}]");
      return await _smsRepository.sendSms(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds,
          fromNumber: fromNumber);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send SMS", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Send SMS", thrownException: e);
    }
  }
}
