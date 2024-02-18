import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/whatsapp/repositories/twilio_whatsapp_repository.dart';

import '../../shared/services/network.dart';
import '../../shared/services/service_locator.dart';
import '../../shared/utils/log_helper.dart';
import '../../shared/utils/request_utils.dart';

class TwilioWhatsAppRepositoryImpl extends TwilioWhatsAppRepository {
  late http.Client client;

  TwilioSMSRepositoryImpl() {
    client = locator.get<http.Client>(instanceName: "http.client");
  }

  final logger = LogHelper(className: 'TwilioWhatsAppRepositoryImpl');

  @override
  Future<int> sendWhatsAppMessage(
      {required String toNumber,
      required String messageBody,
      required TwilioCreds twilioCreds}) async {
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);

    final body = {
      'From': 'whatsapp:' + twilioCreds.twilioNumber,
      'To': 'whatsapp:' + toNumber,
      'Body': messageBody
    };
    final http.Response response =
        await NetworkHelper.createRequest(twilioCreds.url, headers, body);
    logger.info("Whatsapp Message Sent to [$toNumber] - [$messageBody]");
    return response.statusCode;
  }
}
