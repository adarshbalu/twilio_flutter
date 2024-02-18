import '../../shared/dto/twilio_creds.dart';
import '../dto/message.dart';
import '../dto/sent_sms_data.dart';

abstract class TwilioSMSService {
  Future<int> sendSMS(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds});

  Future<SentSmsData> getSmsList(
      {required String? pageSize, required TwilioCreds twilioCreds});

  Future<Message> getSmsData(
      {required String messageSID, required TwilioCreds twilioCreds});

  Future<int> sendScheduledSms(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds,
      required String sendAt});
}
