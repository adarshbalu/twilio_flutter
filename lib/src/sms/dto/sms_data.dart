import 'dart:convert';

import 'message.dart';

SmsData sentSmsDataFromJson(String str) => SmsData.fromJson(json.decode(str));

String sentSmsDataToJson(SmsData data) => json.encode(data.toJson());

class SmsData {
  SmsData({
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

  factory SmsData.fromJson(Map<String, dynamic> json) => SmsData(
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
