import 'package:http/http.dart' as http;
import 'package:twilio_flutter/src/shared/dto/twilio_creds.dart';
import 'package:twilio_flutter/src/shared/dto/twilio_response.dart';
import 'package:twilio_flutter/src/shared/enums/request_type.dart';
import 'package:twilio_flutter/src/shared/services/network.dart';
import 'package:twilio_flutter/src/shared/utils/log_helper.dart';
import 'package:twilio_flutter/src/shared/utils/request_utils.dart';
import 'package:twilio_flutter/src/verify/repository/twilio_verify_repository.dart';

class TwilioVerifyRepositoryImpl extends TwilioVerifyRepository {
  final logger = LogHelper(className: 'TwilioVerifyRepositoryImpl');

  @override
  Future<TwilioResponse> createVerificationService(
      {required TwilioCreds twilioCreds, required String serviceName}) async {
    final headers =
        RequestUtils.generateHeaderWithBase64(twilioCreds.authString);
    final body = {
      'FriendlyName': serviceName,
    };
    final String url = RequestUtils.generateCreateVerifyServiceUrl();
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, body: body, requestType: RequestType.POST);
    logger.info("Verification service request sent");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<TwilioResponse> sendVerificationCode(
      {required TwilioCreds twilioCreds,
      required String verificationServiceId,
      required String recipient,
      required String verificationChannel}) async {
    final headers =
        RequestUtils.generateHeaderWithBase64(twilioCreds.authString);
    final body = {'To': recipient, 'Channel': verificationChannel};
    final String url =
        RequestUtils.generateSendVerifyCodeUrl(verificationServiceId);
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, body: body, requestType: RequestType.POST);
    logger.info(
        "Verification code sent via [$verificationChannel] to [$recipient]");
    return handleRequest(response: response, requestType: RequestType.POST);
  }

  @override
  Future<TwilioResponse> verifyCode(
      {required TwilioCreds twilioCreds,
      required String verificationServiceId,
      required String recipient,
      required String code}) async {
    final headers =
        RequestUtils.generateHeaderWithBase64(twilioCreds.authString);
    final body = {'To': recipient, 'Code': code};
    final String url =
        RequestUtils.generateVerifyCodeUrl(verificationServiceId);
    final http.Response response = await NetworkHelper.handleNetworkRequest(
        url: url, headers: headers, body: body, requestType: RequestType.POST);
    logger.info(
        "Verification code [$code] for [$recipient] sent for verification");
    return handleRequest(response: response, requestType: RequestType.POST);
  }
}
