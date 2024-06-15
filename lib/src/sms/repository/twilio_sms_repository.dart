import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/sms/dto/twilio_message_list.dart';

import '../dto/twilio_message.dart';

abstract class TwilioSmsRepository {
  Future<TwilioMessageList> getSmsList(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber});

  Future<TwilioMessage> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds});

  Future<int> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt,
      String? fromNumber});

  Future<int> cancelScheduledSms({
    required String messageSid,
    required TwilioMessagingServiceCreds twilioCreds,
  });

  Future<int> deleteMessage(
      {required String messageSID, required TwilioCreds twilioCreds});

  Future<TwilioMessageList> smsListFilterByTimePeriod(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<TwilioMessageList> smsListFilterBySentBefore(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<TwilioMessageList> smsListFilterByDateAndNumbers(
      {required String pageSize, required TwilioCreds twilioCreds});
}
