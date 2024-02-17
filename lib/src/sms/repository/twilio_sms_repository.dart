import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/sms/dto/sent_sms_data.dart';

abstract class TwilioSmsRepository {
  Future<SentSmsData> getSmsList(
      {required String pageSize, required TwilioCreds? twilioCreds});

  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds});

  Future<Message> getSmsData(
      {required String messageSID, required TwilioCreds? twilioCreds});

  Future<int> deleteMessage(
      {required String messageSID, required TwilioCreds twilioCreds});

  Future<SentSmsData> smsListFilterByTimePeriod(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<SentSmsData> smsListFilterBySentBefore(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<SentSmsData> smsListFilterByDateAndNumbers(
      {required String pageSize, required TwilioCreds twilioCreds});
}
