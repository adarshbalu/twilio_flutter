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
