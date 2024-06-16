import 'package:twilio_flutter/src/shared/dto/error_data.dart';
import 'package:twilio_flutter/src/shared/enums/response_state.dart';

class TwilioResponse {
  final int responseCode;
  final ResponseState responseState;
  late ErrorData? errorData;
  late Map<String, dynamic>? metadata;

  @override
  String toString() {
    return 'TwilioResponse{responseCode: $responseCode,'
        ' responseState: $responseState, '
        'exception: $errorData, '
        'metadata: $metadata}';
  }

  TwilioResponse(
      {required this.responseCode,
      required this.responseState,
      required this.errorData,
      required this.metadata});

  factory TwilioResponse.fromJson(
      {Map<String, dynamic>? metadata,
      required int responseCode,
      ErrorData? errorData}) {
    ResponseState responseState = ResponseState.FAILED;
    if (responseCode == 200 || responseCode == 201)
      responseState = ResponseState.SUCCESS;
    return TwilioResponse(
        responseCode: responseCode,
        responseState: responseState,
        errorData: errorData,
        metadata: metadata);
  }
}
