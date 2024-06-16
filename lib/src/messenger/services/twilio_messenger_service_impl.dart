import 'package:twilio_flutter/src/messenger/repository/twilio_messenger_repository.dart';
import 'package:twilio_flutter/src/messenger/services/twilio_messenger_service.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messenger_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/exceptions/http_exception.dart';
import 'package:twilio_flutter/src/shared/exceptions/twilio_flutter_exception.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/shared/utils/log_helper.dart';

class TwilioMessengerServiceImpl extends TwilioMessengerService {
  late TwilioMessengerRepository _messengerRepository;

  TwilioMessengerServiceImpl() {
    _messengerRepository = locator.get<TwilioMessengerRepository>(
        instanceName: "TwilioMessengerRepositoryImpl");
  }

  final logger = LogHelper(className: 'TwilioMessengerServiceImpl');

  @override
  Future<TwilioResponse> sendMessenger(
      {required String recipientIdentifier,
      required String messageBody,
      required TwilioMessengerCreds twilioCreds,
      String? senderIdentifier}) async {
    try {
      logger.info("Messenger text Initiated from [${twilioCreds.messengerId}]");
      return await _messengerRepository.sendMessenger(
          recipientIdentifier: recipientIdentifier,
          messageBody: messageBody,
          twilioCreds: twilioCreds,
          senderIdentifier: senderIdentifier);
    } on HttpCallException catch (e) {
      throw TwilioFlutterException(
          message: "Failed to Send Messenger Text", thrownException: e);
    } on Exception catch (e) {
      throw TwilioFlutterException(
          message: "Unknown Error: Failed to Send Messenger Text",
          thrownException: e);
    }
  }
}
