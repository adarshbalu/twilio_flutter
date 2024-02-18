import 'subresource_uris.dart';

class Message {
  Message({
    required this.accountSid,
    required this.apiVersion,
    required this.body,
    required this.dateCreated,
    required this.dateSent,
    required this.dateUpdated,
    required this.direction,
    required this.errorCode,
    required this.errorMessage,
    required this.from,
    required this.messagingServiceSid,
    required this.numMedia,
    required this.numSegments,
    required this.price,
    required this.priceUnit,
    required this.sid,
    required this.status,
    required this.subresourceUris,
    required this.to,
    required this.uri,
  });

  final String? accountSid;
  final DateTime apiVersion;
  final String? body;
  final String? dateCreated;
  final String? dateSent;
  final String? dateUpdated;
  final String? direction;
  final int? errorCode;
  final String? errorMessage;
  final String? from;
  final dynamic messagingServiceSid;
  final String? numMedia;
  final String? numSegments;
  final String? price;
  final String? priceUnit;
  final String? sid;
  final String? status;
  final SubresourceUris subresourceUris;
  final String? to;
  final String? uri;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        accountSid: json["account_sid"],
        apiVersion: DateTime.parse(json["api_version"]),
        body: json["body"],
        dateCreated: json["date_created"],
        dateSent: json["date_sent"],
        dateUpdated: json["date_updated"],
        direction: json["direction"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        from: json["from"],
        messagingServiceSid: json["messaging_service_sid"],
        numMedia: json["num_media"],
        numSegments: json["num_segments"],
        price: json["price"],
        priceUnit: json["price_unit"],
        sid: json["sid"],
        status: json["status"],
        subresourceUris: SubresourceUris.fromJson(json["subresource_uris"]),
        to: json["to"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "account_sid": accountSid,
        "api_version":
            "${apiVersion.year.toString().padLeft(4, '0')}-${apiVersion.month.toString().padLeft(2, '0')}-${apiVersion.day.toString().padLeft(2, '0')}",
        "body": body,
        "date_created": dateCreated,
        "date_sent": dateSent,
        "date_updated": dateUpdated,
        "direction": direction,
        "error_code": errorCode == null ? null : errorCode,
        "error_message": errorMessage == null ? null : errorMessage,
        "from": from,
        "messaging_service_sid": messagingServiceSid,
        "num_media": numMedia,
        "num_segments": numSegments,
        "price": price,
        "price_unit": priceUnit,
        "sid": sid,
        "status": status,
        "subresource_uris": subresourceUris.toJson(),
        "to": to,
        "uri": uri,
      };
}
