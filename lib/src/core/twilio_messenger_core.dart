import 'package:twilio_flutter/src/messenger/services/twilio_messenger_service.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messenger_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';

///
///Twilio’s Programmable Messenger API helps you add robust messaging capabilities to your applications.
/// To use [TwilioMessenger] you will use your Twilio Account SID as the username and your Auth Token as the password for HTTP Basic authentication with Twilio.
///
class TwilioMessenger {
  late TwilioMessengerCreds _twilioCreds;
  late TwilioMessengerService _twilioMessengerService;

  TwilioMessenger(
      {required String accountSid,
      required String authToken,
      required String messengerId}) {
    // Register services
    registerServices();

    // Create Twilio Credentials object
    _twilioCreds = TwilioMessengerCreds(
        accountSid: accountSid, authToken: authToken, messengerId: messengerId);

    // Initialize all services
    _twilioMessengerService = locator.get<TwilioMessengerService>(
        instanceName: "TwilioMessengerServiceImpl");
  }

  ///	sendMessenger
  ///	 [recipient] : The recipient to which text message has to be sent.
  ///	 [messageBody] : The content of the message to be sent.
  ///
  ///	Method called to send text messages to the specified sender id with given content.
  ///
  /// Returns [TwilioResponse]
  ///	201 -> message sent successfully.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<TwilioResponse> sendMessenger(
      {required String recipient, required String messageBody}) async {
    return await _twilioMessengerService.sendMessenger(
        recipientIdentifier: recipient,
        messageBody: messageBody,
        twilioCreds: _twilioCreds);
  }

  /// changeDefaultMessengerId
  /// [messengerId] : A non-null value for new messenger Id
  void changeDefaultMessengerId(String messengerId) {
    this._twilioCreds.messengerId = messengerId;
  }
}
