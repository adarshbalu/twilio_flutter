library twilio_flutter;

import 'package:twilio_flutter/src/models/sent_sms_data.dart';
import 'package:twilio_flutter/src/models/sms.dart';
import 'package:twilio_flutter/src/models/exceptions.dart';
import 'package:twilio_flutter/src/models/responses.dart';
import 'package:twilio_flutter/src/models/twilio_creds.dart';
import 'package:twilio_flutter/src/repositories/twilio_sms_repository.dart';
import 'package:twilio_flutter/src/repositories/twilio_mms_repository.dart';
import 'package:twilio_flutter/src/repositories/twilio_whatsapp_repository.dart';
import 'package:twilio_flutter/src/services/network.dart';
import 'package:twilio_flutter/src/utils/utils.dart';

///
/// Twilio’s Programmable SMS API helps you add robust messaging capabilities to your applications.
/// To use [TwilioFlutter] you will use your Twilio Account SID as the username and your Auth Token
/// as the password for HTTP Basic authentication with Twilio.
///
class TwilioFlutter {
  final String accountSid;
  final String authToken;
  final String twilioNumber;

  late TwilioSmsRepository _smsRepository;
  late TwilioMmsRepository _mmsRepository;
  late TwilioWhatsAppRepository _whatsAppRepository;
  late TwilioCreds _twilioCreds;

  TwilioFlutter({
    required this.accountSid,
    required this.authToken,
    required this.twilioNumber,
  }) {
    _smsRepository = TwilioSmsRepositoryImpl();
    _mmsRepository = TwilioMmsRepositoryImpl();
    _whatsAppRepository = TwilioWhatsAppRepositoryImpl();
    _twilioCreds = TwilioCreds(
      accountSid: accountSid,
      authToken: authToken,
    );
  }

  ///	sendSMS
  /// [from] : The number from which you want to send message (If you have more than one number).
  ///	[to] : The number to which text message has to be sent.
  ///	[body] : The content of the message to be sent.
  /// [statusCallback] : The url to which you want twilio to send status updates about the message.
  ///
  ///	Method called to send text messages.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<SendSmsResponse> sendSms({
    String? from,
    required String to,
    required String body,
    String? statusCallback,
  }) async {
    return await _smsRepository.sendSms(
      from: from ?? twilioNumber,
      to: to,
      body: body,
      twilioCreds: _twilioCreds,
      statusCallback: statusCallback,
    );
  }

  /// sendMMS
  /// [from] : The number from which you want to send message (If you have more than one number).
  /// [to] : The number to which text message has to be sent.
  /// [body] : The content of the message to be sent.
  /// [mediaUrl] : Url of the media which you want to send.
  /// [statusCallback] : The url to which you want twilio to send status updates about the message.
  ///
  /// Method called to send media messages.
  ///
  ///	For more status codes refer https://www.twilio.com/docs/api/errors
  Future<SendMmsResponse> sendMms({
    String? from,
    required String to,
    String? body,
    required String mediaUrl,
    String? statusCallback,
  }) async {
    return await _mmsRepository.sendMms(
      from: from ?? twilioNumber,
      to: to,
      body: body,
      mediaUrl: mediaUrl,
      twilioCreds: _twilioCreds,
      statusCallback: statusCallback,
    );
  }

  ///	sendWhatsApp
  /// [from] : The number from which you want to send message (If you have more than one number).
  ///	[to] : The number to which text message has to be sent.
  ///	[body] : The content of the message to be sent.
  /// [mediaUrl] : Url of the media which you want to send.
  ///
  ///	Method called to send whatsApp messages to the specified number with given content.
  ///
  ///	For more status codes refer
  /// * https://www.twilio.com/docs/api/errors
  Future<SendWhatsAppResponse> sendWhatsApp({
    String? from,
    required String to,
    required String body,
    String? mediaUrl,
  }) async {
    return await _whatsAppRepository.sendWhatsApp(
      from: from ?? twilioNumber,
      to: to,
      body: body,
      twilioCreds: _twilioCreds,
      mediaUrl: mediaUrl,
    );
  }

  /// Get all messages associated with your account
  /// Pass [pageSize] to get specific page sizes.
  /// [pageSize] value defaults to 20
  Future<SentSmsData> getSmsList({String? pageSize}) async {
    return await _smsRepository.getSmsList(
      pageSize: pageSize ?? '20',
      twilioCreds: _twilioCreds,
    );
  }

  /// Get all data of a specific message
  /// Pass [messageSid] as a non null Message SID.
  Future<Message> getSMS(String messageSid) async {
    return await _smsRepository.getSmsData(
      messageSID: messageSid,
      twilioCreds: _twilioCreds,
    );
  }

  @deprecated
  Future getSMSList(String url) async {
    var data = await NetworkHelper.getRequest(url);
    List<SMS> smsList = [];
    var messages = data['messages'];
    for (var message in messages) {
      SMS sms = SMS();
      sms.body = message['body'];
      sms.dateCreated = message['date_created'];
      sms.dateSent = message['date_sent'];
      sms.direction = message['direction'];
      sms.errorMessage = message['error_message'];
      sms.from = message['from'];
      sms.to = message['to'];
      sms.messageSid = message['sid'];
      sms.messageURL = message['uri'];
      sms.status = message['status'];
      smsList.add(sms);
    }
    if (smsList.isEmpty) print('Failed');
    return smsList;
  }
}
