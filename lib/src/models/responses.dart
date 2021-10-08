class SendSmsResponse {
  late String? sid;
  late String? dateCreated;
  late String? dateUpdated;
  late String? dateSent;
  late String? accountSid;
  late String? to;
  late String? from;
  late String? messagingServiceSid;
  late String? body;
  late String? status;
  late String? numSegments;
  late String? numMedia;
  late String? direction;
  late String? apiVerion;
  late String? price;
  late String? priceUnit;
  late String? errorCode;
  late String? errorMessage;
  late String? uri;
  late Map<String, dynamic> subresourceUris;
  late Map<String, dynamic> response;

  SendSmsResponse(Map<String, dynamic> responseBodyAsMap) {
    response = responseBodyAsMap;
    sid = response['sid'];
    dateCreated = response['date_created'];
    dateUpdated = response['date_updated'];
    dateSent = response['date_sent'];
    accountSid = response['account_sid'];
    to = response['to'];
    from = response['from'];
    messagingServiceSid = response['messaging_service_sid'];
    body = response['body'];
    status = response['status'];
    numSegments = response['num_segments'];
    numMedia = response['num_media'];
    direction = response['direction'];
    apiVerion = response['api_version'];
    price = response['price'];
    priceUnit = response['price_unit'];
    errorCode = response['error_code'];
    errorMessage = response['error_message'];
    uri = response['uri'];
    subresourceUris = response['subresource_uris'];
  }

  String toString() {
    return response.toString();
  }
}

class SendMmsResponse {
  late String? sid;
  late String? dateCreated;
  late String? dateUpdated;
  late String? dateSent;
  late String? accountSid;
  late String? to;
  late String? from;
  late String? messagingServiceSid;
  late String? body;
  late String? status;
  late String? numSegments;
  late String? numMedia;
  late String? direction;
  late String? apiVerion;
  late String? price;
  late String? priceUnit;
  late String? errorCode;
  late String? errorMessage;
  late String? uri;
  late Map<String, dynamic> subresourceUris;
  late Map<String, dynamic> response;

  SendMmsResponse(Map<String, dynamic> responseBodyAsMap) {
    response = responseBodyAsMap;
    sid = response['sid'];
    dateCreated = response['date_created'];
    dateUpdated = response['date_updated'];
    dateSent = response['date_sent'];
    accountSid = response['account_sid'];
    to = response['to'];
    from = response['from'];
    messagingServiceSid = response['messaging_service_sid'];
    body = response['body'];
    status = response['status'];
    numSegments = response['num_segments'];
    numMedia = response['num_media'];
    direction = response['direction'];
    apiVerion = response['api_version'];
    price = response['price'];
    priceUnit = response['price_unit'];
    errorCode = response['error_code'];
    errorMessage = response['error_message'];
    uri = response['uri'];
    subresourceUris = response['subresource_uris'];
  }

  String toString() {
    return response.toString();
  }
}

class SendWhatsAppResponse {
  late String? sid;
  late String? dateCreated;
  late String? dateUpdated;
  late String? dateSent;
  late String? accountSid;
  late String? to;
  late String? from;
  late String? messagingServiceSid;
  late String? body;
  late String? status;
  late String? numSegments;
  late String? numMedia;
  late String? direction;
  late String? apiVerion;
  late String? price;
  late String? priceUnit;
  late String? errorCode;
  late String? errorMessage;
  late String? uri;
  late Map<String, dynamic> subresourceUris;
  late Map<String, dynamic> response;

  SendWhatsAppResponse(Map<String, dynamic> responseBodyAsMap) {
    response = responseBodyAsMap;
    sid = response['sid'];
    dateCreated = response['date_created'];
    dateUpdated = response['date_updated'];
    dateSent = response['date_sent'];
    accountSid = response['account_sid'];
    to = response['to'];
    from = response['from'];
    messagingServiceSid = response['messaging_service_sid'];
    body = response['body'];
    status = response['status'];
    numSegments = response['num_segments'];
    numMedia = response['num_media'];
    direction = response['direction'];
    apiVerion = response['api_version'];
    price = response['price'];
    priceUnit = response['price_unit'];
    errorCode = response['error_code'];
    errorMessage = response['error_message'];
    uri = response['uri'];
    subresourceUris = response['subresource_uris'];
  }

  String toString() {
    return response.toString();
  }
}
