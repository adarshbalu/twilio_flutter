/// [TwilioWhatsAppTemplate] can be used to send WhatsApp messages using Twilio Templates. It contains the [contentSid] which is the unique identifier for the template and [contentVariables] which is a map of variables to be replaced in the template. The [toJson] method converts the object to a JSON format that can be sent in the API request.

class TwilioWhatsAppTemplate {
  final String contentSid;
  final Map<String, dynamic>? contentVariables;

  TwilioWhatsAppTemplate({required this.contentSid, this.contentVariables});

  @override
  String toString() {
    return 'TwilioWhatsAppTemplate{contentSid: $contentSid, contentVariables: $contentVariables}';
  }
}
