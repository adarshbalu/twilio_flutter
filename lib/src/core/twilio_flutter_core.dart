library twilio_flutter;

import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/enums/verification_channel.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';
import 'package:twilio_flutter/src/verify/services/twilio_verify_service.dart';
import 'package:twilio_flutter/src/whatsapp/services/twilio_whatsapp_service.dart';

///
///Twilio’s Programmable SMS API helps you add robust messaging capabilities to your applications.
/// To use [TwilioFlutter] you will use your Twilio Account SID as the username and your Auth Token as the password for HTTP Basic authentication with Twilio.
///
class TwilioFlutter {
  late TwilioCreds _twilioCreds;
  late TwilioSMSService _smsService;
  late TwilioWhatsAppService _whatsAppService;
  late TwilioVerifyService _twilioVerifyService;

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
    _twilioVerifyService = locator.get<TwilioVerifyService>(
        instanceName: "TwilioVerifyServiceImpl");
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

  ///	createVerificationService
  ///	 [serviceName] : Service name for the verification service
  /// This method returns [TwilioResponse] and [metadata] from [TwilioResponse] will have the
  /// verification service ID in the key:"sid"
  ///
  ///	For status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<TwilioResponse> createVerificationService(
      {required String serviceName}) async {
    return await _twilioVerifyService.createVerificationService(
        serviceName: serviceName, twilioCreds: _twilioCreds);
  }

  ///	sendVerificationCode
  ///	 [verificationChannel] : Channel for verification, possible values: sms, whatsapp
  /// [recipient]: Recipient address, can be mobile number, email etc depending on channel
  /// [verificationServiceId] : Verification service sid of the service
  ///
  ///	For status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<TwilioResponse> sendVerificationCode(
      {required String verificationServiceId,
      required String recipient,
      required VerificationChannel verificationChannel}) async {
    return await _twilioVerifyService.sendVerificationCode(
        recipient: recipient,
        twilioCreds: _twilioCreds,
        verificationChannel: verificationChannel,
        verificationServiceId: verificationServiceId);
  }

  ///	verifyCode
  ///	 [code] : Code for verification
  /// [recipient]: Recipient address, can be mobile number, email etc depending on channel
  /// [verificationServiceId] : Verification service sid of the service
  /// This method returns [TwilioResponse] and [metadata] from [TwilioResponse] has a
  /// [status] key, if it is "approved" then the verification is success
  ///	For status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<TwilioResponse> verifyCode(
      {required String verificationServiceId,
      required String recipient,
      required String code}) async {
    return await _twilioVerifyService.verifyCode(
        recipient: recipient,
        twilioCreds: _twilioCreds,
        code: code,
        verificationServiceId: verificationServiceId);
  }
}
