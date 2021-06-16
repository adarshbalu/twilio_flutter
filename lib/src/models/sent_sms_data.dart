//     final sentSmsData = sentSmsDataFromJson(jsonString);

import 'dart:convert';

SentSmsData sentSmsDataFromJson(String str) =>
    SentSmsData.fromJson(json.decode(str));

String sentSmsDataToJson(SentSmsData data) => json.encode(data.toJson());

class SentSmsData {
  SentSmsData({
    required this.end,
    required this.firstPageUri,
    required this.nextPageUri,
    required this.page,
    required this.pageSize,
    required this.previousPageUri,
    required this.messages,
    required this.start,
    required this.uri,
  });

  final int? end;
  final String? firstPageUri;
  final String? nextPageUri;
  final int? page;
  final int? pageSize;
  final String? previousPageUri;
  final List<Message> messages;
  final int? start;
  final String? uri;

  factory SentSmsData.fromJson(Map<String, dynamic> json) => SentSmsData(
        end: json["end"],
        firstPageUri: json["first_page_uri"],
        nextPageUri: json["next_page_uri"],
        page: json["page"],
        pageSize: json["page_size"],
        previousPageUri: json["previous_page_uri"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        start: json["start"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "end": end,
        "first_page_uri": firstPageUri,
        "next_page_uri": nextPageUri,
        "page": page,
        "page_size": pageSize,
        "previous_page_uri": previousPageUri,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "start": start,
        "uri": uri,
      };
}

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

class SubresourceUris {
  SubresourceUris({
    required this.media,
    required this.feedback,
  });

  final String? media;
  final String? feedback;

  factory SubresourceUris.fromJson(Map<String, dynamic> json) =>
      SubresourceUris(
        media: json["media"],
        feedback: json["feedback"],
      );

  Map<String, dynamic> toJson() => {
        "media": media,
        "feedback": feedback,
      };
}
