import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/whatsapp/repositories/twilio_whatsapp_repository.dart';
import 'package:twilio_flutter/src/whatsapp/services/twilio_whatsapp_service.dart';
import 'package:twilio_flutter/src/whatsapp/validation/twilio_whatsapp_validator.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../../shared/services/service_locator.dart';
import '../../shared/utils/log_helper.dart';

class TwilioWhatsAppServiceImpl extends TwilioWhatsAppService {
  late TwilioWhatsAppRepository _whatsAppRepository;

  TwilioWhatsAppServiceImpl() {
    _whatsAppRepository = locator.get<TwilioWhatsAppRepository>(
        instanceName: "TwilioWhatsAppRepositoryImpl");
  }

  final TwilioWhatsAppValidator _validator = TwilioWhatsAppValidator();
  final logger = LogHelper(className: 'TwilioWhatsAppServiceImpl');

  @override
  Future<int> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds}) async {
    try {
      logger.info(
          "Whatsapp Message Initiated from [${twilioCreds.twilioNumber}]");
      return await _whatsAppRepository.sendWhatsAppMessage(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send Whatsapp message", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Send Whatsapp message",
          thrownException: e);
    }
  }

  @override
  Future<int> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt}) {
    try {
      _validator.validateDateTime(sendAt);
      logger.info(
          "Scheduled WhatsApp Message Initiated from [${twilioCreds.messagingServiceSid}]");
      return _whatsAppRepository.sendScheduledWhatsAppMessage(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds,
          sendAt: sendAt);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send scheduled Whatsapp message",
          thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Send scheduled Whatsapp message",
          thrownException: e);
    }
  }

  @override
  Future<int> cancelScheduledWhatsAppMessage(
      {required String messageSid,
      required TwilioMessagingServiceCreds twilioCreds}) async {
    try {
      logger.info(
          "Cancel Scheduled WhatsApp Message initiated for : [${messageSid}]");
      return await _whatsAppRepository.cancelScheduledWhatsAppMessage(
          messageSid: messageSid, twilioCreds: twilioCreds);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to cancel scheduled Whatsapp message",
          thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to cancel scheduled Whatsapp message",
          thrownException: e);
    }
  }
}
