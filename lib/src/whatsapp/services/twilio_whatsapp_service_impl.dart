import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/exceptions/twilio_flutter_exception.dart';
import 'package:twilio_flutter/src/whatsapp/repositories/twilio_whatsapp_repository.dart';
import 'package:twilio_flutter/src/whatsapp/services/twilio_whatsapp_service.dart';
import 'package:twilio_flutter/src/whatsapp/validation/twilio_whatsapp_validator.dart';

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
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unable to Send Whatsapp Message", thrownException: e);
    }
  }

  @override
  Future<int> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      required String sendAt}) {
    try {
      _validator.validateTwilio(twilioCreds);
      _validator.validateDateTime(sendAt);
      logger.info(
          "Scheduled WhatsApp Message Initiated from [${twilioCreds.twilioNumber}]");
      return _whatsAppRepository.sendScheduledWhatsAppMessage(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds,
          sendAt: sendAt);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send Scheduled WhatsApp Message",
          thrownException: e);
    }
  }
}
