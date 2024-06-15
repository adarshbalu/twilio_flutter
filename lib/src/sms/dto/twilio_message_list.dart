import 'dart:convert';

import 'twilio_message.dart';

TwilioMessageList sentSmsDataFromJson(String str) =>
    TwilioMessageList.fromJson(json.decode(str));

String sentSmsDataToJson(TwilioMessageList data) => json.encode(data.toJson());

class TwilioMessageList {
  TwilioMessageList({
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
  final List<TwilioMessage> messages;
  final int? start;
  final String? uri;

  factory TwilioMessageList.fromJson(Map<String, dynamic> json) =>
      TwilioMessageList(
        end: json["end"],
        firstPageUri: json["first_page_uri"],
        nextPageUri: json["next_page_uri"],
        page: json["page"],
        pageSize: json["page_size"],
        previousPageUri: json["previous_page_uri"],
        messages: List<TwilioMessage>.from(
            json["messages"].map((x) => TwilioMessage.fromJson(x))),
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
