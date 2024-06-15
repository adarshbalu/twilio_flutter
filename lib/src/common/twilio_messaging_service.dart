import 'package:twilio_flutter/src/shared/dto/TwilioMessagingServiceCreds.dart';
import 'package:twilio_flutter/src/shared/services/service_locator.dart';
import 'package:twilio_flutter/src/sms/services/twilio_sms_service.dart';
import 'package:twilio_flutter/src/whatsapp/services/twilio_whatsapp_service.dart';

class TwilioMessagingService {
  late TwilioMessagingServiceCreds _twilioCreds;
  late TwilioSMSService _smsService;
  late TwilioWhatsAppService _whatsAppService;

  /// Creates a TwilioMessagingService Object with [accountSid] , [authToken] , [messagingServiceSid].
  /// [accountSid] , [authToken] , [messagingServiceSid]  Your Account Sid and Auth Token from twilio.com/console
  ///  Should be not null Strings.
  TwilioMessagingService(
      {required final String accountSid,
      required final String authToken,
      required final messagingServiceSid}) {
    // Register services
    registerServices();

    // Create Twilio Credentials object
    _twilioCreds = TwilioMessagingServiceCreds(
        accountSid: accountSid,
        authToken: authToken,
        messagingServiceSid: messagingServiceSid);

    // Initialize all services
    _smsService =
        locator.get<TwilioSMSService>(instanceName: "TwilioSMSServiceImpl");
    _whatsAppService = locator.get<TwilioWhatsAppService>(
        instanceName: "TwilioWhatsAppServiceImpl");
  }

  ///	sendScheduledSms
  ///	 [toNumber] : The number to which sms message has to be sent.
  ///	 [messageBody] : The content of the message to be sent.
  /// [sendAt] : Time at which the sms has to be sent (Minimum 15 minutes after current time)
  ///	Method called to send scheduled sms messages to the specified phone number with given content.
  /// This requires a Messaging service SID registered with twilio and
  /// Returns
  ///	201 -> message scheduled successfully.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<int> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required String sendAt}) async {
    return await _smsService.sendScheduledSms(
        toNumber: toNumber,
        messageBody: messageBody,
        twilioCreds: _twilioCreds,
        sendAt: sendAt);
  }

  ///	sendScheduledWhatsAppMessage
  ///	 [toNumber] : The whatsapp number to which sms message has to be sent.
  ///	 [messageBody] : The content of the message to be sent.
  /// [sendAt] : Time at which the whatsapp message has to be sent (Minimum 15 minutes after current time)
  ///	Method called to send scheduled whatsapp messages to the specified phone number with given content.
  /// This requires a Messaging service SID registered with twilio and
  /// Returns
  ///	201 -> message scheduled successfully.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<int> sendScheduledWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required String sendAt}) async {
    return await _whatsAppService.sendScheduledWhatsAppMessage(
        toNumber: toNumber,
        messageBody: messageBody,
        twilioCreds: _twilioCreds,
        sendAt: sendAt);
  }

  ///	cancelScheduledSms
  ///	 [messageSid] : The unique sid of message for which has to be cancelled.
  /// Returns
  ///	200 -> scheduled message cancelled successfully.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<int> cancelScheduledSms({required String messageSid}) async {
    return await _smsService.cancelScheduledSms(
        twilioCreds: _twilioCreds, messageSid: messageSid);
  }

  ///	cancelScheduledWhatsAppMessage
  ///	 [messageSid] : The unique sid of message for which has to be cancelled.
  /// Returns
  ///	200 -> scheduled message cancelled successfully.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<int> cancelScheduledWhatsAppMessage(
      {required String messageSid}) async {
    return await _whatsAppService.cancelScheduledWhatsAppMessage(
        twilioCreds: _twilioCreds, messageSid: messageSid);
  }
}
