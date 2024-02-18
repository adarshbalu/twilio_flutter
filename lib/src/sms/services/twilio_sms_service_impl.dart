import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/sms/dto/sent_sms_data.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';

import '../../shared/exceptions/twilio_flutter_exception.dart';
import '../../shared/utils/log_helper.dart';
import '../dto/message.dart';
import '../repository/twilio_sms_repository.dart';

class TwilioSMSServiceImpl extends TwilioSMSService {
  late TwilioSmsRepository _smsRepository;

  TwilioSMSServiceImpl() {
    _smsRepository = locator.get<TwilioSmsRepository>(
        instanceName: "TwilioSMSRepositoryImpl");
  }

  final logger = LogHelper(className: 'TwilioSMSServiceImpl');

  @override
  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds}) {
    try {
      logger.info("SMS Initiated from [${twilioCreds.twilioNumber}]");
      return _smsRepository.sendSMS(
          toNumber: toNumber,
          messageBody: messageBody,
          twilioCreds: twilioCreds);
    } catch (e) {
      throw TwilioFlutterException(message: "Failed to Send SMS");
    }
  }

  @override
  Future<SentSmsData> getSmsList(
      {required String? pageSize, required TwilioCreds twilioCreds}) {
    try {
      logger
          .info("Get SMS List Initiated with Page Size: [${pageSize ?? '20'}]");
      return _smsRepository.getSmsList(
          pageSize: pageSize ?? '20', twilioCreds: twilioCreds);
    } catch (e) {
      throw TwilioFlutterException(message: "Failed to get SMS List");
    }
  }

  @override
  Future<Message> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds}) {
    try {
      logger.info("Get SMS Details Initiated for message: [${messageSID}]");
      return _smsRepository.getSmsData(
          messageSID: messageSID, twilioCreds: twilioCreds);
    } catch (e) {
      throw TwilioFlutterException(message: "Failed to get SMS details");
    }
  }
}
