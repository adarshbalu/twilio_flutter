import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/sms/dto/sent_sms_data.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';

import '../../shared/exceptions/twilio_flutter_exception.dart';
import '../../shared/utils/log_helper.dart';
import '../dto/message.dart';
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
  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds}) async {
    try {
      logger.info("SMS Initiated from [${twilioCreds.twilioNumber}]");
      return await _smsRepository.sendSMS(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send SMS", thrownException: e);
    }
  }

  @override
  Future<SentSmsData> getSmsList(
      {required String? pageSize, required TwilioCreds twilioCreds}) async {
    try {
      logger
          .info("Get SMS List Initiated with Page Size: [${pageSize ?? '20'}]");
      return await _smsRepository.getSmsList(
          pageSize: pageSize ?? '20', twilioCreds: twilioCreds);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Failed to get SMS List", thrownException: e);
    }
  }

  @override
  Future<Message> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds}) async {
    try {
      logger.info("Get SMS Details Initiated for message: [${messageSID}]");
      return await _smsRepository.getSmsData(
          messageSID: messageSID, twilioCreds: twilioCreds);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Failed to get SMS details", thrownException: e);
    }
  }

  @override
  Future<int> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      required String sendAt}) async {
    try {
      _smsValidator.validateTwilio(twilioCreds);
      _smsValidator.validateDateTime(sendAt);
      logger.info("Scheduled SMS Initiated from [${twilioCreds.twilioNumber}]");
      return await _smsRepository.sendScheduledSms(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds,
          sendAt: sendAt);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send Scheduled SMS", thrownException: e);
    }
  }

  @override
  Future<int> cancelScheduledSms(
      {required String messageSid, required TwilioCreds twilioCreds}) async {
    try {
      logger.info("Cancel Scheduled SMS initiated for : [${messageSid}]");
      return await _smsRepository.cancelScheduledSms(
          messageSid: messageSid, twilioCreds: twilioCreds);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Failed to cancel scheduled SMS details",
          thrownException: e);
    }
  }
}
