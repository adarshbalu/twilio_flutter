import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/messenger/repository/twilio_messenger_repository.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_messenger_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/enums/request_type.dart';
import 'package:twilio_flutter/src/shared/services/network.dart';
import 'package:twilio_flutter/src/shared/utils/log_helper.dart';
import 'package:twilio_flutter/src/shared/utils/request_utils.dart';

class TwilioMessengerRepositoryImpl extends TwilioMessengerRepository {
  final logger = LogHelper(className: 'TwilioMessengerRepositoryImpl');

  @override
  Future<TwilioResponse> sendMessenger(
      {required String recipientIdentifier,
      required String messageBody,
      required TwilioMessengerCreds twilioCreds,
      String? senderIdentifier}) async {
    final headers = RequestUtils.generateHeaderWithBase64(twilioCreds.cred);

    final body = {
      'From': 'messenger:' + (senderIdentifier ?? twilioCreds.messengerId),
      'To': 'messenger:' + recipientIdentifier,
      'Body': messageBody
    };
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: twilioCreds.url,
        headers: headers,
        body: body,
        requestType: RequestType.POST);
    logger
        .info("Messenger text Sent to [$recipientIdentifier] - [$messageBody]");
    return handleRequest(response: response, requestType: RequestType.POST);
  }
}
