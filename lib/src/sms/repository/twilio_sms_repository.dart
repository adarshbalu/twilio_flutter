import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messaging_service_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/services/network_repository.dart';

abstract class TwilioSmsRepository extends NetworkRepository {
  Future<TwilioResponse> getSmsList(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<TwilioResponse> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      String? fromNumber});

  Future<TwilioResponse> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds});

  Future<TwilioResponse> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioMessagingServiceCreds twilioCreds,
      required String sendAt,
      String? fromNumber});

  Future<TwilioResponse> cancelScheduledSms({
    required String messageSid,
    required TwilioMessagingServiceCreds twilioCreds,
  });

  Future<int> deleteMessage(
      {required String messageSID, required TwilioCreds twilioCreds});

  Future<TwilioResponse> smsListFilterByTimePeriod(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<TwilioResponse> smsListFilterBySentBefore(
      {required String pageSize, required TwilioCreds twilioCreds});

  Future<TwilioResponse> smsListFilterByDateAndNumbers(
      {required String pageSize, required TwilioCreds twilioCreds});
}
