import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/sms/dto/sms_data.dart';

import '../dto/message.dart';

abstract class TwilioSmsRepository {
  Future<SmsData> getSmsList(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber});

  Future<Message> getSmsData(
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

  Future<SmsData> smsListFilterByTimePeriod(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<SmsData> smsListFilterBySentBefore(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<SmsData> smsListFilterByDateAndNumbers(
      {required String pageSize, required TwilioCreds twilioCreds});
}
