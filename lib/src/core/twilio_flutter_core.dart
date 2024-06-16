library twilio_flutter;

import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';
import 'package:twilio_flutter/src/whatsapp/services/twilio_whatsapp_service.dart';

///
///Twilio’s Programmable SMS API helps you add robust messaging capabilities to your applications.
/// To use [TwilioFlutter] you will use your Twilio Account SID as the username and your Auth Token as the password for HTTP Basic authentication with Twilio.
///
class TwilioFlutter {
  late TwilioCreds _twilioCreds;
  late TwilioSMSService _smsService;
  late TwilioWhatsAppService _whatsAppService;

  /// Creates a TwilioFlutter Object with [accountSid] , [authToken] , [twilioNumber].
  /// Optional parameter [messagingServiceSid] can be passed in if [sendScheduledSms] is required.
  /// [accountSid] , [authToken] , [twilioNumber]  Your Account Sid and Auth Token from twilio.com/console
  ///  Should be not null Strings.
  ///
  /// [twilioNumber] can later be changed.
  TwilioFlutter(
      {required String accountSid,
      required String authToken,
      required String twilioNumber}) {
    // Register services
    registerServices();

    // Create Twilio Credentials object
    _twilioCreds = TwilioCreds(
        accountSid: accountSid,
        authToken: authToken,
        twilioNumber: twilioNumber);

    // Initialize all services
    _smsService =
        locator.get<TwilioSMSService>(instanceName: "TwilioSMSServiceImpl");
    _whatsAppService = locator.get<TwilioWhatsAppService>(
        instanceName: "TwilioWhatsAppServiceImpl");
  }

  ///	sendSMS
  ///	 [toNumber] : The number to which text message has to be sent.
  ///	 [messageBody] : The content of the message to be sent.
  ///
  ///	Method called to send text messages to the specified phone number with given content.
  ///
  /// Returns [TwilioResponse]
  ///	201 -> message sent successfully.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<TwilioResponse> sendSMS(
      {required String toNumber, required String messageBody}) async {
    return await _smsService.sendSMS(
        toNumber: toNumber,
        messageBody: messageBody,
        twilioCreds: _twilioCreds);
  }

  /// changeDefaultTwilioNumber
  /// [twilioNumber] : A non-null value for new twilio number
  void changeDefaultTwilioNumber(String twilioNumber) {
    this._twilioCreds.twilioNumber = twilioNumber;
  }

  /// getSmsList
  /// Get all messages associated with your account
  /// Pass [pageSize] to get specific page sizes.
  /// [pageSize] value defaults to 20
  Future<TwilioResponse> getSmsList({String? pageSize}) async {
    return await _smsService.getSmsList(
        pageSize: pageSize, twilioCreds: _twilioCreds);
  }

  /// getSMS
  /// Get all data of a specific message
  /// Pass [messageSid] as a non null Message SID.
  Future<TwilioResponse> getSMS(String messageSid) async {
    return await _smsService.getSmsData(
        messageSID: messageSid, twilioCreds: _twilioCreds);
  }

  ///	sendWhatsApp
  ///	 [toNumber] : The number to which whatsapp message has to be sent.
  ///	 [messageBody] : The content of the message to be sent.
  ///
  ///	Method called to send whatsapp messages to the specified phone number with given content.
  ///
  /// Returns
  ///	201 -> message sent successfully.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<TwilioResponse> sendWhatsApp(
      {required String toNumber, required String messageBody}) async {
    return await _whatsAppService.sendWhatsAppMessage(
        toNumber: toNumber,
        messageBody: messageBody,
        twilioCreds: _twilioCreds);
  }
}
